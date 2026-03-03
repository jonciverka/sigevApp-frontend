import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigev/config/dependency_injection.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/api_constants.dart';
import 'package:sigev/core/services/api_service.dart';
import 'package:sigev/core/utilities/utilities_headers.dart';
import 'package:sigev/domain/models/bot.dart';
import 'package:sigev/domain/repositories/bot_repository.dart';

class BotProvider implements BotRepository {
  final ApiService _apiService = getIt<ApiService>();
  @override
  Future<List<CategoriaBot>> obtenerCategorias() async {
    try {
      final dynamic response = await _apiService.getRequest(
        ApiConstants.apiObtenerCategorias,
        UtilitiesHeaders.getHeaderSinToken(),
        isChat: true,
      );
      var responseJSON = json.decode(response)["data"];
      return categoriaBotsFromJsonList(responseJSON);
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<List<CategoriaBot>> obtenerSubCategorias({
    required String pkCategoria,
  }) async {
    try {
      final dynamic response = await _apiService.getRequest(
        "${ApiConstants.apiObtenerSubCategorias}?pkCategoria=$pkCategoria",
        UtilitiesHeaders.getHeaderSinToken(),
        isChat: true,
      );
      var responseJSON = json.decode(response)["data"];
      return categoriaBotsFromJsonList(responseJSON);
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<List<PreguntaBot>> obtenerPreguntas({
    required String pkCategoria,
  }) async {
    try {
      final dynamic response = await _apiService.getRequest(
        "${ApiConstants.apiObtenerPreguntas}?pkCategoria=$pkCategoria",
        UtilitiesHeaders.getHeaderSinToken(),
        isChat: true,
      );
      var responseJSON = json.decode(response)["data"];
      return preguntaBotsFromJsonList(responseJSON);
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<List<RespuestaBot>> obtenerRespuestas({
    required String pkPregunta,
  }) async {
    try {
      final dynamic response = await _apiService.getRequest(
        "${ApiConstants.apiObtenerRespuestas}?pkPregunta=$pkPregunta",
        UtilitiesHeaders.getHeaderSinToken(),
        isChat: true,
      );

      var responseJSON = json.decode(response)["data"];
      return respuestaBotsFromJsonList(responseJSON);
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }
}
