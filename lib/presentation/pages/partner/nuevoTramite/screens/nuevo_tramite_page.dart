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
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_loader_creando_tramite.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_progress_bar.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_success.dart';
import 'package:sigev/presentation/widgets/app_bottom_sheet.dart';
import 'package:sigev/presentation/widgets/app_bottom_sheet_pregunta.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_header_nuevo_tramite.dart';
import 'package:sigev/presentation/widgets/app_fondo_curvo.dart';
import 'package:sigev/presentation/widgets/app_loader.dart';

class NuevoTramite extends StatelessWidget {
  const NuevoTramite({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppTheme.neutralColorWhite,
        body: BlocProvider(
          create: (context) => NuevoTramiteCubit(context: context),
          child: BlocBuilder<NuevoTramiteCubit, NuevoTramiteState>(
            builder: (context, state) {
              switch (state) {
                case NuevoTramiteError():
                  return Container();
                case NuevoTramiteLoading():
                  return const AppLoader();
                case NuevoTramiteLoadingCreate():
                  return AppLoaderCreandoTramite(status: state.status);
                case NuevoTramiteData():
                  return NuevoTramiteBody();
                case NuevoTramiteLoadingSucess():
                  return AppSucess(
                    code: context.read<NuevoTramiteCubit>().claveTramite,
                  );
                default:
                  return AppLoader();
              }
            },
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
    return AppFondoCurvo(
      paddingBottom: 0,
      paddingTop: context.spacing16,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.neutralColorWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(context.spacing24),
              topRight: Radius.circular(context.spacing24),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing8,
            vertical: context.spacing24,
          ),
          child: Column(
            children: [
              AppHeaderNuevoTramite(),
              SizedBox(height: context.spacing16),
              AppProgressBar(),
              SizedBox(height: context.spacing16),
              Expanded(
                child: PageView(
                  controller: nuevoTramiteCubit.pageController,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    DatosContribuyenteSucursalPage(
                      onButtonNextPressed: () =>
                          nuevoTramiteCubit.cambiarPagina(
                            NuevoTramiteState.datosDelContribuyente,
                          ),
                    ),
                    DatosContribuyentePage(
                      onButtonNextPressed: () => nuevoTramiteCubit
                          .cambiarPagina(NuevoTramiteState.datosDelTramite),
                      onButtonBackPressed: () =>
                          nuevoTramiteCubit.cambiarPagina(
                            NuevoTramiteState.datosDelContribuyenteSucursal,
                            isBack: true,
                          ),
                    ),
                    DatosTramitePage(
                      onButtonNextPressed: () => nuevoTramiteCubit
                          .cambiarPagina(NuevoTramiteState.datosDelVehiculo),
                      onButtonBackPressed: () =>
                          nuevoTramiteCubit.cambiarPagina(
                            NuevoTramiteState.datosDelContribuyente,
                            isBack: true,
                          ),
                    ),
                    DatosVehiculoPage(
                      onButtonNextPressed: () =>
                          nuevoTramiteCubit.cambiarPagina(
                            NuevoTramiteState.datosDelVehiculoPlacas,
                          ),
                      onButtonBackPressed: () =>
                          nuevoTramiteCubit.cambiarPagina(
                            NuevoTramiteState.datosDelTramite,
                            isBack: true,
                          ),
                    ),
                    DatosVehiculoPlacasPage(
                      onButtonNextPressed: () => nuevoTramiteCubit
                          .cambiarPagina(NuevoTramiteState.detallePago),
                      onButtonBackPressed: () =>
                          nuevoTramiteCubit.cambiarPagina(
                            NuevoTramiteState.datosDelVehiculo,
                            isBack: true,
                          ),
                    ),
                    DatosDetallePago(
                      onButtonNextPressed: () => nuevoTramiteCubit
                          .cambiarPagina(NuevoTramiteState.detallePagoSaldo),
                      onButtonBackPressed: () =>
                          nuevoTramiteCubit.cambiarPagina(
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
                      onButtonNextPressed: () => nuevoTramiteCubit
                          .cambiarPagina(NuevoTramiteState.detalleDocumentos),
                      onButtonBackPressed: () =>
                          nuevoTramiteCubit.cambiarPagina(
                            NuevoTramiteState.detallePago,
                            isBack: true,
                          ),
                    ),
                    DatosDocumentos(
                      onButtonGenerateCodePressed: () =>
                          showAppBottomSheetPregunta(
                            context: context,
                            title: AppLocale.textTituloGenerarCodigo.getString(
                              context,
                            ),
                            question: AppLocale.descripcionGenerarCodigo
                                .getString(context),
                            yes: AppLocale.botonGenerarCodigo.getString(
                              context,
                            ),
                            onYes: () => nuevoTramiteCubit.generarTramite(),
                          ),
                      onButtonBackPressed: () =>
                          nuevoTramiteCubit.cambiarPagina(
                            NuevoTramiteState.detallePagoSaldo,
                            isBack: true,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
