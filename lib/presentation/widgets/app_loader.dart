import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/config/theme/app_theme.dart';

class AppLoaderDialog {
  static void showLoaderDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (builder) {
        return const Dialog(
          backgroundColor: Colors.black54,
          elevation: 0,
          child: AppLoader(),
        );
      },
    );
  }
}

class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.showText = true, this.size});

  final double? size;
  final bool showText;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: size ?? context.spacing40,
            width: size ?? context.spacing40,
            child: CircularProgressIndicator(
              strokeCap: StrokeCap.round,
              color: AppTheme.primaryColor,
              strokeWidth: context.spacing4,
              // constraints: const BoxConstraints.expand(),
            ),
          ),
          if (showText) SizedBox(height: context.spacing16),
          if (showText)
            SizedBox(
              child: Text(
                AppLocale.cargando.getString(context),
                style: context.bodyRegularTextStyle.copyWith(
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class AppLoaderDeterminate extends StatelessWidget {
  const AppLoaderDeterminate({super.key, required this.loadingPercentage});

  final double loadingPercentage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: context.spacing40,
            width: context.spacing40,
            child: CircularProgressIndicator(
              strokeCap: StrokeCap.round,
              color: AppTheme.primaryColor,
              strokeWidth: context.spacing8,
              // constraints: const BoxConstraints.expand(),
            ),
          ),
          SizedBox(height: context.spacing8),
          SizedBox(
            child: Text(
              AppLocale.cargando.getString(context),
              style: context.bodyBoldTextStyle.copyWith(
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CenteredLoader extends StatelessWidget {
  const CenteredLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(child: Center(child: AppLoader()));
  }
}
