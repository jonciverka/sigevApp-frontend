class ApiClientException implements Exception {
  const ApiClientException(this.statusCode, this.message, {this.code});
  final int statusCode;
  final String message;
  final String? code;
}

class ResourceNotFoundException implements Exception {}

class NetworkException implements Exception {}

class SessionExpiredException implements Exception {}

class ServerErrorException implements Exception {}

class RefreshingErrorException implements Exception {
  final String msg;
  const RefreshingErrorException({required this.msg});
}
