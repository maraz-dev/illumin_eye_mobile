import 'package:http/http.dart';

class ResponseHandler {
  dynamic handleResponse({
    required Response response,
    required Function onSuccess,
  }) {
    try {
      if (response.statusCode != 200) {
        throw "${response.statusCode}: ${response.body}";
      } else {
        return onSuccess();
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
