import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_cubit.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_state.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/datos_contribuyente_page.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/datos_contribuyente_sucursal_page.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/datos_tramite_page.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/datos_vehiculo_page.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/datos_vehiculo_placas_page.dart';
import 'package:sigev/presentation/widgets/app_header.dart';
import 'package:sigev/presentation/widgets/app_loader.dart';

class NuevoTramite extends StatelessWidget {
  const NuevoTramite({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppTheme.neutralColorWhite,
        body: SafeArea(
          child: BlocProvider(
            create: (context) => NuevoTramiteCubit(context: context),
            child: BlocBuilder<NuevoTramiteCubit, NuevoTramiteState>(
              builder: (context, state) {
                switch (state) {
                  case NuevoTramiteError():
                    return Container();
                  case NuevoTramiteLoading():
                    return const AppLoader();
                  case NuevoTramiteData():
                    return NuevoTramiteBody();
                  default:
                    return const AppLoader();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class NuevoTramiteBody extends StatelessWidget {
  const NuevoTramiteBody({super.key});
  @override
  Widget build(BuildContext context) {
    var nuevoTramiteCubit = context.read<NuevoTramiteCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing16,
        vertical: context.spacing12,
      ),
      child: Column(
        children: [
          AppHeader(),
          Expanded(
            child: PageView(
              controller: nuevoTramiteCubit.pageController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                DatosContribuyenteSucursalPage(
                  onButtonNextPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.datosDelContribuyente,
                  ),
                ),
                DatosContribuyentePage(
                  onButtonNextPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.datosDelTramite,
                  ),
                  onButtonBackPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.datosDelContribuyenteSucursal,
                  ),
                ),
                DatosTramitePage(
                  onButtonNextPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.datosDelVehiculo,
                  ),
                  onButtonBackPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.datosDelContribuyente,
                  ),
                ),
                DatosVehiculoPage(
                  onButtonNextPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.datosDelVehiculoPlacas,
                  ),
                  onButtonBackPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.datosDelTramite,
                  ),
                ),
                DatosVehiculoPlacasPage(
                  onButtonNextPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.datosDelVehiculoDesechos,
                  ),
                  onButtonBackPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.datosDelVehiculo,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
