import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/partner/menu/cubit/menu_cubit.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_cubit.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_state.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/catalogo_precios_page.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/datos_contribuyente_page.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/datos_contribuyente_sucursal_page.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/datos_detalle_pago.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/datos_detalle_saldo_pago.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/datos_documentos.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/datos_tramite_page.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/datos_vehiculo_page.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/datos_vehiculo_placas_page.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_progress_bar.dart';
import 'package:sigev/presentation/widgets/app_bottom_sheet.dart';
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
          AppProgressBar(),
          SizedBox(height: context.spacing12),
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
                    isBack: true,
                  ),
                ),
                DatosTramitePage(
                  onButtonNextPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.datosDelVehiculo,
                  ),
                  onButtonBackPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.datosDelContribuyente,
                    isBack: true,
                  ),
                ),
                DatosVehiculoPage(
                  onButtonNextPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.datosDelVehiculoPlacas,
                  ),
                  onButtonBackPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.datosDelTramite,
                    isBack: true,
                  ),
                ),
                DatosVehiculoPlacasPage(
                  onButtonNextPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.detallePago,
                  ),
                  onButtonBackPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.datosDelVehiculo,
                    isBack: true,
                  ),
                ),
                DatosDetallePago(
                  onButtonNextPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.detallePagoSaldo,
                  ),
                  onButtonBackPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.datosDelVehiculoPlacas,
                    isBack: true,
                  ),
                  onButtonCatalogPressed: () => showAppBottomSheet(
                    context: context,
                    title: AppLocale.textTituloCatalogoPrecios.getString(
                      context,
                    ),
                    child: BlocProvider.value(
                      value: context.read<MenuCubit>(),
                      child: CatalogoPreciosPage(),
                    ),
                  ),
                ),
                DatosDetalleSaldoPago(
                  onButtonNextPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.detalleDocumentos,
                  ),
                  onButtonBackPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.detallePago,
                    isBack: true,
                  ),
                ),
                DatosDocumentos(
                  onButtonGenerateCodePressed: () {},
                  onButtonBackPressed: () => nuevoTramiteCubit.cambiarPagina(
                    NuevoTramiteState.detallePagoSaldo,
                    isBack: true,
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
