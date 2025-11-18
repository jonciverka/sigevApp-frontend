import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';

class AppAviso extends StatelessWidget {
  const AppAviso({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing8,
        vertical: context.spacing12,
      ),
      decoration: BoxDecoration(
        color: AppTheme.semanticColorInfoLight,
        borderRadius: BorderRadius.circular(context.spacing8),
      ),
      child: Text(AppLocale.textAvisoCometario.getString(context)),
    );
  }
}
