import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/assets_constants.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/partner/home/cubit/home_cubit.dart';
import 'package:sigev/presentation/pages/partner/home/cubit/home_state.dart';
import 'package:sigev/presentation/pages/partner/home/widgets/app_facturacion.dart';
import 'package:sigev/presentation/pages/partner/home/widgets/app_tramites.dart';
import 'package:sigev/presentation/pages/partner/menu/cubit/menu_cubit.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/catalogo_precios_page.dart';
import 'package:sigev/presentation/widgets/app_bottom_sheet.dart';
import 'package:sigev/presentation/widgets/app_buttons.dart';
import 'package:sigev/presentation/widgets/app_fondo_curvo.dart';
import 'package:sigev/presentation/widgets/app_loader.dart';
import 'package:sigev/presentation/widgets/app_tab_view.dart';
import 'package:sigev/config/globals.dart' as globals;

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
    var menuCubit = context.read<MenuCubit>();
    return AppFondoCurvo(
      paddingBottom: context.spacing16,
      paddingTop: context.spacing16,
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Opacity(
                opacity: .1,
                child: Image.asset(AssetsConstants.flechaLoco),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Bienvenida(),
                BodyHome(),
                Row(
                  children: [
                    Expanded(
                      child: AppPrimaryButton(
                        label: AppLocale.botonVerCatalogoHomeSocio.getString(
                          context,
                        ),
                        onPressed: () => showAppBottomSheet(
                          context: context,
                          title: AppLocale.textTituloCatalogoPrecios.getString(
                            context,
                          ),
                          child: BlocProvider.value(
                            value: menuCubit,
                            child: CatalogoPreciosPage(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: context.spacing12),
                    Expanded(
                      child: AppPrimaryButton(
                        label: AppLocale.botonIrASitioWebHomeSocio.getString(
                          context,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TabHome extends StatelessWidget {
  const TabHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppTabView(
        tabsNames: [
          AppLocale.textPestaniaFacturacionHomeSocioHomeSocio.getString(
            context,
          ),
          AppLocale.textPestaniaTramitesHomeSocioHomeSocio.getString(context),
        ],
        isBodyScrollable: false,
        isBarScrollable: false,
        isExpanded: true,
        children: [AppFacturacion(), AppTramites()],
      ),
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

class BodyHome extends StatelessWidget {
  const BodyHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: context.spacing16,
              bottom: context.spacing24,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.neutralColorWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(context.spacing24),
                topRight: Radius.circular(context.spacing24),
              ),
            ),
            child: Text(
              AppLocale.textTituloMisResultadosHomeSocioHomeSocio.getString(
                context,
              ),
              textAlign: TextAlign.center,
              style: context.headingMediumTextStyle.copyWith(
                color: AppTheme.primaryColor,
              ),
            ),
          ),

          TabHome(),
        ],
      ),
    );
  }
}
