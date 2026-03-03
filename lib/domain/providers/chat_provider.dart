import 'dart:convert';

import 'package:sigev/config/dependency_injection.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/api_constants.dart';
import 'package:sigev/core/services/api_service.dart';
import 'package:sigev/core/utilities/utilities_headers.dart';
import 'package:sigev/domain/models/chats.dart';
import 'package:sigev/domain/repositories/chat_repository.dart';

class ChatProvider implements ChatRepository {
  final ApiService _apiService = getIt<ApiService>();
  @override
  Future<int> generarNuevoChat({required String claveTramite}) async {
    try {
      final dynamic response = await _apiService.postRequest(
        ApiConstants.generarNuevoChat,
        {'claveTramite': claveTramite},
        UtilitiesHeaders.getHeaderSinToken(),
        isChat: true,
      );
      var responseJSON = json.decode(response)["data"];
      return responseJSON;
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<void> finalizarChat({required String pkChatBarraFija}) async {
    try {
      // final dynamic response = await _apiService.postRequest(
      // ApiConstants.finalizarChat,
      //   {'pkChatBarraFija': pkChatBarraFija},
      //   UtilitiesHeaders.getHeaderSinToken(),
      //   isChat: true,
      // );
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<List<Mensaje>> obtenerMensajesChat({
    required String claveTramite,
  }) async {
    try {
      final dynamic response = await _apiService.getRequest(
        "${ApiConstants.obtenerMensajesChat}?claveTramite=$claveTramite",
        UtilitiesHeaders.getHeaderSinToken(),
        isChat: true,
      );
      var responseJSON = json.decode(response)["data"];
      if (responseJSON.isEmpty) return [];
      return mensajessFromJsonList(response["catCilindros"]);
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }
}
