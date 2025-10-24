import 'package:flutter/material.dart';
import 'package:sigev/presentation/widgets/app_icon_buttons.dart';

class AppMenuItem extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  final int index;
  final bool active;
  final String title;
  const AppMenuItem({
    super.key,
    required this.icon,
    required this.onTap,
    required this.index,
    required this.active,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppMenuIconButton(
        icon: icon,
        onPressed: () => onTap(),
        active: active,
        title: title,
      ),
    );
  }
}
