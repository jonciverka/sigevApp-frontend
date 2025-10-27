import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/widgets/app_buttons.dart';
import 'package:sigev/presentation/widgets/app_icon_buttons.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({
    super.key,
    this.onButtonNextPressed,
    this.onButtonBackPressed,
    this.onButtonCatalogPressed,
    this.onButtonGenerateCodePressed,
  });
  final void Function()? onButtonNextPressed;
  final void Function()? onButtonBackPressed;
  final void Function()? onButtonCatalogPressed;
  final void Function()? onButtonGenerateCodePressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          AppLocale.textInstruccionDatosObligatorios.getString(context),
          style: context.captionRegularTextStyle,
        ),
        SizedBox(height: context.spacing16),
        Row(
          children: [
            if (onButtonBackPressed != null)
              AppIconButton(
                icon: AppIcons.chevronLeft,
                onPressed: () => onButtonBackPressed?.call(),
              ),
            if (onButtonCatalogPressed != null)
              Expanded(
                child: AppPrimaryButton(
                  width: double.infinity,
                  label: AppLocale.botonVerCatalogoHomeSocio.getString(context),
                  onPressed: () => onButtonCatalogPressed?.call(),
                ),
              ),
            if (onButtonNextPressed != null)
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: AppPrimaryButton(
                    width: double.infinity,
                    label: AppLocale.textButtonSiguiente.getString(context),
                    onPressed: () => onButtonNextPressed?.call(),
                  ),
                ),
              ),
            if (onButtonGenerateCodePressed != null)
              Expanded(
                child: AppPrimaryButton(
                  width: double.infinity,
                  label: AppLocale.textButtonGenerarCodigo.getString(context),
                  onPressed: () => onButtonGenerateCodePressed?.call(),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
