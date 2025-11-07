import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/widgets/app_card.dart';

class AppCardTituloTramitesActivosTotales extends StatelessWidget {
  const AppCardTituloTramitesActivosTotales({super.key, required this.total});
  final int total;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.spacing120,
      margin: EdgeInsets.only(bottom: context.spacing16),
      child: AppCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocale.textTramitesActivosTotalHomeCliente.getString(context),
              style: context.headingMediumTextStyle,
            ),
            SizedBox(height: context.spacing8),
            Text(total.toString(), style: context.headingLargeTextStyle),
          ],
        ),
      ),
    );
  }
}
