import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_theme.dart';

class AppStatusStopCircle extends StatelessWidget {
  const AppStatusStopCircle({super.key, required this.active});
  final bool active;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: active
          ? AppTheme.semanticColorSuccess
          : AppTheme.neutralColorDarkGrey,
      radius: context.spacing12,
    );
  }
}
