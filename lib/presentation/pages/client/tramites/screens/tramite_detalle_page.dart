import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/presentation/pages/client/menu/cubit/menu_cubit.dart';
import 'package:sigev/presentation/pages/client/tramites/cubit/tramites_detalle_cubit.dart';
import 'package:sigev/presentation/pages/client/tramites/cubit/tramites_detalle_state.dart';
import 'package:sigev/presentation/pages/client/tramites/widgets/app_tramites_documentos.dart';
import 'package:sigev/presentation/widgets/app_loader.dart';
import 'package:sigev/presentation/widgets/app_tab_view.dart';
import 'package:sigev/presentation/widgets/app_tramite_deatlle_card.dart';

class TramiteDetallePage extends StatelessWidget {
  const TramiteDetallePage({super.key, required this.tramite});
  final Tramite tramite;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TramiteDetalleCubit(context: context, tramite: tramite),
      child: BlocBuilder<TramiteDetalleCubit, TramiteDetalleState>(
        builder: (context, state) {
          switch (state) {
            case TramiteDetalleError():
              return Container();
            case TramiteDetalleLoading():
              return const AppLoader();
            case TramiteDetalleData():
              return TramiteDetalleDataBody(tramite: state.tramite);
            default:
              return const AppLoader();
          }
        },
      ),
    );
  }
}

class TramiteDetalleDataBody extends StatelessWidget {
  const TramiteDetalleDataBody({super.key, required this.tramite});
  final Tramite tramite;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing24,
            vertical: context.spacing24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
          return AppTramiteDetalleCard(
            active: tramite.yaPaso(estado.id ?? 0),
            estado: estado,
            number: index + 1,
          );
        }),
      ],
    );
  }
}
