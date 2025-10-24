import 'package:flutter/material.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/presentation/widgets/app_tramite_card.dart';

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
              .map((tramite) => AppTramiteCard(tramite: tramite))
              .toList(),
        ),
      ),
    );
  }
}
