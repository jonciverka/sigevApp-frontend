import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/core/utilities/utilities.dart';
import 'package:sigev/domain/models/chats.dart';
import 'package:sigev/presentation/pages/client/tramites/cubit/tramites_support_cubit.dart';
import 'package:sigev/presentation/widgets/app_bottom_sheet_pregunta.dart';
import 'package:sigev/presentation/widgets/app_buttons.dart';

class AppMensajeSoporte extends StatelessWidget {
  const AppMensajeSoporte({super.key, required this.mensaje, this.fecha});
  final Mensaje mensaje;
  final String? fecha;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              TipoMensaje.opcion => AppMensajeSoporteOpcion(
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
            color: AppTheme.primaryColorChat,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(context.spacing12),
              topLeft: Radius.circular(context.spacing12),
              topRight: Radius.circular(context.spacing12),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing12,
            vertical: context.spacing8,
          ),
          margin: EdgeInsets.only(right: 40, top: context.spacing8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                textAlign: TextAlign.start,
                mensaje.mensaje ?? '',
                style: context.bodyRegularTextStyle,
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
        );
      },
    );
  }
}

class AppMensajeSoporteOpcion extends StatelessWidget {
  const AppMensajeSoporteOpcion({super.key, required this.mensaje, this.fecha});
  final Mensaje mensaje;
  final String? fecha;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          onTap: () => mensaje.onTap?.call(),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.primaryColorChat,
              borderRadius: BorderRadius.circular(context.spacing12),
              boxShadow: AppTheme.smallElevationShadow,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: context.spacing12,
              vertical: context.spacing8,
            ),
            margin: EdgeInsets.only(right: 40, top: context.spacing4),
            child: Text(
              mensaje.mensaje ?? '',
              style: context.bodyRegularTextStyle,
            ),
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
    TramiteSupportCubit tramiteDetalleCubit = context
        .read<TramiteSupportCubit>();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.primaryColorChat,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(context.spacing12),
              topLeft: Radius.circular(context.spacing12),
              topRight: Radius.circular(context.spacing12),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing12,
            vertical: context.spacing8,
          ),
          margin: EdgeInsets.only(right: 40, top: context.spacing8),
          child: AppPrimaryButton(
            onPressed: () => showAppBottomSheetPregunta(
              context: context,
              title: AppLocale.textoImagenSolicitud.getString(context),
              yes: AppLocale.seleccionarImagen.getString(context),
              onYes: () async => await tramiteDetalleCubit.selectFile(),
              no: AppLocale.textButtonCancelar.getString(context),
              onNo: () => {},
            ),
            label: AppLocale.textoImagenSolicitud.getString(context),
          ),
        );
      },
    );
  }
}
