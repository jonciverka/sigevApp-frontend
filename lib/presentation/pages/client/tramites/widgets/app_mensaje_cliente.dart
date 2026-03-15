import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/utilities/utilities.dart';
import 'package:sigev/domain/models/chats.dart';
import 'package:sigev/presentation/pages/client/tramites/cubit/tramites_support_cubit.dart';
import 'package:sigev/presentation/pages/client/tramites/screens/preview_images_page.dart';
import 'package:sigev/presentation/pages/client/tramites/widgets/app_dias.dart';

class AppMensajeCliente extends StatelessWidget {
  const AppMensajeCliente({super.key, required this.mensaje, this.fecha});
  final Mensaje mensaje;
  final String? fecha;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (fecha != null) AppDias(dia: fecha ?? ""),
          GestureDetector(
            onLongPress: () {
              if (mensaje.tipoMensaje == TipoMensaje.texto) {
                Clipboard.setData(ClipboardData(text: mensaje.mensaje!));
                Fluttertoast.showToast(
                  msg: "Text copied to your clipboard",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            },
            child: switch (mensaje.tipoMensaje) {
              TipoMensaje.texto => AppMessageText(
                mensaje: mensaje,
                fecha: fecha,
              ),
              TipoMensaje.imagen => AppMessageImage(
                mensaje: mensaje,
                fecha: fecha,
              ),
              _ => AppMessageText(mensaje: mensaje, fecha: fecha),
            },
          ),
        ],
      ),
    );
  }
}

class AppMessageText extends StatelessWidget {
  const AppMessageText({super.key, required this.mensaje, this.fecha});
  final Mensaje mensaje;
  final String? fecha;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.primaryColorDisabledAndChat,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(context.spacing12),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(context.spacing12),
              topRight: Radius.circular(context.spacing12),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing12,
            vertical: context.spacing8,
          ),
          margin: EdgeInsets.only(
            right: context.spacing12,
            left: context.spacing40,
            top: context.spacing8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: context.spacing4),
                    Text(
                      mensaje.mensaje ?? '',
                      style: context.bodyRegularTextStyle.copyWith(
                        color: AppTheme.neutralColorBlack,
                      ),
                    ),
                    SizedBox(height: context.spacing4),
                    Text(
                      Utilities().obtenerHora(
                        mensaje.fechaRegistro ?? DateTime.now(),
                      ),
                      style: context.captionRegularTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AppMessageImage extends StatelessWidget {
  const AppMessageImage({super.key, required this.mensaje, this.fecha});
  final Mensaje mensaje;
  final String? fecha;
  @override
  Widget build(BuildContext context) {
    TramiteSupportCubit cubit = context.read<TramiteSupportCubit>();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.primaryColorDisabledAndChat,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(context.spacing12),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(context.spacing12),
              topRight: Radius.circular(context.spacing12),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing12,
            vertical: context.spacing8,
          ),
          margin: EdgeInsets.only(
            right: context.spacing12,
            left: context.spacing40,
            top: context.spacing8,
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FotoViewer(
                              initialIndex: 0,
                              fotos: cubit.state.chats
                                  .where(
                                    (e) => e.tipoMensaje == TipoMensaje.imagen,
                                  )
                                  .map((e) => e.urlImage!)
                                  .toList(),
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(context.spacing24),
                        child: Image.network(
                          mensaje.urlImage ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: context.spacing4),
                    Text(
                      Utilities().obtenerHora(
                        mensaje.fechaRegistro ?? DateTime.now(),
                      ),
                      style: context.captionRegularTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
