import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/client/tramites/cubit/tramites_cubit.dart';
import 'package:sigev/presentation/pages/client/tramites/cubit/tramites_state.dart';
import 'package:sigev/presentation/pages/client/tramites/widgets/app_search_bar.dart';
import 'package:sigev/presentation/pages/client/tramites/widgets/app_tramites.dart';
import 'package:sigev/presentation/widgets/app_loader.dart';

class TramitesPage extends StatelessWidget {
  const TramitesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppTheme.neutralColorWhite,
        body: SafeArea(
          child: BlocProvider(
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
      ),
    );
  }
}

class TramitesPageBody extends StatelessWidget {
  const TramitesPageBody({super.key});
  @override
  Widget build(BuildContext context) {
    var homeCubit = context.watch<TramitesCubit>();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing16,
        vertical: context.spacing12,
      ),
      child: Column(
        children: [
          Text(
            AppLocale.textTituloHomeCliente.getString(context),
            style: context.headingLargeTextStyle,
          ),
          SizedBox(height: context.spacing16),
          AppSearchBar(
            items: homeCubit.state.tramites,
            onSearch: (value) => homeCubit.getTramitesBuscados(busqueda: value),
            searchPredicate: (item, query) {
              return (item.clave ?? '').toString().toLowerCase().contains(
                query.toLowerCase(),
              );
            },
          ),
          SizedBox(height: context.spacing16),
          AppTramites(tramites: homeCubit.state.tramitesBuscados),
        ],
      ),
    );
  }
}
