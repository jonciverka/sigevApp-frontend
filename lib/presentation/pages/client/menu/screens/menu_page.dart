import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/presentation/pages/client/menu/cubit/menu_cubit.dart';
import 'package:sigev/presentation/pages/client/menu/cubit/menu_state.dart';
import 'package:sigev/presentation/widgets/app_menu_item.dart';
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
            margin: EdgeInsets.symmetric(horizontal: context.spacing16),
            padding: EdgeInsets.all(context.spacing4),
            height: context.spacing64,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(80),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppMenuItem(
                  icon: AppIcons.home,
                  onTap: () =>
                      menuCubit.changeIndex(index: MenuState.homePageIndex),
                  index: MenuState.homePageIndex,
                  active: menuCubit.state.index == MenuState.homePageIndex,
                ),
                AppMenuItem(
                  icon: AppIcons.orderSave,
                  onTap: () =>
                      menuCubit.changeIndex(index: MenuState.homeMisTramites),
                  index: MenuState.homeMisTramites,
                  active: menuCubit.state.index == MenuState.homeMisTramites,
                ),
                AppMenuItem(
                  icon: AppIcons.person,
                  onTap: () => menuCubit.changeIndex(
                    index: MenuState.profileMisTramites,
                  ),
                  index: MenuState.profileMisTramites,
                  active: menuCubit.state.index == MenuState.profileMisTramites,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
