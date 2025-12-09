import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/client/home/cubit/home_cubit.dart';
import 'package:sigev/presentation/pages/client/menu/cubit/menu_cubit.dart';
import 'package:sigev/presentation/pages/client/menu/cubit/menu_state.dart';
import 'package:sigev/presentation/pages/client/tramites/widgets/app_tramite_card.dart';
import 'package:sigev/presentation/widgets/app_buttons.dart';

class AppTramites extends StatelessWidget {
  const AppTramites({super.key});
  @override
  Widget build(BuildContext context) {
    var homeCubit = context.watch<HomeCubit>();
    var menuCubit = context.read<MenuCubit>();
    var tramites = homeCubit.state.tramites;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
            child: Text(
              AppLocale.textTituloHomeCliente.getString(context),
              style: context.headingMediumTextStyle.copyWith(
                color: AppTheme.primaryColor,
              ),
            ),
          ),
          SizedBox(height: context.spacing12),
          ...tramites
              .sublist(0, min(3, homeCubit.state.tramites.length))
              .map(
                (tramite) => AppTramiteCard(
                  tramite: tramite,
                  onTap: () => homeCubit.aceptTerminosYCondiciones(
                    clave: tramite.clave ?? '',
                  ),
                ),
              ),
          if (tramites.length > 3)
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
