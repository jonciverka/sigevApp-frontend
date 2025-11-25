import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/client/tramites/widgets/app_search_bar.dart';
import 'package:sigev/presentation/pages/partner/tramites/cubit/tramites_cubit.dart';
import 'package:sigev/presentation/pages/partner/tramites/cubit/tramites_state.dart';
import 'package:sigev/presentation/pages/partner/tramites/screens/tramite_busqueda.dart';
import 'package:sigev/presentation/pages/partner/tramites/widgets/app_aviso.dart';
import 'package:sigev/presentation/pages/partner/tramites/widgets/app_tramites.dart';
import 'package:sigev/presentation/widgets/app_bottom_sheet.dart';
import 'package:sigev/presentation/widgets/app_buttons.dart';
import 'package:sigev/presentation/widgets/app_fondo_curvo.dart';
import 'package:sigev/presentation/widgets/app_loader.dart';

class TramitesPage extends StatelessWidget {
  const TramitesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppTheme.neutralColorWhite,
        body: BlocProvider(
          create: (context) => TramitesCubit(context: context),
          child: BlocBuilder<TramitesCubit, TramitesState>(
            builder: (context, state) {
              switch (state) {
                case TramitesError():
                  return Container();
                case TramitesLoading():
                  return const AppLoader();
                case TramitesData():
                  return TramitesPageBody();
                default:
                  return const AppLoader();
              }
            },
          ),
        ),
      ),
    );
  }
}

class TramitesPageBody extends StatelessWidget {
  const TramitesPageBody({super.key});
  @override
  Widget build(BuildContext context) {
    var homeCubit = context.watch<TramitesCubit>();
    var spacer = SizedBox(height: context.spacing12);
    return AppFondoCurvo(
      paddingBottom: context.spacing16,
      paddingTop: context.spacing24,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing8,
            vertical: context.spacing24,
          ),
          decoration: BoxDecoration(
            color: AppTheme.neutralColorWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(context.spacing24),
              topRight: Radius.circular(context.spacing24),
            ),
          ),
          child: Column(
            children: [
              Text(
                AppLocale.textTituloHomeCliente.getString(context),
                style: context.headingLargeTextStyle,
              ),
              spacer,
              AppSecondaryButton(
                width: double.infinity,
                prefixIcon: AppIcons.calendar,
                onPressed: () =>
                    showAppBottomSheet(
                      heightFactor: 0,
                      useRootNavigator: true,
                      context: context,
                      title: AppLocale.inputSearch.getString(context),
                      child: TramiteBusqueda(initialValue: homeCubit.semana),
                    ).then((value) {
                      if (value != null) {
                        homeCubit.getTramites(semana: value as String);
                      }
                    }),
                label: homeCubit.semana,
              ),
              spacer,
              AppSearchBar(
                items: homeCubit.state.tramites,
                onSearch: (value) =>
                    homeCubit.getTramitesBuscados(busqueda: value),
                searchPredicate: (item, query) {
                  return (item.clave ?? '').toString().toLowerCase().contains(
                    query.toLowerCase(),
                  );
                },
              ),
              spacer,
              AppTramites(tramites: homeCubit.state.tramitesBuscados),
            ],
          ),
        ),
      ),
    );
  }
}
