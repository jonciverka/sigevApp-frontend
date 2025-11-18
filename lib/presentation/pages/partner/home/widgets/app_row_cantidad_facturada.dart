import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/utilities/utilities.dart';
import 'package:sigev/presentation/widgets/app_card.dart';

class AppRowCantidadFacturada extends StatelessWidget {
  const AppRowCantidadFacturada({
    super.key,
    required this.nombre,
    required this.numero,
    required this.color,
    required this.icono,
  });
  final String nombre;
  final int numero;
  final Color color;
  final IconData icono;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.spacing24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 1,
              child: AppContainerIcon(color: color, icono: icono),
            ),
            SizedBox(width: context.spacing16),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "\$${Utilities().formatMoney(numero)}",
                    style: context.headingMediumTextStyle.copyWith(
                      color: AppTheme.neutralColorBlack,
                    ),
                  ),
                  SizedBox(height: context.spacing4),
                  Text(
                    textAlign: TextAlign.center,
                    nombre,
                    style: context.bodyRegularTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppContainerIcon extends StatelessWidget {
  const AppContainerIcon({super.key, required this.color, required this.icono});
  final Color color;
  final IconData icono;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(context.spacing12),
      ),
      child: Icon(icono, size: 45),
    );
  }
}
