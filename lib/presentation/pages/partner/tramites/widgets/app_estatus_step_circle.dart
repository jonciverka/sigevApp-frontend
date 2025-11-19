import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';

class AppStatusStopCircle extends StatelessWidget {
  const AppStatusStopCircle({
    super.key,
    required this.numer,
    required this.active,
  });
  final int numer;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.spacing12),
      child: CircleAvatar(
        backgroundColor: active
            ? AppTheme.semanticColorSuccess
            : AppTheme.neutralColorDarkGrey,
        radius: context.spacing24,
        child: active
            ? Icon(AppIcons.arrowLogo, size: AppIcons.iconMediumSize)
            : Text(numer.toString()),
      ),
    );
  }
}
