import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/domain/models/chats.dart';
import 'package:sigev/presentation/pages/client/tramites/widgets/app_dias.dart';

class AppMensajeCliente extends StatelessWidget {
  const AppMensajeCliente({super.key, required this.mensaje, this.fecha});
  final Mensaje mensaje;
  final String? fecha;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3, right: 0, left: 0),
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
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(context.spacing20),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: context.spacing16,
                vertical: context.spacing8,
              ),
              margin: EdgeInsets.only(
                right: context.spacing12,
                left: context.spacing40,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      mensaje.mensaje!,
                      style: context.bodyRegularInputStyle.copyWith(
                        color: AppTheme.neutralColorWhite,
                      ),
                    ),
                  ),
                  // SizedBox(width: context.spacing4),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 8.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         DateFormat.jm().format(mensaje.fechaRegistro!),
                  //         style: const TextStyle(
                  //           color: Color(0xff565A66),
                  //           fontWeight: FontWeight.normal,
                  //           fontSize: 12,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
