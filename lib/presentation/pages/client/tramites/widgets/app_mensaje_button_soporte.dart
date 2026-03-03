import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/client/tramites/widgets/app_dias.dart';
import 'package:sigev/presentation/widgets/app_buttons.dart';

class AppMensajeButtonSoporte extends StatelessWidget {
  const AppMensajeButtonSoporte({super.key, required this.onTap, this.fecha});
  final Function onTap;
  final String? fecha;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3, right: 0, left: 0),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (fecha != null) AppDias(dia: fecha ?? ""),
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.spacing16,
                  vertical: context.spacing8,
                ),
                margin: const EdgeInsets.only(top: 3, right: 100, left: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: AppPrimaryButton(
                            label: AppLocale.botonIniciarChat.getString(
                              context,
                            ),
                            onPressed: () => onTap(),
                          ),
                        ),
                        // SizedBox(width: context.spacing8),
                        // Align(
                        //   alignment: Alignment.bottomRight,
                        //   child: Text(
                        //     DateFormat.jm().format(
                        //       mensaje.fechaRegistro ?? DateTime.now(),
                        //     ),
                        //     style: context.captionBoldTextStyle,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
