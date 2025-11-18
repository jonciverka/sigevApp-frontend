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
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing32,
          vertical: context.spacing32,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: context.spacing64),
            Icon(
              AppIcons.checkCircle,
              color: AppTheme.semanticColorSuccess,
              size: context.spacing120,
            ),
            SizedBox(height: context.spacing24),
            Text(
              AppLocale.textCodigoGenerado.getString(context),
              style: context.headingLargeTextStyle,
            ),
            SizedBox(height: context.spacing12),
            Text(code, style: context.headingMediumTextStyle),
            Spacer(),
            AppPrimaryButton(
              label: AppLocale.textButtonMisTramitesMenu.getString(context),
              onPressed: () =>
                  menuCubit.changeIndex(index: MenuState.homeMyProcess),
            ),
          ],
        ),
      ),
    );
  }
}
