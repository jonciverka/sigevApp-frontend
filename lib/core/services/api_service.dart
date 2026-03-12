import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/api_constants.dart';
import 'package:sigev/core/constant/local_storage_keys.dart';
import 'package:sigev/core/services/crash_service.dart';
import 'dart:developer' as dev;
import 'package:sigev/config/globals.dart' as globals;
import 'package:sigev/core/utilities/utilities_headers.dart';

import 'package:sigev/domain/models/api_error_model.dart';
import 'package:sigev/domain/models/token.dart';

class ApiService {
  static const String devName = "Api Call";

  final String baseUrl = "${ApiConstants.protocol}${ApiConstants.urlBase}";
  final String baseUrlChat =
      "${ApiConstants.protocol}${ApiConstants.urlBaseChat}";
  final String extension = ApiConstants.url;

  final String noConnectionErrorMsg = "No Internet Connection";
  final String sessionExpiredMsg = "Session Expired";
  final String errorRefreshMsg = "Error Refreshing Token";

  // Método para hacer GET request

  Future<dynamic> getRequest(
    String endpoint,
    Map<String, String> headers, {
    bool isChat = false,
  }) async {
    Uri url;
    if (isChat) {
      url = Uri.parse('$baseUrlChat$extension$endpoint');
    } else {
      url = Uri.parse('$baseUrl$extension$endpoint');
    }
    try {
      dev.log("Url: ${url.toString()}", name: devName);
      final http.Response response = await http.get(url, headers: headers);
      dev.log("Response: ${response.body}", name: devName);
      return _handleResponse(
        response,
        resetTokenCallback: (headerCurrent) =>
            getRequest(endpoint, headerCurrent),
      );
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw Exception('Error en GET request: $e');
    }
  }

  // Método para hacer POST request
  Future<dynamic> postRequest(
    String endpoint,
    Map<String, dynamic> body,
    Map<String, String> headers, {
    bool isChat = false,
  }) async {
    Uri url;
    if (isChat) {
      url = Uri.parse('$baseUrlChat$extension$endpoint');
    } else {
      url = Uri.parse('$baseUrl$extension$endpoint');
    }
    try {
      dev.log("Url: ${url.toString()}", name: devName);
      dev.log("Body:${body.toString()} ", name: devName);
      final http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      dev.log("Response: ${response.body}", name: devName);
      return _handleResponse(
        response,
        resetTokenCallback: (headerCurrent) {
          postRequest(endpoint, body, headerCurrent);
        },
      );
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw Exception('Error en POST request: $e');
    }
  }

  Future<dynamic> postRequestFile(
    String endpoint,
    Map<String, dynamic> body,
    Map<String, String> headers, {
    bool isChat = false,
  }) async {
    Uri url;
    if (isChat) {
      url = Uri.parse('$baseUrlChat$extension$endpoint');
    } else {
      url = Uri.parse('$baseUrl$extension$endpoint');
    }
    try {
      dev.log("Url: ${url.toString()}", name: devName);
      final http.Response response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      dev.log("Response: ${response.body}", name: devName);
      return _handleResponse(
        response,
        resetTokenCallback: (headerCurrent) {
          postRequest(endpoint, body, headerCurrent);
        },
      );
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw Exception('Error en POST request: $e');
    }
  }

  Future<dynamic> postWithoutBodyRequest(
    String endpoint,
    Map<String, String> headers,
  ) async {
    final Uri url = Uri.parse('$baseUrl$extension$endpoint');
    try {
      final http.Response response = await http.post(url, headers: headers);
      dev.log(url.toString());

      return _handleResponse(
        response,
        resetTokenCallback: (headerCurrent) {
          postWithoutBodyRequest(endpoint, headerCurrent);
        },
      );
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw Exception('Error en POST request: $e');
    }
  }

  // Método para hacer PUT request
  Future<dynamic> putRequest(
    String endpoint,
    Map<String, String> headers, {
    Map<String, dynamic>? body,
  }) async {
    final Uri url = Uri.parse('$baseUrl$extension$endpoint');
    try {
      final http.Response response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      dev.log(url.toString());
      dev.log(jsonEncode(body));
      return _handleResponse(
        response,
        resetTokenCallback: (headerCurrent) {
          putRequest(endpoint, headerCurrent, body: body);
        },
      );
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw Exception('Error en PUT request: $e');
    }
  }

  // Método para hacer PATCH request
  Future<dynamic> patchRequest(
    String endpoint,
    Map<String, dynamic> data,
    Map<String, String> headers,
  ) async {
    final Uri url = Uri.parse('$baseUrl$extension$endpoint');
    try {
      final http.Response response = await http.patch(
        url,
        headers: headers,
        body: jsonEncode(data),
      );
      return _handleResponse(
        response,
        resetTokenCallback: (headerCurrent) {
          patchRequest(endpoint, data, headerCurrent);
        },
      );
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw Exception('Error en PATCH request: $e');
    }
  }

  // Método para hacer DELETE request
  Future<dynamic> deleteRequest(
    String endpoint,
    Map<String, String> headers,
  ) async {
    final Uri url = Uri.parse('$baseUrl$extension$endpoint');
    try {
      final http.Response response = await http.delete(url, headers: headers);
      return _handleResponse(
        response,
        resetTokenCallback: (headerCurrent) {
          deleteRequest(endpoint, headerCurrent);
        },
      );
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw Exception('Error en DELETE request: $e');
    }
  }

  Future<dynamic> putRequestWithUrl(
    String urlString,
    Map<String, String> headers, {
    Map<String, dynamic>? body,
  }) async {
    final Uri url = Uri.parse(urlString);
    try {
      final http.Response response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      dev.log(url.toString(), name: 'Request Endpoint');
      dev.log(jsonEncode(body), name: 'Request Body');
      return _handleResponse(
        response,
        resetTokenCallback: (headerCurrent) {
          putRequestWithUrl(urlString, headerCurrent, body: body);
        },
      );
    } catch (e) {
      throw Exception('Error en PUT request: $e');
    }
  }

  // Manejo de la respuesta
  dynamic _handleResponse(
    http.Response response, {
    required Function(Map<String, String>) resetTokenCallback,
  }) async {
    switch (response.statusCode) {
      case 200:
        dev.log(response.body);
        return response.body;
      case 401:
        await resetToken(UtilitiesHeaders.getHeaderRefresh());
        return resetTokenCallback(UtilitiesHeaders.getHeader());
      case 500:
        throw ServerErrorException();
      default:
        if (response.body.isNotEmpty) {
          final ApiErrorModel res = ApiErrorModel.fromJson(
            jsonDecode(response.body),
          );
          CrashService.recordError(
            res.message ?? '',
            stackTrace: StackTrace.current,
          );
          throw ApiClientException(
            response.statusCode,
            res.message ?? '',
            code: res.code,
          );
        } else {
          return "";
        }
    }
  }

  Future<void> resetToken(Map<String, String> headers) async {
    try {
      final Uri url = Uri.parse(
        '$baseUrl$extension${ApiConstants.refreshTokenEndpoint}',
      );
      dev.log(url.toString());

      final http.Response response = await http.post(url, headers: headers);

      if (response.statusCode == 400) {
        // Token res = tokenFromJson(response.body);
        // if (res.code == "1") {
        //   throw ' ${res.message}';
        // } else if (res.code == "2") {
        //   throw ' ${res.message}';
        // }
      } else if (response.statusCode == 401) {
        throw SessionExpiredException();
      } else if (response.statusCode == 200) {
        Token token = tokenFromJson(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(LocalStorageKeys.keyAccesToken, token.accessToken!);
        globals.token = token.accessToken!;
        return;
      } else {
        throw RefreshingErrorException(
          msg: 'StatusCode: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error en GET request: $e');
    }
  }

  Future<void> makeRequest(String url, Map<String, String> headers) async {
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      dev.log('Response status: ${response.statusCode}');
    } catch (e) {
      dev.log('Error: $e');
    }
  }
}
