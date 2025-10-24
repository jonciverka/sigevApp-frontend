import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/presentation/widgets/app_card.dart';

class AppRowCantidadFacturada extends StatelessWidget {
  const AppRowCantidadFacturada({
    super.key,
    required this.nombre,
    required this.numero,
  });
  final String nombre;
  final int numero;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Center(
              child: Text("\$ $numero", style: context.headingMediumTextStyle),
            ),
          ),
          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              nombre,
              style: context.headingMediumTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
