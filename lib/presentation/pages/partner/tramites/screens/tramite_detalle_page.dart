import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/core/utilities/utilities_headers.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/presentation/pages/partner/menu/cubit/menu_cubit.dart';
import 'package:sigev/presentation/pages/partner/tramites/widgets/app_estatus_step_circle.dart';
import 'package:sigev/presentation/widgets/app_tab_view.dart';

class TramiteDetallePage extends StatelessWidget {
  const TramiteDetallePage({super.key, required this.tramite});
  final Tramite tramite;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing24,
            vertical: context.spacing24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  tramite.clave ?? '',
                  style: context.headingLargeTextStyle.copyWith(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: context.spacing12),
              Text(tramite.tituloCarta, style: context.headingSmallTextStyle),
              SizedBox(height: context.spacing12),
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
        Positioned(
          right: context.spacing16,
          top: context.spacing16,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(AppIcons.close),
          ),
        ),
      ],
    );
  }
}

class AppTramitesDetalleBody extends StatelessWidget {
  const AppTramitesDetalleBody({super.key, required this.tramite});
  final Tramite tramite;

  @override
  Widget build(BuildContext context) {
    var menuCubit = context.read<MenuCubit>();
    return Column(
      children: [
        SizedBox(height: context.spacing4),
        ...menuCubit.state.catalogoEstatusTramite.asMap().entries.map((entry) {
          final index = entry.key;
          final estado = entry.value;
          return Container(
            height: context.spacing80,
            margin: EdgeInsets.only(bottom: context.spacing12),
            decoration: BoxDecoration(
              boxShadow: AppTheme.smallElevationShadow,
              color: AppTheme.neutralColorWhite,
              borderRadius: BorderRadius.circular(context.spacing12),
            ),
            child: Row(
              children: [
                SizedBox(width: context.spacing8),
                AppStatusStopCircle(
                  numer: index + 1,
                  active: tramite.yaPaso(estado.id ?? 0),
                ),
                SizedBox(width: context.spacing8),
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
                      if (estado.nombrePortada != '')
                        Text(
                          (estado.nombrePortada ?? '').split('-')[0],
                          textAlign: TextAlign.left,
                          style: context.bodyRegularTextStyle,
                          overflow: TextOverflow.clip,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class AppTramitesDocumentos extends StatelessWidget {
  const AppTramitesDocumentos({super.key, required this.tramite});
  final Tramite tramite;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.spacing24),

          ...tramite.documentaciones?.map(
                (documentacion) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${documentacion.apellido ?? ''} *",
                      style: context.bodyBoldTextStyle,
                    ),
                    SizedBox(height: context.spacing8),
                    Container(
                      margin: EdgeInsets.only(bottom: context.spacing24),
                      height:
                          documentacion.file != null ||
                              documentacion.haveUrlRecurso
                          ? null
                          : context.spacing120,
                      width: double.infinity,
                      child: DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          strokeWidth: 2,
                          dashPattern: [10, 5],
                          radius: Radius.circular(context.spacing24),
                        ),
                        child: documentacion.haveUrlRecurso
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  context.spacing24,
                                ),
                                child: Image.network(
                                  documentacion.urlRecurso ?? '',
                                  headers: UtilitiesHeaders.getHeader(),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.spacing16,
                                ),
                                child: Center(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    AppLocale.textoErrorNoHayDocumentos
                                        .getString(context),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ) ??
              [],
        ],
      ),
    );
  }
}
