import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigev/config/dependency_injection.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/local_storage_keys.dart';
import 'package:sigev/core/services/api_service.dart';
import 'package:sigev/core/utilities/utilities_headers.dart';
import 'package:sigev/domain/models/token.dart';
import 'package:sigev/domain/repositories/authentication_repository.dart';
import 'package:sigev/config/globals.dart' as globals;

class AuthenticationProvider implements AuthenticationRepository {
  final String _loginEndpoint = "login";
  final ApiService _apiService = getIt<ApiService>();
  @override
  Future<void> login({required String login, required String password}) async {
    try {
      final dynamic response = await _apiService.postRequest(_loginEndpoint, {
        'email': login,
        'password': password,
      }, UtilitiesHeaders.getHeaderSinToken());
      Token token = tokenFromJson(response);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(LocalStorageKeys.keyAccesToken, token.accessToken!);
      globals.token = token.accessToken!;
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }
}
