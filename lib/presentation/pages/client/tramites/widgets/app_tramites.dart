import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/presentation/pages/client/tramites/widgets/app_tramite_card.dart';

class AppTramites extends StatelessWidget {
  const AppTramites({super.key, required this.tramites});
  final List<Tramite> tramites;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacing8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: tramites
                .map((tramite) => AppTramiteCard(tramite: tramite))
                .toList(),
          ),
        ),
      ),
    );
  }
}
