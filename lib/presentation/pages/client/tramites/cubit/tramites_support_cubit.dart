import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/api_constants.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/core/utilities/utilities.dart';
import 'package:sigev/domain/models/bot.dart';
import 'package:sigev/domain/models/chats.dart';
import 'package:sigev/domain/providers/bot_provider.dart';
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
  BotProvider botProvider = BotProvider();
  BuildContext _context;

  TramiteSupportCubit({required BuildContext context, required Tramite tramite})
    : _context = context,
      super(TramiteSupportInitial(tramite: tramite)) {
    inicializarInfo();
  }
  late io.Socket socket;

  inicializarInfo() async {
    //Quitar obtener mensajes y mejor valida con obtenerChat
    _obtenerChatActivo();
  }

  Mensaje get volverAMenuPrincipal => Mensaje(
    fechaRegistro: DateTime.now(),
    mensaje: "Volver al menú principal",
    pkUsuario: 0,
    tipoMensaje: TipoMensaje.opcion,
    onTap: () => _quitarMensajesDeOpcionesYAgregarMensajes(
      callback: () => _obtenerCategoriasBot(mostrarCargando: false),
      mensajes: [
        Mensaje(
          fechaRegistro: DateTime.now(),
          mensaje: "Volver al menú principal",
          pkUsuario: globals.user?.id ?? 0,
          tipoMensaje: TipoMensaje.texto,
        ),
        Mensaje(
          fechaRegistro: DateTime.now(),
          pkUsuario: 0,
          mensaje: '''Estamos nuevamente en el menú principal.

Estoy listo para seguir ayudándote. Elige una opción:''',
          tipoMensaje: TipoMensaje.texto,
        ),
      ],
    ),
  );

  List<Mensaje> get iniciarChatConPersona => [
    //     Mensaje(
    //       fechaRegistro: DateTime.now(),
    //       mensaje: '''
    // Si ninguna de las opciones te puede ayudar, no te preocupes.
    // Puedes comunicarte con nuestro equipo de soporte y con gusto te ayudaremos.''',
    //       pkUsuario: 0,
    //       tipoMensaje: TipoMensaje.texto,
    //     ),
    Mensaje(
      fechaRegistro: DateTime.now(),
      mensaje: "Contactar con soporte",
      pkUsuario: 0,
      tipoMensaje: TipoMensaje.opcion,
      onTap: () => _quitarMensajesDeOpcionesYAgregarMensajes(
        callback: () => _generarNuevoChat(),
        mensajes: [
          Mensaje(
            fechaRegistro: DateTime.now(),
            mensaje: "Contactar con soporte",
            pkUsuario: globals.user?.id ?? 0,
            tipoMensaje: TipoMensaje.texto,
          ),
          Mensaje(
            fechaRegistro: DateTime.now(),
            pkUsuario: 0,
            mensaje:
                '''En seguida te contactaremos con un asesor de soporte. El tiempo máximo de respuesta es de 30  minutos''',
            tipoMensaje: TipoMensaje.texto,
          ),
        ],
      ),
    ),
  ];
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

  Future<void> _generarNuevoChat() async {
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
      emit(TramiteSupportError());
      return;
    } on NetworkException {
      showToastNotification(
        context: _context,
        message: AppLocale.avisoSinInternet.getString(_context),
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } on ApiClientException catch (e) {
      showToastNotification(
        context: _context,
        message: e.message,
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } catch (e) {
      showToastNotification(
        context: _context,
        message: AppLocale.errorInicioSesion.getString(_context),
        type: ToastType.error,
      );

      emit(TramiteSupportError());
      return;
    }
  }

  Future<void> _obtenerChatActivo() async {
    try {
      int? idChat = await chatProvider.obtenerChat(
        claveTramite: state.tramite.clave ?? '',
      );
      if (idChat == null) {
        await _iniciarBot();
      } else {
        await _obtenerMensajes();
      }
    } on ServerErrorException {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } on NetworkException {
      showToastNotification(
        context: _context,
        message: AppLocale.avisoSinInternet.getString(_context),
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } on ApiClientException catch (e) {
      showToastNotification(
        context: _context,
        message: e.message,
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } catch (e) {
      showToastNotification(
        context: _context,
        message: e.toString(),
        type: ToastType.error,
      );

      emit(TramiteSupportError());
      return;
    }
  }

  Future<void> _obtenerMensajes() async {
    try {
      List<Mensaje> mensajes = await chatProvider.obtenerMensajesChat(
        claveTramite: state.tramite.clave ?? '',
      );
      if (mensajes.isEmpty) {
        emit(TramiteSupportEmpty(tramite: state.tramite));
      } else {
        emit(TramiteSupportData(tramite: state.tramite, chats: mensajes));
      }
      await contactarSocket();
      await unirseASocket();
    } on ServerErrorException {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } on NetworkException {
      showToastNotification(
        context: _context,
        message: AppLocale.avisoSinInternet.getString(_context),
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } on ApiClientException catch (e) {
      showToastNotification(
        context: _context,
        message: e.message,
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } catch (e) {
      showToastNotification(
        context: _context,
        message: e.toString(),
        type: ToastType.error,
      );

      emit(TramiteSupportError());
      return;
    }
  }

  Future<void> _iniciarBot() async {
    emit(TramiteSupportLoading(tramite: state.tramite, chats: state.chats));
    await Future.delayed(const Duration(seconds: 1));
    await _quitarMensajesDeOpcionesYAgregarMensajes(
      mensajes: [
        Mensaje(
          fechaRegistro: DateTime.now(),
          pkUsuario: 0,
          mensaje: '''Hola ${globals.user?.name.capitalize},

Bienvenido(a) al asistente virtual de soporte. 🤖  
Estoy aquí para ayudarte de manera rápida y sencilla.

Selecciona una algún tema que tengas dudas:''',
          tipoMensaje: TipoMensaje.texto,
        ),
      ],
    );

    await _obtenerCategoriasBot(mostrarCargando: true);
  }

  Future<void> _obtenerCategoriasBot({bool mostrarCargando = true}) async {
    try {
      if (mostrarCargando) {
        // emit(TramiteSupportLoading(tramite: state.tramite, chats: state.chats));
        await Future.delayed(const Duration(seconds: 1));
      }
      List<CategoriaBot> mensajes = await botProvider.obtenerCategorias();
      List<Mensaje> chats = mensajes
          .map(
            (e) => Mensaje(
              fechaRegistro: DateTime.now(),
              mensaje: e.categoriaBot ?? '',
              pkUsuario: 0,
              tipoMensaje: TipoMensaje.opcion,
              onTap: () => _mandarCategoria(categoria: e),
            ),
          )
          .toList();
      if (!mostrarCargando) {
        chats = [...chats, ...iniciarChatConPersona];
      }
      emit(
        TramiteSupportData(
          tramite: state.tramite,
          chats: [...state.chats, ...chats],
        ),
      );
    } on ServerErrorException {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } on NetworkException {
      showToastNotification(
        context: _context,
        message: AppLocale.avisoSinInternet.getString(_context),
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } on ApiClientException catch (e) {
      showToastNotification(
        context: _context,
        message: e.message,
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } catch (e) {
      showToastNotification(
        context: _context,
        message: e.toString(),
        type: ToastType.error,
      );

      emit(TramiteSupportError());
      return;
    }
  }

  Future<void> _mandarCategoria({required CategoriaBot categoria}) async {
    try {
      await _quitarMensajesDeOpcionesYAgregarMensajes(
        mensajes: [
          Mensaje(
            fechaRegistro: DateTime.now(),
            mensaje: categoria.categoriaBot ?? '',
            pkUsuario: globals.user?.id ?? 0,
            tipoMensaje: TipoMensaje.texto,
          ),
          Mensaje(
            fechaRegistro: DateTime.now(),
            pkUsuario: 0,
            mensaje:
                '''Perfecto. A continuación encontrarás más opciones relacionadas.

Selecciona la que mejor se adapte a tu consulta:''',
            tipoMensaje: TipoMensaje.texto,
          ),
        ],
      );
      List<CategoriaBot> mensajes = await botProvider.obtenerSubCategorias(
        pkCategoria: (categoria.id ?? 0).toString(),
      );
      List<Mensaje> chats = mensajes
          .map(
            (e) => Mensaje(
              fechaRegistro: DateTime.now(),
              mensaje: e.categoriaBot ?? '',
              pkUsuario: 0,
              tipoMensaje: TipoMensaje.opcion,
              onTap: () => _mandarSubcategoria(categoria: e),
            ),
          )
          .toList();
      chats.add(volverAMenuPrincipal);
      emit(
        TramiteSupportData(
          tramite: state.tramite,
          chats: [...state.chats, ...chats],
        ),
      );
    } on ServerErrorException {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } on NetworkException {
      showToastNotification(
        context: _context,
        message: AppLocale.avisoSinInternet.getString(_context),
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } on ApiClientException catch (e) {
      showToastNotification(
        context: _context,
        message: e.message,
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } catch (e) {
      showToastNotification(
        context: _context,
        message: e.toString(),
        type: ToastType.error,
      );

      emit(TramiteSupportError());
      return;
    }
  }

  Future<void> _mandarSubcategoria({required CategoriaBot categoria}) async {
    try {
      await _quitarMensajesDeOpcionesYAgregarMensajes(
        mensajes: [
          Mensaje(
            fechaRegistro: DateTime.now(),
            mensaje: categoria.categoriaBot ?? '',
            pkUsuario: globals.user?.id ?? 0,
            tipoMensaje: TipoMensaje.texto,
          ),
          Mensaje(
            fechaRegistro: DateTime.now(),
            pkUsuario: 0,
            mensaje:
                '''Con el fin de proporcionarte una respuesta precisa, selecciona la opción que corresponda a tu consulta:''',
            tipoMensaje: TipoMensaje.texto,
          ),
        ],
      );
      List<PreguntaBot> mensajes = await botProvider.obtenerPreguntas(
        pkCategoria: (categoria.id ?? 0).toString(),
      );
      List<Mensaje> chats = mensajes
          .map(
            (e) => Mensaje(
              fechaRegistro: DateTime.now(),
              mensaje: e.pregunta ?? '',
              pkUsuario: 0,
              tipoMensaje: TipoMensaje.opcion,
              onTap: () => _mandarPregunta(categoria: e),
            ),
          )
          .toList();
      chats = [...chats, volverAMenuPrincipal];
      emit(
        TramiteSupportData(
          tramite: state.tramite,
          chats: [...state.chats, ...chats],
        ),
      );
    } on ServerErrorException {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } on NetworkException {
      showToastNotification(
        context: _context,
        message: AppLocale.avisoSinInternet.getString(_context),
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } on ApiClientException catch (e) {
      showToastNotification(
        context: _context,
        message: e.message,
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } catch (e) {
      showToastNotification(
        context: _context,
        message: e.toString(),
        type: ToastType.error,
      );

      emit(TramiteSupportError());
      return;
    }
  }

  Future<void> _mandarPregunta({required PreguntaBot categoria}) async {
    try {
      await _quitarMensajesDeOpcionesYAgregarMensajes(
        mensajes: [
          Mensaje(
            fechaRegistro: DateTime.now(),
            mensaje: categoria.pregunta ?? '',
            pkUsuario: globals.user?.id ?? 0,
            tipoMensaje: TipoMensaje.texto,
          ),
        ],
      );
      List<RespuestaBot> mensajes = await botProvider.obtenerRespuestas(
        pkPregunta: (categoria.id ?? 0).toString(),
      );
      List<Mensaje> chats = mensajes
          .map(
            (e) => Mensaje(
              fechaRegistro: DateTime.now(),
              mensaje: e.respuesta ?? '',
              pkUsuario: 0,
              tipoMensaje: TipoMensaje.texto,
            ),
          )
          .toList();
      chats = [...chats, volverAMenuPrincipal, ...iniciarChatConPersona];
      emit(
        TramiteSupportData(
          tramite: state.tramite,
          chats: [...state.chats, ...chats],
        ),
      );
    } on ServerErrorException {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } on NetworkException {
      showToastNotification(
        context: _context,
        message: AppLocale.avisoSinInternet.getString(_context),
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } on ApiClientException catch (e) {
      showToastNotification(
        context: _context,
        message: e.message,
        type: ToastType.error,
      );
      emit(TramiteSupportError());
      return;
    } catch (e) {
      showToastNotification(
        context: _context,
        message: e.toString(),
        type: ToastType.error,
      );

      emit(TramiteSupportError());
      return;
    }
  }

  Future<void> _quitarMensajesDeOpcionesYAgregarMensajes({
    required List<Mensaje> mensajes,
    Function? callback,
  }) async {
    List<Mensaje> chatsHistorico = state.chats
        .where((element) => element.tipoMensaje != TipoMensaje.opcion)
        .toList();

    emit(
      TramiteSupportData(tramite: state.tramite, chats: [...chatsHistorico]),
    );
    for (final mensaje in mensajes) {
      emit(
        TramiteSupportData(
          tramite: state.tramite,
          chats: [...state.chats, mensaje],
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
    }
    callback?.call();
  }

  //claveTramite, pkUsuario
  cerrarSocket() async {
    socket.emit('leave', {
      "claveTramite": state.tramite.clave ?? '',
      "pkUsuario": globals.user?.id ?? '',
    });
    socket.off(
      'chat message gpt',
      recibirMensajeSocket,
    ); // 🔑 liberar el listener
  }

  @override
  Future<void> close() {
    cerrarSocket();
    return super.close();
  }
}
