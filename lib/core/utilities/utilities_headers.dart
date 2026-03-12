import 'package:sigev/config/globals.dart' as globals;

class UtilitiesHeaders {
  static Map<String, String> getHeader() {
    Map<String, String> map = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      "Authorization": "Bearer ${globals.token}",
    };
    return map;
  }

  static Map<String, String> getHeaderRefresh() {
    Map<String, String> map = {
      'Accept': 'application/json',
      "Authorization": "Bearer ${globals.token}",
    };
    return map;
  }

  static Map<String, String> getHeaderSinToken() {
    Map<String, String> map = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      "X-Access-Token": "Bearer ${globals.token}",
    };
    return map;
  }

  static Map<String, String> multipartHeader() {
    Map<String, String> map = {
      'Content-Type': 'application/octet-stream',
      'Accept': 'application/json',
      "X-Access-Token": "Bearer ${globals.token}",
    };
    return map;
  }
}
