import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/partner/home/cubit/home_cubit.dart';
import 'package:sigev/presentation/pages/partner/home/widgets/app_row_cantidad_facturada.dart';

class AppFacturacion extends StatelessWidget {
  const AppFacturacion({super.key});

  @override
  Widget build(BuildContext context) {
    var homeCubit = context.watch<HomeCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing16),
      child: Column(
        children: [
          SizedBox(height: context.spacing16),
          AppRowCantidadFacturada(
            nombre: AppLocale.textSubtituloFacturacionAnioHomeSocio.getString(
              context,
            ),
            numero: homeCubit.state.barraFija.facturaAnual ?? 0,
          ),
          SizedBox(height: context.spacing16),
          AppRowCantidadFacturada(
            nombre: AppLocale.textSubtituloFacturacionMesHomeSocio.getString(
              context,
            ),
            numero: homeCubit.state.barraFija.facturaMensual ?? 0,
          ),
          SizedBox(height: context.spacing16),
          AppRowCantidadFacturada(
            nombre: AppLocale.textSubtituloFacturacionSemanaHomeSocio.getString(
              context,
            ),
            numero: homeCubit.state.barraFija.facturaSemanal ?? 0,
          ),
        ],
      ),
    );
  }
}
