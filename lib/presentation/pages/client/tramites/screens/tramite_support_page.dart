import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/presentation/pages/client/tramites/cubit/tramites_support_cubit.dart';
import 'package:sigev/presentation/pages/client/tramites/cubit/tramites_support_state.dart';
import 'package:sigev/presentation/pages/client/tramites/widgets/app_input_chat.dart';
import 'package:sigev/presentation/pages/client/tramites/widgets/app_mensaje_cliente.dart';
import 'package:sigev/presentation/pages/client/tramites/widgets/app_mensaje_soporte.dart';
import 'package:sigev/presentation/widgets/app_loader.dart';
import 'package:sigev/config/globals.dart' as globals;

class TramiteSupportPage extends StatelessWidget {
  const TramiteSupportPage({super.key, required this.tramite});
  final Tramite tramite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocProvider(
        create: (context) =>
            TramiteSupportCubit(context: context, tramite: tramite),
        child: BlocBuilder<TramiteSupportCubit, TramiteSupportState>(
          builder: (context, state) {
            switch (state) {
              case TramiteSupportError():
                return Container();
              case TramiteSupportLoading():
                return const AppLoader();
              case TramiteSupportData():
                return TramiteSupportDataBody();
              case TramiteSupportEmpty():
                return TramiteSupportDataBodyEmpty();
              default:
                return const AppLoader();
            }
          },
        ),
      ),
    );
  }
}

class TramiteSupportDataBody extends StatelessWidget {
  const TramiteSupportDataBody({super.key});

  @override
  Widget build(BuildContext context) {
    TramiteSupportCubit cubit = context.read<TramiteSupportCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                ...cubit.state.chats.map((mensaje) {
                  if (mensaje.pkUsuario == globals.user?.id) {
                    return AppMensajeCliente(mensaje: mensaje);
                  }
                  return AppMensajeSoporte(mensaje: mensaje);
                }),
              ],
            ),
          ),
        ),
        SizedBox(height: context.spacing16),
        AppInputChat(
          onSubmit: () => cubit.mandarMensaje(),
          textController: cubit.chatText,
        ),
        SizedBox(height: context.spacing16),
      ],
    );
  }
}

class TramiteSupportDataBodyEmpty extends StatelessWidget {
  const TramiteSupportDataBodyEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '''¡Gracias por contactarnos! 😊
    Tu solicitud ya está en proceso.
    Actualmente todos nuestros agentes están ocupados, pero el tiempo máximo de espera es de 30 minutos.
    Gracias por tu paciencia.''',
        style: context.bodyBoldTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
