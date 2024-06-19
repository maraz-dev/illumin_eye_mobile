import 'package:http/http.dart' as http;
import 'package:illumin_eye_mobile/data/remote/response_handler.dart';
import 'package:illumin_eye_mobile/main.dart';

final ResponseHandler _responseHandler = ResponseHandler();

class StreetlightService {
  // Turn ON
  Future<String> turnOnEndpoint() async {
    try {
      final response = await http.get(Uri.parse('$esp32Url/LED/on'));
      _responseHandler.handleResponse(
          response: response,
          onSuccess: () {
            return 'Turned ON';
          });
      return 'Turned ON';
    } catch (e) {
      throw e.toString();
    }
  }

  // Turn OFF
  Future<String> turnOffEndpoint() async {
    try {
      final response = await http.get(Uri.parse('$esp32Url/LED/off'));
      _responseHandler.handleResponse(
          response: response,
          onSuccess: () {
            return 'Turned OFF';
          });
      return 'Turned OFF';
    } catch (e) {
      throw e.toString();
    }
  }

  // Automatic
  Future<String> automaticEndpoint() async {
    try {
      final response = await http.get(Uri.parse('$esp32Url/LED/auto'));
      _responseHandler.handleResponse(
          response: response,
          onSuccess: () {
            return 'Automatic';
          });
      return 'Automatic';
    } catch (e) {
      throw e.toString();
    }
  }
}
