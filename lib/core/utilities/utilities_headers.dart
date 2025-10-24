import 'package:sigev/config/globals.dart' as globals;

class UtilitiesHeaders {
  static Map<String, String> getHeader() {
    Map<String, String> map = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${globals.token}",
    };
    return map;
  }

  static Map<String, String> getHeaderRefresh() {
    Map<String, String> map = {
      'Content-Type': 'application/json; charset=UTF-8',
      "X-Access-Token": globals.refresh,
    };
    return map;
  }

  static Map<String, String> getHeaderSinToken() {
    Map<String, String> map = {
      'Content-Type': 'application/json; charset=UTF-8',
      "X-Access-Token": globals.refresh,
    };
    return map;
  }
}
