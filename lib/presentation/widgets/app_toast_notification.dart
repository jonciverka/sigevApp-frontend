import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';

enum ToastType { success, error, warning, info }

void showToastNotification({
  required ToastType type,
  required String message,
  required BuildContext context,
  int durationInSeconds = 3,
}) {
  final SnackBar snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: AppToastNotification(type: type, message: message),
    duration: Duration(seconds: durationInSeconds),
  );

  SchedulerBinding.instance.addPostFrameCallback((_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  });
}

class AppToastNotification extends StatelessWidget {
  const AppToastNotification({
    super.key,
    required this.type,
    required this.message,
  });

  final ToastType type;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      // color: Colors.red,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: AppTheme.convertPixelsToLogicalPixels(context, 400),
          ),
          width: double.infinity,
          // height: context.spacing56,
          margin: EdgeInsets.symmetric(horizontal: context.spacing12),
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing16,
            vertical: context.spacing12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: switch (type) {
              ToastType.success => AppTheme.semanticColorSuccess,
              ToastType.error => AppTheme.semanticColorError,
              ToastType.warning => AppTheme.semanticColorWarning,
              ToastType.info => AppTheme.semanticColorInfo,
            },
          ),
          child: Row(
            children: [
              AppIcons.mediumIcon(switch (type) {
                ToastType.success => AppIcons.checkCircle,
                ToastType.error => AppIcons.error,
                ToastType.warning => AppIcons.warning,
                ToastType.info => AppIcons.info,
              }, color: AppTheme.neutralColorWhite),
              SizedBox(width: context.spacing12),
              Expanded(
                child: Text(
                  message,
                  // maxLines: 2,
                  style: context.bodyBoldTextStyle.copyWith(
                    color: AppTheme.neutralColorWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
