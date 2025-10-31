import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/presentation/pages/partner/menu/cubit/menu_cubit.dart';
import 'package:sigev/presentation/pages/partner/menu/cubit/menu_state.dart';
import 'package:sigev/presentation/widgets/app_buttons.dart';

class AppSucess extends StatelessWidget {
  const AppSucess({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    var menuCubit = context.read<MenuCubit>();
    return Container(
      color: AppTheme.semanticColorSuccess,
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: context.spacing32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            AppIcons.checkCircle,
            color: AppTheme.neutralColorWhite,
            size: context.spacing120,
          ),
          Text(
            AppLocale.textCodigoGenerado.getString(context),
            style: context.headingLargeTextStyle.copyWith(
              color: AppTheme.neutralColorWhite,
            ),
          ),
          SizedBox(height: context.spacing16),
          Text(
            code,
            style: context.headingMediumTextStyle.copyWith(
              color: AppTheme.neutralColorWhite,
            ),
          ),
          SizedBox(height: context.spacing24),
          AppPrimaryButton(
            label: AppLocale.textButtonMisTramitesMenu.getString(context),
            onPressed: () =>
                menuCubit.changeIndex(index: MenuState.homeMyProcess),
          ),
        ],
      ),
    );
  }
}
