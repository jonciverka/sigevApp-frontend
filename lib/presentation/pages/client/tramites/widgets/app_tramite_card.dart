import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/presentation/pages/client/menu/cubit/menu_cubit.dart';
import 'package:sigev/presentation/pages/client/tramites/screens/tramite_detalle_page.dart';
import 'package:sigev/presentation/pages/client/tramites/widgets/app_estatus_step_circle.dart';

class AppTramiteCard extends StatelessWidget {
  const AppTramiteCard({super.key, required this.tramite});
  final Tramite tramite;
  Future<T?> showTramiteModalDialog<T extends Object?>({
    required BuildContext context,
    required MenuCubit menuCubit,
  }) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        isDismissible: false,
        useRootNavigator: true,
        builder: (context) {
          return BlocProvider.value(
            value: menuCubit,
            child: FractionallySizedBox(
              heightFactor: 1,
              child: TramiteDetallePage(tramite: tramite),
            ),
          );
        },
      ).then((value) async {
        return null;
      });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showTramiteModalDialog(
        context: context,
        menuCubit: context.read<MenuCubit>(),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3),
        width: double.infinity,
        margin: EdgeInsets.only(bottom: context.spacing12),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: AppTheme.smallElevationShadow,
            color: AppTheme.neutralColorWhite,
            borderRadius: BorderRadius.circular(context.spacing16),
          ),
          padding: EdgeInsets.only(
            top: context.spacing16,
            bottom: context.spacing16,
            left: context.spacing24,
            right: context.spacing12,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(tramite.tituloCarta, style: context.bodyBoldTextStyle),
                    SizedBox(height: context.spacing8),
                    Text(
                      tramite.clave ?? '',
                      style: context.bodyRegularTextStyle,
                    ),
                    SizedBox(height: context.spacing8),
                    AppStatusSteps(tramite: tramite),
                    SizedBox(height: context.spacing16),
                    if (!tramite.tieneTodasLasDocumentaciones)
                      AppMensajesAdvertencia(tramite: tramite),
                  ],
                ),
              ),
              Icon(AppIcons.arrowForward),
            ],
          ),
        ),
      ),
    );
  }
}

class AppStatusSteps extends StatelessWidget {
  const AppStatusSteps({super.key, required this.tramite});
  final Tramite tramite;

  @override
  Widget build(BuildContext context) {
    var menuCubit = context.read<MenuCubit>();
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 9),
          child: LinearProgressIndicator(
            value:
                (100 /
                    (menuCubit.state.catalogoEstatusTramite.length - 1) /
                    100) *
                (menuCubit.state.catalogoEstatusTramite
                        .where((estado) => tramite.yaPaso(estado.id ?? 0))
                        .length -
                    1),
            backgroundColor: AppTheme.neutralColorDarkGrey,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppTheme.semanticColorSuccess,
            ),
            minHeight: context.spacing4,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: menuCubit.state.catalogoEstatusTramite.map((estado) {
            return AppStatusStopCircle(active: tramite.yaPaso(estado.id ?? 0));
          }).toList(),
        ),
      ],
    );
  }
}

class AppMensajesAdvertencia extends StatelessWidget {
  const AppMensajesAdvertencia({super.key, required this.tramite});
  final Tramite tramite;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          AppIcons.warning,
          color: AppTheme.semanticColorWarning,
          size: AppIcons.iconMediumSize,
        ),
        SizedBox(width: context.spacing8),
        Text(
          AppLocale.faltaSubirDocumentos.getString(context),
          style: context.captionBoldTextStyle,
        ),
      ],
    );
  }
}
