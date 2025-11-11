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
          horizontal: context.spacing12,
          vertical: context.spacing12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(tramite.clave ?? '', style: context.headingLargeTextStyle),
            SizedBox(height: context.spacing24),
            Text(tramite.tituloCarta, style: context.headingMediumTextStyle),
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
    return Column(
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
