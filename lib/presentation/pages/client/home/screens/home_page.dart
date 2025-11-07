import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/client/home/cubit/home_cubit.dart';
import 'package:sigev/presentation/pages/client/home/cubit/home_state.dart';
import 'package:sigev/presentation/pages/client/home/widgets/app_tramites.dart';
import 'package:sigev/presentation/pages/client/home/widgets/app_tramites_activos.dart';
import 'package:sigev/presentation/pages/client/menu/cubit/menu_cubit.dart';
import 'package:sigev/presentation/pages/client/menu/cubit/menu_state.dart';
import 'package:sigev/presentation/widgets/app_buttons.dart';
import 'package:sigev/presentation/widgets/app_loader.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppTheme.neutralColorWhite,
        body: SafeArea(
          child: BlocProvider(
            create: (context) => HomeCubit(context: context),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                switch (state) {
                  case HomeError():
                    return Container();
                  case HomeLoading():
                    return const AppLoader();
                  case HomeData():
                    return HomePageBody();
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

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});
  @override
  Widget build(BuildContext context) {
    var homeCubit = context.watch<HomeCubit>();
    var menuCubit = context.read<MenuCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing16,
        vertical: context.spacing12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: context.spacing16),
          AppCardTituloTramitesActivosTotales(
            total: homeCubit.state.tramites.length,
          ),
          SizedBox(height: context.spacing16),
          AppTramites(
            tramites: homeCubit.state.tramites.sublist(
              0,
              min(3, homeCubit.state.tramites.length),
            ),
          ),
          if (homeCubit.state.tramites.length > 3)
            AppTertiaryButton(
              width: double.nan,
              label: AppLocale.textButtonVerMasTramites.getString(context),
              onPressed: () =>
                  menuCubit.changeIndex(index: MenuState.homeMisTramites),
            ),
        ],
      ),
    );
  }
}
