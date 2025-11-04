import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/partner/home/cubit/home_cubit.dart';
import 'package:sigev/presentation/pages/partner/home/cubit/home_state.dart';
import 'package:sigev/presentation/pages/partner/home/widgets/app_facturacion.dart';
import 'package:sigev/presentation/pages/partner/home/widgets/app_tramites.dart';
import 'package:sigev/presentation/pages/partner/menu/cubit/menu_cubit.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/catalogo_precios_page.dart';
import 'package:sigev/presentation/widgets/app_bottom_sheet.dart';
import 'package:sigev/presentation/widgets/app_buttons.dart';
import 'package:sigev/presentation/widgets/app_loader.dart';
import 'package:sigev/presentation/widgets/app_tab_view.dart';

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
    var menuCubit = context.read<MenuCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing16,
        vertical: context.spacing12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: context.spacing16),
          Text(
            AppLocale.textTituloMisResultadosHomeSocioHomeSocio.getString(
              context,
            ),
            style: context.headingLargeTextStyle,
          ),
          SizedBox(height: context.spacing16),
          TabHome(),
          Row(
            children: [
              Expanded(
                child: AppPrimaryButton(
                  label: AppLocale.botonVerCatalogoHomeSocio.getString(context),
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
                  label: AppLocale.botonIrASitioWebHomeSocio.getString(context),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
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
