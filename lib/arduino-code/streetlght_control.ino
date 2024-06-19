#include <WiFi.h>
#include <WiFiClient.h>
#include <WiFiAP.h>

const int LDR_PIN = 34;   // LDR pin connected to IO34
const int MOSFET_PIN = 12; // MOSFET gate pin connected to IO12
const int LIGHT_THRESHOLD = 300; // Threshold value for light intensity

const char *ssid = "illumineye";

// Static IP configuration
IPAddress local_IP(172, 16, 16, 31); // Choose an IP outside the DHCP range
IPAddress gateway(172, 16, 16, 254); // Default gateway IP from ipconfig/ifconfig
IPAddress subnet(255, 255, 255, 0); // Subnet mask from ipconfig/ifconfig

WiFiServer server(80);

bool manualControl = false; // Flag to indicate manual control mode
bool lightState = false;    // State of the light
unsigned long lastManualControlTime = 0; // Timestamp of the last manual control action
const unsigned long manualControlTimeout = 60000; // 1 minute timeout for manual control

void setup() {
  pinMode(LDR_PIN, INPUT);
  pinMode(MOSFET_PIN, OUTPUT);

  Serial.begin(115200);
  Serial.println();
  Serial.println("Configuring access point...");

  // Set the static IP address
  if (!WiFi.softAPConfig(local_IP, gateway, subnet)) {
    Serial.println("Failed to configure AP with static IP");
  }

  // Start the access point
  WiFi.softAP(ssid);
  IPAddress myIP = WiFi.softAPIP();
  Serial.print("AP IP Address: ");
  Serial.println(myIP);
  server.begin();
  Serial.println("Server Started");
}

void loop() {
  WiFiClient client = server.available(); // Listen for incoming clients

  if (client) {
    Serial.println("New Client.");
    String currentLine = ""; // Make a String to hold incoming data from the client
    while (client.connected()) { // Loop while the client's connected
      if (client.available()) { // If there's bytes to read from the client,
        char c = client.read(); // Read a byte
        Serial.write(c); // Print it out the serial monitor
        if (c == '\n') { // If the byte is a newline character
          // If the current line is blank, you got two newline characters in a row.
          // That's the end of the client HTTP request, so send a response:
          if (currentLine.length() == 0) {
            // HTTP headers always start with a response code (e.g. HTTP/1.1 200 OK)
            // and a content-type so the client knows what's coming, then a blank line:
            client.println("HTTP/1.1 200 OK");
            client.println("Content-type:text/html");
            client.println();
            
            // Display the HTML web page
            client.println("<!DOCTYPE html><html>");
            client.println("<head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
            client.println("<link rel=\"icon\" href=\"data:,\">");
            // CSS styling
            client.println("<style>html { font-family: Helvetica; display: inline-block; margin: 0px auto; text-align: center;}");
            client.println(".button { background-color: #4CAF50; border: none; color: white; padding: 16px 40px;");
            client.println("text-decoration: none; font-size: 30px; margin: 2px; cursor: pointer;}");
            client.println(".button2 {background-color: #555555;}</style></head>");

            // Setting Heading of HTML Page
            client.println("<h1>IlluminEye</h1>");
            client.print("<p><a href=\"/LED/on\"><button class=\"button\">ON</button></a></p>");
            client.print("<p><a href=\"/LED/off\"><button class=\"button button2\">OFF</button></a></p><br>");
            client.print("<p><a href=\"/LED/auto\"><button class=\"button button2\">AUTO</button></a></p><br>");
            client.println();
            break;
          } else {
            currentLine = ""; // Clear the current line
          }
        } else if (c != '\r') { // If you got anything else but a carriage return character,
          currentLine += c; // Add it to the end of the currentLine
        }

        // Check to see if the client request was "GET /LED/on", "GET /LED/off" or "GET /LED/auto":
        if (currentLine.endsWith("GET /LED/on")) {
          manualControl = true; // Switch to manual control
          lastManualControlTime = millis(); // Update the manual control timestamp
          lightState = true;
          digitalWrite(MOSFET_PIN, HIGH); // Turn the LED on
        }
        if (currentLine.endsWith("GET /LED/off")) {
          manualControl = true; // Switch to manual control
          lastManualControlTime = millis(); // Update the manual control timestamp
          lightState = false;
          digitalWrite(MOSFET_PIN, LOW); // Turn the LED off
        }
        if (currentLine.endsWith("GET /LED/auto")) {
          manualControl = false; // Switch to automatic control
        }
      }
    }
    // Close the connection:
    client.stop();
    Serial.println("Client Disconnected.");
  }

  // Check for manual control timeout
  if (manualControl && millis() - lastManualControlTime > manualControlTimeout) {
    manualControl = false; // Switch back to automatic control after timeout
  }

  // If not in manual control, control the light based on LDR:
  if (!manualControl) {
    int lightIntensity = analogRead(LDR_PIN); // Read the LDR value

    // Control the MOSFET based on light intensity:
    if (lightIntensity < LIGHT_THRESHOLD) {
      lightState = true;
      digitalWrite(MOSFET_PIN, HIGH); // Turn on the light if it's dark
    } else {
      lightState = false;
      digitalWrite(MOSFET_PIN, LOW); // Turn off the light if it's bright
    }
  }
}
