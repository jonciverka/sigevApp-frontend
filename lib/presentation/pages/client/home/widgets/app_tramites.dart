import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/presentation/widgets/app_tramite_card.dart';

class AppTramites extends StatelessWidget {
  const AppTramites({super.key, required this.tramites});
  final List<Tramite> tramites;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocale.textTituloHomeCliente.getString(context),
          style: context.headingMediumTextStyle,
        ),
        SizedBox(height: context.spacing8),
        ...tramites.map((tramite) => AppTramiteCard(tramite: tramite)),
      ],
    );
  }
}
