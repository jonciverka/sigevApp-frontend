import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_theme.dart';

class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child, this.width});

  final Widget child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(context.spacing24),
      decoration: BoxDecoration(
        boxShadow: AppTheme.smallElevationShadow,
        color: AppTheme.neutralColorWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
