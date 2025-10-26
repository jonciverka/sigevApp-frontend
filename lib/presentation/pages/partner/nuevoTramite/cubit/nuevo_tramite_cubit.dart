// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/catalogo_cotizacion.dart';
import 'package:sigev/domain/providers/cotizacion_tramite_provider.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_state.dart';
import 'package:sigev/presentation/widgets/app_toast_notification.dart';

class NuevoTramiteCubit extends Cubit<NuevoTramiteState> {
  final provider = CotizacionTramiteProvider();
  final BuildContext _context;

  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  //Datos contribuyente
  final correoElectronicoController = TextEditingController();
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final telefonoController = TextEditingController();
  final telefonoAlternoController = TextEditingController();
  final subMarcaController = TextEditingController();
  final groupRadioButtonPlacaActual = "placaActual";
  final placaActualController = TextEditingController();

  final groupRadioButtonDesechoPlaca = "desechoPlaca";
  final desechoPlacaController = TextEditingController();
  final groupRadioButtonDesechoTarjeta = "desechoTarjetaCirculacion";
  final groupRadioButtonDesechoTarjetaEntregado =
      "desechoTarjetaCirculacionEntregado";
  final groupRadioButtonTerminacionPlacaNueva = "terminacionPlacaNueva";
  NuevoTramiteCubit({required BuildContext context})
    : _context = context,
      super(NuevoTramiteInitial()) {
    obtenerCatalogos();
  }
  Future<void> obtenerCatalogos() async {
    try {
      emit(NuevoTramiteLoading());
      CatalogoCotizacion catalogos = await provider.getCatalogos();
      emit(NuevoTramiteData(catalogos: catalogos));
    } on ServerErrorException {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(NuevoTramiteLoading());
      return;
    } on NetworkException {
      showToastNotification(
        context: _context,
        message: AppLocale.avisoSinInternet.getString(_context),
        type: ToastType.error,
      );
      emit(NuevoTramiteLoading());
      return;
    } on ApiClientException catch (e) {
      showToastNotification(
        context: _context,
        message: e.message,
        type: ToastType.error,
      );
      emit(NuevoTramiteLoading());
      return;
    } catch (e) {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(NuevoTramiteLoading());
      return;
    }
  }

  void cambiarPagina(int index) => _pageController.animateToPage(
    index,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );
}
