import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/partner/home/cubit/home_cubit.dart';
import 'package:sigev/presentation/pages/partner/home/widgets/app_row_tramites.dart';

class AppTramites extends StatelessWidget {
  const AppTramites({super.key});

  @override
  Widget build(BuildContext context) {
    var homeCubit = context.watch<HomeCubit>();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: context.spacing16),
          AppRowTramites(
            nombre: AppLocale.textSubtituloTramitesIngresadosHomeSocio
                .getString(context),
            numero:
                int.tryParse(homeCubit.state.barraFija.ingresos?.dia ?? '0') ??
                0,
          ),
          SizedBox(height: context.spacing16),
          AppRowTramites(
            nombre: AppLocale.textSubtituloTramitesIngresadosSemanaHomeSocio
                .getString(context),
            numero:
                int.tryParse(
                  homeCubit.state.barraFija.ingresosSemana?.dia ?? '0',
                ) ??
                0,
          ),
          SizedBox(height: context.spacing16),
          Row(
            children: [
              Expanded(
                child: AppRowTramites(
                  nombre: AppLocale
                      .textSubtituloTramitesEgresadosSemanaHomeSocio
                      .getString(context),
                  numero:
                      int.tryParse(
                        homeCubit.state.barraFija.entregas?.dia ?? '0',
                      ) ??
                      0,
                ),
              ),
              SizedBox(width: context.spacing16),
              Expanded(
                child: AppRowTramites(
                  nombre: AppLocale
                      .textSubtituloTramitesCanceladosSemanaHomeSocio
                      .getString(context),
                  numero:
                      int.tryParse(
                        homeCubit.state.barraFija.cancelados?.dia ?? '0',
                      ) ??
                      0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
