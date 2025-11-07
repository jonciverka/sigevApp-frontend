import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/presentation/pages/client/menu/cubit/menu_cubit.dart';
import 'package:sigev/presentation/widgets/app_icon_buttons.dart';
import 'package:sigev/presentation/widgets/app_tab_view.dart';

class TramiteDetallePage extends StatelessWidget {
  const TramiteDetallePage({super.key, required this.tramite});
  final Tramite tramite;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing16,
        vertical: context.spacing20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: AppSecondaryIconButton(
              icon: AppIcons.close,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          AppTab(tramite: tramite),
        ],
      ),
    );
  }
}

class AppTab extends StatelessWidget {
  const AppTab({super.key, required this.tramite});
  final Tramite tramite;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing12,
          vertical: context.spacing12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
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
              child: AppTabView(
                tabsNames: [
                  AppLocale.tabEstadosTramites.getString(context),
                  AppLocale.tabDocumentosTramites.getString(context),
                ],
                isBodyScrollable: false,
                isBarScrollable: false,
                isExpanded: true,
                children: [
                  AppTramitesDetalleBody(tramite: tramite),
                  AppTramitesDocumentos(tramite: tramite),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppTramitesDetalleBody extends StatelessWidget {
  const AppTramitesDetalleBody({super.key, required this.tramite});
  final Tramite tramite;

  @override
  Widget build(BuildContext context) {
    var menuCubit = context.read<MenuCubit>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.spacing56),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: menuCubit.state.catalogoEstatusTramite
            .map(
              (estado) => SizedBox(
                height: context.spacing72,
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
    );
  }
}

class AppTramitesDocumentos extends StatelessWidget {
  const AppTramitesDocumentos({super.key, required this.tramite});
  final Tramite tramite;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.spacing56),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
            tramite.documentaciones
                ?.map(
                  (estado) => SizedBox(
                    height: context.spacing72,
                    child: Row(
                      children: [
                        Container(
                          width: context.spacing4,
                          color: AppTheme.neutralColorGrey400,
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
                                (estado.nombre ?? '').split('-')[0],
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
                .toList() ??
            [],
      ),
    );
  }
}
