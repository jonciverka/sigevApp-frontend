import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/domain/models/tramite.dart';

class AppTramitePartnerCard extends StatelessWidget {
  const AppTramitePartnerCard({super.key, required this.tramite});
  final Tramite tramite;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // margin: EdgeInsets.only(bottom: context.spacing16),
      padding: EdgeInsets.all(context.spacing16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.neutralColorGrey400)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tramite.clave ?? '', style: context.bodyBoldTextStyle),
                SizedBox(height: context.spacing8),
                Text(
                  tramite.fechaCreacion ?? '',
                  style: context.bodyRegularTextStyle,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tramite.nombre ?? '', style: context.bodyBoldTextStyle),
                SizedBox(height: context.spacing8),
                Text(
                  "${tramite.tipoTramite} - ${tramite.tipoServicio} - ${tramite.tipoVehiculo} - ${tramite.entidad}",
                  style: context.bodyRegularTextStyle,
                ),
              ],
            ),
          ),
          Icon(AppIcons.chevronRight),
        ],
      ),
    );
  }
}
