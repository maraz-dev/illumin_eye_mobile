import 'package:http/http.dart' as http;
import 'package:illumin_eye_mobile/data/remote/response_handler.dart';
import 'package:illumin_eye_mobile/main.dart';

final ResponseHandler _responseHandler = ResponseHandler();

class SurvellianceService {
  // Tilt Up
  Future<String> tiltUpEndpoint() async {
    try {
      final response =
          await http.get(Uri.parse('$esp32Url/control?action=tilt_up'));
      _responseHandler.handleResponse(
          response: response,
          onSuccess: () {
            return 'Tilted Up';
          });
      return 'Tilted Up';
    } catch (e) {
      throw e.toString();
    }
  }

  // Tilt Down
  Future<String> tiltDownEndpoint() async {
    try {
      final response =
          await http.get(Uri.parse('$esp32Url/control?action=tilt_down'));
      _responseHandler.handleResponse(
          response: response,
          onSuccess: () {
            return 'Tilted Down';
          });
      return 'Tilted Down';
    } catch (e) {
      throw e.toString();
    }
  }

  // Center
  Future<String> centerEndpoint() async {
    try {
      final response =
          await http.get(Uri.parse('$esp32Url/control?action=center'));
      _responseHandler.handleResponse(
          response: response,
          onSuccess: () {
            return 'Centered';
          });
      return 'Centered';
    } catch (e) {
      throw e.toString();
    }
  }

  // Pan Left
  Future<String> panLeftEndpoint() async {
    try {
      final response =
          await http.get(Uri.parse('$esp32Url/control?action=pan_left'));
      _responseHandler.handleResponse(
          response: response,
          onSuccess: () {
            return 'Panned Left';
          });
      return 'Panned Left';
    } catch (e) {
      throw e.toString();
    }
  }

  // Pan Right
  Future<String> panRightEndpoint() async {
    try {
      final response =
          await http.get(Uri.parse('$esp32Url/control?action=pan_right'));
      _responseHandler.handleResponse(
          response: response,
          onSuccess: () {
            return 'Panned Right';
          });
      return 'Panned Right';
    } catch (e) {
      throw e.toString();
    }
  }

  // Detect Motion
  Future<String> detectMotionEndpoint() async {
    try {
      final response = await http.get(Uri.parse('$esp32Url/status'));
      _responseHandler.handleResponse(
          response: response,
          onSuccess: () {
            return 'Motion Detected';
          });
      return 'Motion Detected';
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> streamEndpoint() async {
    try {
      final response = await http.get(Uri.parse('$esp32Url/stream'));
      _responseHandler.handleResponse(
          response: response,
          onSuccess: () {
            return 'Stream Started';
          });
      return '$esp32Url/stream';
    } catch (e) {
      throw e.toString();
    }
  }
}
