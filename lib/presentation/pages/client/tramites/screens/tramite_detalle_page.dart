import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/presentation/pages/client/menu/cubit/menu_cubit.dart';
import 'package:sigev/presentation/widgets/app_icon_buttons.dart';

class TramiteDetallePage extends StatelessWidget {
  const TramiteDetallePage({super.key, required this.tramite});
  final Tramite tramite;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing12,
        vertical: context.spacing12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSecondaryIconButton(
            icon: AppIcons.close,
            onPressed: () => Navigator.pop(context),
          ),
          AppTramiteDetalleBody(tramite: tramite),
        ],
      ),
    );
  }
}

class AppTramiteDetalleBody extends StatelessWidget {
  const AppTramiteDetalleBody({super.key, required this.tramite});
  final Tramite tramite;

  @override
  Widget build(BuildContext context) {
    var menuCubit = context.read<MenuCubit>();
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing56,
          vertical: context.spacing12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(tramite.clave ?? '', style: context.headingLargeTextStyle),
            SizedBox(height: context.spacing24),
            Text(
              "${tramite.tipoTramite} - ${tramite.tipoServicio} - ${tramite.tipoVehiculo} - ${tramite.entidad}",
              style: context.headingMediumTextStyle,
            ),
            SizedBox(height: context.spacing24),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: menuCubit.state.catalogoEstatusTramite
                    .map(
                      (estado) => SizedBox(
                        height: context.spacing88,
                        child: Row(
                          children: [
                            Container(
                              width: context.spacing4,
                              color: tramite.yaPaso(estado.id ?? 0)
                                  ? AppTheme.primaryColor
                                  : AppTheme.neutralColorGrey400,
                            ),
                            SizedBox(width: context.spacing16),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    estado.nombre ?? '',
                                    textAlign: TextAlign.left,
                                    style: context.bodyBoldTextStyle,
                                  ),
                                  Text(
                                    (estado.nombrePortada ?? '').split('-')[0],
                                    textAlign: TextAlign.left,
                                    style: context.captionBoldTextStyle,
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
