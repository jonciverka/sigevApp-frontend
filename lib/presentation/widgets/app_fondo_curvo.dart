import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_theme.dart';

class AppFondoCurvo extends StatelessWidget {
  const AppFondoCurvo({super.key, this.showArrow = false, required this.child});
  final bool showArrow;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 218,
          decoration: BoxDecoration(
            color: AppTheme.primaryColorHover,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(context.spacing24),
              bottomRight: Radius.circular(context.spacing24),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
