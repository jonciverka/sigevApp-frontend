import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/presentation/pages/partner/tramites/widgets/app_estatus_step_circle.dart';

class AppTramiteDetalleCard extends StatelessWidget {
  const AppTramiteDetalleCard({
    super.key,
    required this.number,
    required this.active,
    required this.estado,
    this.fecha,
  });
  final int number;
  final bool active;
  final Status estado;
  final String? fecha;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.spacing88,
      margin: EdgeInsets.only(bottom: context.spacing12),
      decoration: BoxDecoration(
        boxShadow: AppTheme.smallElevationShadow,
        color: AppTheme.neutralColorWhite,
        borderRadius: BorderRadius.circular(context.spacing12),
      ),
      child: Row(
        children: [
          SizedBox(width: context.spacing8),
          AppStatusStopCircle(numer: number, active: active),
          SizedBox(width: context.spacing8),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: context.spacing12,
                top: context.spacing12,
                right: context.spacing16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    estado.nombre ?? '',
                    textAlign: TextAlign.left,
                    style: context.bodyBoldTextStyle,
                  ),
                  if (estado.nombrePortada != '')
                    Text(
                      (estado.nombrePortada ?? '').split('-')[0].trim(),
                      textAlign: TextAlign.left,
                      style: context.bodyRegularTextStyle,
                      overflow: TextOverflow.clip,
                    ),
                  if (fecha != null)
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: context.spacing4,
                          bottom: context.spacing4,
                        ),
                        child: Text(
                          fecha ?? '',
                          textAlign: TextAlign.left,
                          style: context.captionRegularTextStyle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
