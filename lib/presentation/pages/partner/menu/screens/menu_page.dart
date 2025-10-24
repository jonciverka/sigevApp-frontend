import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/widgets/app_menu_item.dart';
import 'package:sigev/presentation/pages/partner/menu/cubit/menu_cubit.dart';
import 'package:sigev/presentation/pages/partner/menu/cubit/menu_state.dart';
import 'package:sigev/presentation/widgets/app_loader.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppTheme.neutralColorWhite,
        body: BlocProvider(
          create: (context) => MenuCubit(context: context),
          child: BlocBuilder<MenuCubit, MenuState>(
            builder: (context, state) {
              switch (state) {
                case MenuData():
                  return MenuPageBody();
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

class MenuPageBody extends StatelessWidget {
  const MenuPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    var menuCubit = context.watch<MenuCubit>();
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppTheme.neutralColorWhite,
        body: Navigator(
          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute(
              builder: (_) => PopScope(
                child: MenuState.listScreens.elementAt(menuCubit.state.index),
              ),
            );
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: AppTheme.neutralColorGrey400, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppMenuItem(
                  icon: Icons.home_outlined,
                  onTap: () =>
                      menuCubit.changeIndex(index: MenuState.homePageIndex),
                  index: MenuState.homePageIndex,
                  active: menuCubit.state.index == MenuState.homePageIndex,
                  title: AppLocale.textButtonInicioMenu.getString(context),
                ),
                AppMenuItem(
                  icon: Icons.home_outlined,
                  onTap: () =>
                      menuCubit.changeIndex(index: MenuState.homeNewProcess),
                  index: MenuState.homePageIndex,
                  active: menuCubit.state.index == MenuState.homeNewProcess,
                  title: AppLocale.textButtonNuevoTramiteMenu.getString(
                    context,
                  ),
                ),
                AppMenuItem(
                  icon: Icons.home_outlined,
                  onTap: () =>
                      menuCubit.changeIndex(index: MenuState.homeMyProcess),
                  index: MenuState.homeMyProcess,
                  active: menuCubit.state.index == MenuState.homeMyProcess,
                  title: AppLocale.textButtonMisTramitesMenu.getString(context),
                ),
                AppMenuItem(
                  icon: Icons.home_outlined,
                  onTap: () =>
                      menuCubit.changeIndex(index: MenuState.homeProfile),
                  index: MenuState.homeProfile,
                  active: menuCubit.state.index == MenuState.homeProfile,
                  title: AppLocale.textButtonPerfilMenu.getString(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
