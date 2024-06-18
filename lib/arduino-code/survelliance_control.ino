#include "esp_camera.h"
#include <WiFi.h>
#include <WebServer.h>
#include "esp_timer.h"
#include "img_converters.h"
#include "Arduino.h"
#include <ESP32Servo.h>
#include "FS.h"
#include "SD_MMC.h"
#include "driver/rtc_io.h"

// Pin definition for ESP32CAM module
#define PWDN_GPIO_NUM    32
#define RESET_GPIO_NUM   -1
#define XCLK_GPIO_NUM     0
#define SIOD_GPIO_NUM    26
#define SIOC_GPIO_NUM    27
#define Y9_GPIO_NUM      35
#define Y8_GPIO_NUM      34
#define Y7_GPIO_NUM      39
#define Y6_GPIO_NUM      36
#define Y5_GPIO_NUM      21
#define Y4_GPIO_NUM      19
#define Y3_GPIO_NUM      18
#define Y2_GPIO_NUM       5
#define VSYNC_GPIO_NUM   25
#define HREF_GPIO_NUM    23
#define PCLK_GPIO_NUM    22

// Replace with your network credentials
const char* ssid = "illumineye";
const char* password = "";

// Static IP configuration
IPAddress local_IP(172,16,16,31); // Choose an IP outside the DHCP range
IPAddress gateway(172,16,16,254); // Default gateway IP from ipconfig/ifconfig
IPAddress subnet(255,255,255,0); // Subnet mask from ipconfig/ifconfig

// PIR sensor pins
#define PIR_LEFT_PIN 12
#define PIR_RIGHT_PIN 13

#define SERVO_PAN_PIN 14
#define SERVO_TILT_PIN 15

WebServer server(80);

Servo servoPan;
Servo servoTilt;

// Initialize pan and tilt positions
int currentPanAngle = 90; // Center position
int currentTiltAngle = 90; // Center position
bool motionDetected = false;
bool motionLogged = false;
String motionDirection = "";

void setup() {
  Serial.begin(115200);

  // Set up PIR sensors
  pinMode(PIR_LEFT_PIN, INPUT);
  pinMode(PIR_RIGHT_PIN, INPUT);

  // Attach servos to their pins
  servoPan.attach(SERVO_PAN_PIN);
  servoTilt.attach(SERVO_TILT_PIN);
  servoPan.write(currentPanAngle);
  servoTilt.write(currentTiltAngle);

  Serial.println();
  Serial.println("Configuring access point...");

  // Set the static IP address
  if (!WiFi.softAPConfig(local_IP, gateway, subnet)) {
    Serial.println("Failed to configure AP with static IP");
  }

  // Start the access point
  WiFi.softAP(ssid, password);
  IPAddress myIP = WiFi.softAPIP(); 
  Serial.print("AP IP Address: ");
  Serial.println(myIP);

  if (myIP != local_IP) {
    Serial.println("Warning: IP mismatch");
  }

  server.begin();
  Serial.println("Server Started");

  // Start the camera server
  startCameraServer();
}

void loop() {
  server.handleClient();

  static unsigned long lastMotionTime = 0;
  static unsigned long lastDebounceTime = 0;
  const unsigned long debounceDelay = 200; // 200 milliseconds debounce delay
  unsigned long currentTime = millis();

  bool leftMotion = digitalRead(PIR_LEFT_PIN) == HIGH;
  bool rightMotion = digitalRead(PIR_RIGHT_PIN) == HIGH;

  if ((leftMotion || rightMotion) && (currentTime - lastDebounceTime > debounceDelay)) {
    lastDebounceTime = currentTime;
    if (leftMotion && motionDirection != "left") {
      Serial.println("Motion detected on the left!");
      motionDetected = true;
      motionDirection = "left";
      motionLogged = true;
      lastMotionTime = currentTime;
    } else if (rightMotion && motionDirection != "right") {
      Serial.println("Motion detected on the right!");
      motionDetected = true;
      motionDirection = "right";
      motionLogged = true;
      lastMotionTime = currentTime;
    }
  } else if (!leftMotion && !rightMotion) {
    motionLogged = false;
  }

  // If motion detected, move servos towards the detected direction
  if (motionDetected) {
    if (motionDirection == "left") {
      if (currentPanAngle > 0) {
        currentPanAngle -= 1;
      }
      if (currentTiltAngle < 180) {
        currentTiltAngle += 1;
      }
    } else if (motionDirection == "right") {
      if (currentPanAngle < 180) {
        currentPanAngle += 1;
      }
      if (currentTiltAngle > 0) {
        currentTiltAngle -= 1;
      }
    }
    servoPan.write(currentPanAngle);
    servoTilt.write(currentTiltAngle);
    delay(10);  // Adjust delay for smoother movement
  }

  // If no motion detected for a certain period, reset motion detection
  if (currentTime - lastMotionTime > 5000) { // 5 seconds of no motion
    motionDetected = false;
    motionDirection = "";
  }
}

void startCameraServer() {
  // Configure and initialize the camera
  camera_config_t config;
  config.ledc_channel = LEDC_CHANNEL_0;
  config.ledc_timer = LEDC_TIMER_0;
  config.pin_d0 = Y2_GPIO_NUM;
  config.pin_d1 = Y3_GPIO_NUM;
  config.pin_d2 = Y4_GPIO_NUM;
  config.pin_d3 = Y5_GPIO_NUM;
  config.pin_d4 = Y6_GPIO_NUM;
  config.pin_d5 = Y7_GPIO_NUM;
  config.pin_d6 = Y8_GPIO_NUM;
  config.pin_d7 = Y9_GPIO_NUM;
  config.pin_xclk = XCLK_GPIO_NUM;
  config.pin_pclk = PCLK_GPIO_NUM;
  config.pin_vsync = VSYNC_GPIO_NUM;
  config.pin_href = HREF_GPIO_NUM;
  config.pin_sscb_sda = SIOD_GPIO_NUM;
  config.pin_sscb_scl = SIOC_GPIO_NUM;
  config.pin_pwdn = PWDN_GPIO_NUM;
  config.pin_reset = RESET_GPIO_NUM;
  config.xclk_freq_hz = 20000000;
  config.pixel_format = PIXFORMAT_JPEG;

  if (psramFound()) {
    config.frame_size = FRAMESIZE_UXGA;
    config.jpeg_quality = 10;
    config.fb_count = 2;
  } else {
    config.frame_size = FRAMESIZE_SVGA;
    config.jpeg_quality = 12;
    config.fb_count = 1;
  }

  // Camera init
  esp_err_t err = esp_camera_init(&config);
  if (err != ESP_OK) {
    Serial.printf("Camera init failed with error 0x%x\n", err);
    return;
  }

  // Start streaming web server
  server.on("/stream", HTTP_GET, []() {
    WiFiClient client = server.client();
    String response = "HTTP/1.1 200 OK\r\n"
                      "Content-Type: multipart/x-mixed-replace; boundary=frame\r\n\r\n";
    server.sendContent(response);

    while (client.connected()) {
      camera_fb_t *fb = esp_camera_fb_get();
      if (!fb) {
        Serial.println("Camera capture failed");
        continue;
      }

      response = "--frame\r\nContent-Type: image/jpeg\r\nContent-Length: " + String(fb->len) + "\r\n\r\n";
      server.sendContent(response);
      server.sendContent((const char *)fb->buf, fb->len);
      server.sendContent("\r\n");
      esp_camera_fb_return(fb);
      delay(100); // Added to help with stability
    }
  });

  server.on("/", HTTP_GET, handleRoot);
  server.on("/control", HTTP_GET, handleControl);
  server.onNotFound(handleNotFound);

  server.begin();
  Serial.println("HTTP server started");
}

void handleRoot() {
  String html = "<html><body><h1>ESP32CAM Surveillance</h1>";
  html += "<img src=\"/stream\" width=\"640\" height=\"480\" />";
  html += "<form action=\"/control\" method=\"GET\">";
  html += "<button name=\"action\" value=\"pan_left\">Pan Left</button>";
  html += "<button name=\"action\" value=\"pan_right\">Pan Right</button>";
  html += "<button name=\"action\" value=\"tilt_up\">Tilt Up</button>";
  html += "<button name=\"action\" value=\"tilt_down\">Tilt Down</button>";
  html += "<button name=\"action\" value=\"center\">Center</button>";
  html += "</form></body></html>";
  server.send(200, "text/html", html);
}

void handleControl() {
  String action = server.arg("action");
  if (action == "pan_left") {
    smoothPanTilt(currentPanAngle - 30, currentTiltAngle);
  } else if (action == "pan_right") {
    smoothPanTilt(currentPanAngle + 30, currentTiltAngle);
  } else if (action == "tilt_up") {
    smoothPanTilt(currentPanAngle, currentTiltAngle - 30);
  } else if (action == "tilt_down") {
    smoothPanTilt(currentPanAngle, currentTiltAngle + 30);
  } else if (action == "center") {
    smoothPanTilt(90, 90);  // Move to center position
  }
  server.sendHeader("Location", "/");
  server.send(303);
}

void handleNotFound() {
  Serial.printf("404 Not Found: %s\n", server.uri().c_str());
  server.send(404, "text/plain", "Not found");
}

void smoothPanTilt(int targetPanAngle, int targetTiltAngle) {
  while (currentPanAngle != targetPanAngle || currentTiltAngle != targetTiltAngle) {
    if (currentPanAngle < targetPanAngle) {
      currentPanAngle++;
    } else if (currentPanAngle > targetPanAngle) {
      currentPanAngle--;
    }

    if (currentTiltAngle < targetTiltAngle) {
      currentTiltAngle++;
    } else if (currentTiltAngle > targetTiltAngle) {
      currentTiltAngle--;
    }

    servoPan.write(currentPanAngle);
    servoTilt.write(currentTiltAngle);

    delay(10);  // Adjust the delay for smoother or faster movement
  }
}
