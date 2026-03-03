import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigev/config/dependency_injection.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/services/api_service.dart';
import 'package:sigev/core/utilities/utilities_headers.dart';
import 'package:sigev/domain/models/chats.dart';
import 'package:sigev/domain/repositories/chat_repository.dart';

class ChatProvider implements ChatRepository {
  final String _generarNuevoChat = "generarNuevoChat";
  final String _finalizarChat = "finalizarChat";
  final String _obtenerMensajesChat = "obtenerMensajesChat";
  final String _guardarMensaje = "guardarMensaje";
  final ApiService _apiService = getIt<ApiService>();
  @override
  Future<int> generarNuevoChat({required String claveTramite}) async {
    try {
      final dynamic response = await _apiService.postRequest(
        _generarNuevoChat,
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
      final dynamic response = await _apiService.postRequest(
        _finalizarChat,
        {'pkChatBarraFija': pkChatBarraFija},
        UtilitiesHeaders.getHeaderSinToken(),
        isChat: true,
      );
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
        "$_obtenerMensajesChat?claveTramite=$claveTramite",
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
