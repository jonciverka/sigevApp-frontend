import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_theme.dart';

class AppFondoCurvo extends StatelessWidget {
  const AppFondoCurvo({
    super.key,
    this.showArrow = false,
    required this.child,
    required this.paddingTop,
    required this.paddingBottom,
  });
  final bool showArrow;
  final Widget child;
  final double paddingTop;
  final double paddingBottom;
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
        Padding(
          padding: EdgeInsets.only(
            left: context.spacing16,
            right: context.spacing16,
            top: paddingTop,
            bottom: paddingBottom,
          ),
          child: child,
        ),
      ],
    );
  }
}
