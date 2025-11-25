import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/assets_constants.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/client/home/cubit/home_cubit.dart';
import 'package:sigev/presentation/pages/client/home/cubit/home_state.dart';
import 'package:sigev/presentation/pages/client/home/widgets/app_tramites.dart';
import 'package:sigev/presentation/widgets/app_fondo_curvo.dart';
import 'package:sigev/presentation/widgets/app_loader.dart';
import 'package:sigev/config/globals.dart' as globals;
import 'package:sigev/presentation/widgets/app_row_cantidad_facturada.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppTheme.neutralColorWhite,
        body: BlocProvider(
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
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});
  @override
  Widget build(BuildContext context) {
    var homeCubit = context.watch<HomeCubit>();
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: Opacity(
            opacity: .1,
            child: Image.asset(AssetsConstants.flechaLoco),
          ),
        ),
        AppFondoCurvo(
          paddingBottom: context.spacing16,
          paddingTop: context.spacing16,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Bienvenida(),
                AppRowCantidadFacturada(
                  nombre: AppLocale.textTramitesActivosTotalHomeCliente
                      .getString(context),
                  icono: AppIcons.train,
                  color: AppTheme.semanticColorSuccessLight,
                  numero: "${homeCubit.state.tramites.length}",
                ),
                SizedBox(height: context.spacing20),
                AppTramites(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Bienvenida extends StatelessWidget {
  const Bienvenida({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocale.textSaludoHomeSocio
                    .getString(context)
                    .replaceAll(
                      "%Usuario%",
                      globals.user!.name?.split(' ')[0] ?? '',
                    ),
                style: context.headingLargeTextStyle.copyWith(
                  color: AppTheme.neutralColorWhite,
                ),
              ),
              SizedBox(height: context.spacing8),
              Text(
                AppLocale.textSaludo2HomeSocio.getString(context),
                style: context.bodyRegularTextStyle.copyWith(
                  color: AppTheme.neutralColorWhite,
                ),
              ),
              SizedBox(height: context.spacing24),
            ],
          ),
          Positioned(
            right: 10,
            bottom: 0,
            child: Image.asset(AssetsConstants.carro, height: 70),
          ),
        ],
      ),
    );
  }
}
