import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/core/constant/assets_constants.dart';
import 'package:sigev/presentation/widgets/app_icon_buttons.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(AssetsConstants.sigevLogo, height: 50),
        AppIconButton(icon: AppIcons.notifications, iconSize: IconSize.small),
      ],
    );
  }
}
