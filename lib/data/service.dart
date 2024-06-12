import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Replace with IP Address of the ESP32
const String esp32Url = 'http://192.168.4.1';

class Service {
  Future<String> sendStreetlightRequest(String endpoint) async {
    final url = '$esp32Url/$endpoint';
    try {
      final response = await http.get(Uri.parse(url));
      if (kDebugMode) {
        print(url);
      }
      if (response.statusCode == 200) {
        if (endpoint == 'H') {
          return 'Streetlight ON';
        } else if (endpoint == 'L') {
          return 'Streetlight OFF';
        } else if (endpoint == '') {
          final parsedResponse = jsonDecode(response.body);
          return parsedResponse['lightIntensity'].toString();
        } else {
          return '';
        }
      } else {
        if (kDebugMode) {
          print('Error: ${response.statusCode}');
        }
        throw response.statusCode;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
      }
      throw e.toString();
    }
  }

  // Future<void> sendSurvellianceRequest(String endpoint) async {
  //   final url = '$esp32Url/$endpoint';
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       print('Success: ${response.body}');
  //       if (endpoint == 'status') {
  //         final parsedResponse = jsonDecode(response.body);
  //         setState(() {
  //           panAngle = parsedResponse['pan_angle'].toString();
  //           tiltAngle = parsedResponse['tilt_angle'].toString();
  //           motionDetected = parsedResponse['motion_detected'].toString();
  //         });
  //       }
  //     } else {
  //       print('Error: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Exception: $e');
  //   }
  // }
}
