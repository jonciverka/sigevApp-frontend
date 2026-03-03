import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/api_constants.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/chats.dart';
import 'package:sigev/domain/providers/chat_provider.dart';
import 'package:sigev/presentation/widgets/app_toast_notification.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/presentation/pages/client/tramites/cubit/tramites_support_state.dart';
import 'package:sigev/config/globals.dart' as globals;

class TramiteSupportCubit extends Cubit<TramiteSupportState> {
  final TextEditingController _textController = TextEditingController();
  get chatText => _textController;
  ChatProvider chatProvider = ChatProvider();
  BuildContext _context;

  TramiteSupportCubit({required BuildContext context, required Tramite tramite})
    : _context = context,
      super(TramiteSupportData(tramite: tramite, chats: [])) {
    inicializarInfo();
  }
  late io.Socket socket;

  inicializarInfo() async {
    await contactarSocket();
    await unirseASocket();
    //Quitar obtener mensajes y mejor valida con obtenerChat
    await obtenerMensajes();
  }

  contactarSocket() async {
    socket = io.io(
      '${ApiConstants.protocol}${ApiConstants.urlBaseChat}',
      io.OptionBuilder().setTransports(['websocket']).build(),
    );
    socket.connect();
  }

  unirseASocket() async {
    socket.on('chat message gpt', recibirMensajeSocket);
    socket.emit('join', {
      "claveTramite": state.tramite.clave ?? '',
      "pkUsuario": globals.user?.id ?? '',
    });
  }

  mandarMensaje() async {
    String mensaje = _textController.text;
    _textController.text = '';
    _textController.clear();
    var mensajeEnviado = Mensaje.mensajeLocal({
      "MENSAJE": mensaje,
      "FECHA_REGISTRO": DateTime.now(),
      "TIPO_MENSAJE": TipoMensaje.texto.value,
      "PK_USUARIO": globals.user?.id ?? '',
    });
    emit(
      TramiteSupportData(
        tramite: state.tramite,
        chats: [...state.chats, mensajeEnviado],
      ),
    );

    //CHAT GPT
    //claveTramite, mensaje, pkUsuario, tipoMensaje
    socket.emit('chat message gpt', [
      state.tramite.clave ?? '',
      mensaje,
      "${globals.user?.id ?? ''}",
      TipoMensaje.texto.value,
    ]);
  }

  //SOCKET
  recibirMensajeSocket(mensajeString) {
    var mensaje = Mensaje.fromJson(mensajeString);
    emit(
      TramiteSupportData(
        tramite: state.tramite,
        chats: [...state.chats, mensaje],
      ),
    );
  }

  //claveTramite, pkUsuario
  cerrarSocket() async {
    socket.emit('leave', {
      "claveTramite": state.tramite.clave ?? '',
      "pkUsuario": {globals.user?.id ?? ''},
    });
    socket.off(
      'chat message gpt',
      recibirMensajeSocket,
    ); // 🔑 liberar el listener
  }

  Future<void> obtenerMensajes() async {
    try {
      List<Mensaje> mensajes = await chatProvider.obtenerMensajesChat(
        claveTramite: state.tramite.clave ?? '',
      );
      if (mensajes.isEmpty) {
        emit(TramiteSupportEmpty(tramite: state.tramite));
      } else {
        emit(TramiteSupportData(tramite: state.tramite, chats: mensajes));
      }
    } on ServerErrorException {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(TramiteSupportInitial());
      return;
    } on NetworkException {
      showToastNotification(
        context: _context,
        message: AppLocale.avisoSinInternet.getString(_context),
        type: ToastType.error,
      );
      emit(TramiteSupportInitial());
      return;
    } on ApiClientException catch (e) {
      showToastNotification(
        context: _context,
        message: e.message,
        type: ToastType.error,
      );
      emit(TramiteSupportInitial());
      return;
    } catch (e) {
      showToastNotification(
        context: _context,
        message: e.toString(),
        type: ToastType.error,
      );

      emit(TramiteSupportInitial());
      return;
    }
  }

  generarNuevoChat() async {
    try {
      int idChat = await chatProvider.generarNuevoChat(
        claveTramite: state.tramite.clave ?? '',
      );
    } on ServerErrorException {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(TramiteSupportInitial());
      return;
    } on NetworkException {
      showToastNotification(
        context: _context,
        message: AppLocale.avisoSinInternet.getString(_context),
        type: ToastType.error,
      );
      emit(TramiteSupportInitial());
      return;
    } on ApiClientException catch (e) {
      showToastNotification(
        context: _context,
        message: e.message,
        type: ToastType.error,
      );
      emit(TramiteSupportInitial());
      return;
    } catch (e) {
      showToastNotification(
        context: _context,
        message: AppLocale.errorInicioSesion.getString(_context),
        type: ToastType.error,
      );

      emit(TramiteSupportInitial());
      return;
    }
  }

  @override
  Future<void> close() {
    cerrarSocket();
    return super.close();
  }
}
