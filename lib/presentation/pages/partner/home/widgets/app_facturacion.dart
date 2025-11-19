import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/partner/home/cubit/home_cubit.dart';
import 'package:sigev/presentation/widgets/app_row_cantidad_facturada.dart';

class AppFacturacion extends StatelessWidget {
  const AppFacturacion({super.key});

  @override
  Widget build(BuildContext context) {
    var homeCubit = context.watch<HomeCubit>();
    return Column(
      children: [
        SizedBox(height: context.spacing16),
        AppRowCantidadFacturada(
          nombre: AppLocale.textSubtituloFacturacionAnioHomeSocio.getString(
            context,
          ),
          icono: AppIcons.train,
          color: AppTheme.semanticColorSuccessLight,
          numero: "\$${homeCubit.state.barraFija.facturaAnual ?? 0}",
        ),
        SizedBox(height: context.spacing16),
        AppRowCantidadFacturada(
          nombre: AppLocale.textSubtituloFacturacionMesHomeSocio.getString(
            context,
          ),
          numero: "\$${homeCubit.state.barraFija.facturaMensual ?? 0}",
          icono: AppIcons.bus,
          color: AppTheme.semanticColorWarningLight,
        ),
        SizedBox(height: context.spacing16),
        AppRowCantidadFacturada(
          nombre: AppLocale.textSubtituloFacturacionSemanaHomeSocio.getString(
            context,
          ),
          numero: "\$${homeCubit.state.barraFija.facturaSemanal ?? 0}",
          icono: AppIcons.car,
          color: AppTheme.semanticColorInfoLight,
        ),
      ],
    );
  }
}
