import 'package:sigev/config/dependency_injection.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/api_constants.dart';
import 'package:sigev/core/services/api_service.dart';
import 'package:sigev/core/utilities/utilities_headers.dart';
import 'package:sigev/domain/models/barra_fija.dart';
import 'package:sigev/domain/models/user.dart';
import 'package:sigev/config/globals.dart' as globals;
import 'package:sigev/domain/repositories/user_repository.dart';

class UserProvider implements UserRepository {
  final ApiService _apiService = getIt<ApiService>();

  @override
  Future<BarraFija> getBarraFija() async {
    try {
      final dynamic response = await _apiService.getRequest(
        ApiConstants.barrafijaEndpoint,
        UtilitiesHeaders.getHeader(),
      );
      BarraFija barraFija = barraFijaFromJson(response);
      return barraFija;
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<User> getClientePorCorreo({required String correo}) async {
    try {
      final dynamic response = await _apiService.getRequest(
        "${ApiConstants.getClientePorCorreoEndpoint}/$correo",
        UtilitiesHeaders.getHeader(),
      );
      User user = userFromJsonData(response);
      return user;
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<void> apiDeleteUser() async {
    try {
      await _apiService.postRequest(
        ApiConstants.apiDeleteUserEndpoint,
        {},
        UtilitiesHeaders.getHeader(),
      );
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<void> getUser() async {
    try {
      final dynamic response = await _apiService.getRequest(
        ApiConstants.getUserEndpoint,
        UtilitiesHeaders.getHeader(),
      );
      User user = userFromJsonData(response);
      globals.user = user;
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }
}
