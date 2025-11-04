import 'package:flutter/material.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/presentation/pages/partner/tramites/widgets/app_tramite_partner_card.dart';

class AppTramites extends StatelessWidget {
  const AppTramites({super.key, required this.tramites});
  final List<Tramite> tramites;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: tramites
              .map((tramite) => AppTramitePartnerCard(tramite: tramite))
              .toList(),
        ),
      ),
    );
  }
}
