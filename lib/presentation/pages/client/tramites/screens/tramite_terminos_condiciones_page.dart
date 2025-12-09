import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/presentation/widgets/app_buttons.dart';

class TramiteTerminosCondicionesPage extends StatelessWidget {
  const TramiteTerminosCondicionesPage({super.key, required this.tramite});
  final Tramite tramite;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing24,
            vertical: context.spacing24,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        tramite.clave ?? '',
                        style: context.headingLargeTextStyle.copyWith(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: context.spacing12),
                    Text(
                      tramite.tituloCarta,
                      style: context.headingSmallTextStyle,
                    ),
                    SizedBox(height: context.spacing12),
                    Expanded(
                      child: TramiteTerminosCondicionesPageBody(
                        tramite: tramite,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: context.spacing16,
                left: 0,
                right: 0,
                child: Center(
                  child: AppPrimaryButton(
                    label: AppLocale.textAvisoPrivacidadAceptarPerfil.getString(
                      context,
                    ),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: context.spacing16,
          top: context.spacing16,
          child: IconButton(
            onPressed: () => Navigator.pop(context, false),
            icon: Icon(AppIcons.close),
          ),
        ),
      ],
    );
  }
}

class TramiteTerminosCondicionesPageBody extends StatelessWidget {
  const TramiteTerminosCondicionesPageBody({super.key, required this.tramite});
  final Tramite tramite;

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: WebUri(
          "https://grupogevhe.com/clausulas/?tramite=${tramite.clave}&app=1",
        ),
      ),
      onWebViewCreated: (controller) {
        // webController = controller;
      },
    );
  }
}
