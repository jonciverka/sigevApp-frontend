import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/presentation/widgets/app_card.dart';
import 'package:sigev/presentation/pages/client/tramites/screens/tramite_detalle_page.dart';

class AppTramiteCard extends StatelessWidget {
  const AppTramiteCard({super.key, required this.tramite});
  final Tramite tramite;
  Future<T?> showTramiteModalDialog<T extends Object?>({
    required BuildContext context,
  }) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        isDismissible: false,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 1,
            child: TramiteDetallePage(tramite: tramite),
          );
        },
      ).then((value) async {
        return null;
      });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showTramiteModalDialog(context: context),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: context.spacing16),
        child: AppCard(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${tramite.tipoTramite} - ${tramite.tipoServicio} - ${tramite.tipoVehiculo} - ${tramite.entidad}",
                      style: context.headingMediumTextStyle,
                    ),
                    SizedBox(height: context.spacing8),
                    Text(
                      tramite.clave ?? '',
                      style: context.bodyRegularTextStyle,
                    ),
                    SizedBox(height: context.spacing8),
                    LinearProgressIndicator(
                      value: tramite.ultimoStatus.status?.avance != null
                          ? tramite.ultimoStatus.status!.avance! / 100
                          : 0,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.primaryColor,
                      ),
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(context.spacing16),
                    ),
                  ],
                ),
              ),
              Icon(AppIcons.chevronRight),
            ],
          ),
        ),
      ),
    );
  }
}
