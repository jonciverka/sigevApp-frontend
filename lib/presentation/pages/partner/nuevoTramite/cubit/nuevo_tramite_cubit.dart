// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/core/utilities/utilities.dart';
import 'package:sigev/domain/models/catalogo_cotizacion.dart';
import 'package:sigev/domain/models/color.dart';
import 'package:sigev/domain/models/entidad.dart';
import 'package:sigev/domain/models/tipo_modelo.dart';
import 'package:sigev/domain/models/tipo_servicio.dart';
import 'package:sigev/domain/models/tipo_tramite.dart';
import 'package:sigev/domain/models/tipo_vehiculos.dart';
import 'package:sigev/domain/models/vehiculo.dart';
import 'package:sigev/domain/providers/cotizacion_tramite_provider.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_state.dart';
import 'package:sigev/presentation/widgets/app_toast_notification.dart';

class NuevoTramiteCubit extends Cubit<NuevoTramiteState> {
  final provider = CotizacionTramiteProvider();
  final BuildContext _context;

  final PageController _pageController = PageController();
  PageController get pageController => _pageController;
  double get page => _pageController.hasClients ? _pageController.page ?? 0 : 0;

  //Datos contribuyente
  int idSucursal = 0;
  final correoElectronicoController = TextEditingController();
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final telefonoController = TextEditingController();
  final telefonoAlternoController = TextEditingController();
  final placaActualController = TextEditingController();
  //Datos tramite
  TipoTramite? tipoTramite;
  TipoVehiculo? tipoVehiculo;
  Entidad? entidad;
  TipoServicio? tipoServicio;
  //Datos del vehiculo
  Vehiculo? vehiculo;
  final subMarcaController = TextEditingController();
  TipoModelo? tipoModelo;
  ColorVehiculo? color;

  String groupRadioButtonPlacaActual = "";
  String groupRadioButtonDesechoPlaca = "";
  String groupRadioButtonDesechoTarjeta = "";
  String groupRadioButtonTerminacionPlacaNueva = "";

  final desechoPlacaController = TextEditingController();
  final groupRadioButtonDesechoTarjetaEntregado =
      "desechoTarjetaCirculacionEntregado";

  final subtotalController = TextEditingController();
  final extrasController = TextEditingController();
  final descuentoController = TextEditingController();
  final totalController = TextEditingController();
  final aCuentaController = TextEditingController();

  final saldoController = TextEditingController();
  final notasController = TextEditingController();

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

  Future<void> cambiarPagina(int index) async {
    switch (index - 1) {
      case 0:
        if (!validateDatosContribuyenteSucursal()) {
          return;
        }
        break;
      case 1:
        if (!validateDatosContribuyente()) {
          return;
        }
        break;
      case 2:
        if (!validateDatosTramite()) {
          return;
        }
        break;
      case 3:
        if (!validateDatosVehiculo()) {
          return;
        }
        break;
      case 4:
        if (!validateDatosVehiculoPlacas()) {
          return;
        }
        break;
    }
    await _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    emit(NuevoTramiteData(catalogos: state.catalogos));
  }

  bool validateDatosContribuyenteSucursal() {
    if (idSucursal == 0) {
      showToastNotification(
        context: _context,
        message: AppLocale.camposObligatorios.getString(_context),
        type: ToastType.error,
      );
      return false;
    }
    return true;
  }

  bool validateDatosContribuyente() {
    if (correoElectronicoController.text.isEmpty ||
        nombreController.text.isEmpty ||
        apellidoController.text.isEmpty ||
        telefonoController.text.isEmpty) {
      showToastNotification(
        context: _context,
        message: AppLocale.camposObligatorios.getString(_context),
        type: ToastType.error,
      );
      return false;
    }
    if (Utilities.isEmailValid(correoElectronicoController.text) == false) {
      showToastNotification(
        context: _context,
        message: AppLocale.errorCorreoMalFormado.getString(_context),
        type: ToastType.error,
      );
      return false;
    }

    return true;
  }

  bool validateDatosTramite() {
    if (tipoTramite == null ||
        tipoVehiculo == null ||
        entidad == null ||
        tipoServicio == null) {
      showToastNotification(
        context: _context,
        message: AppLocale.camposObligatorios.getString(_context),
        type: ToastType.error,
      );
      return false;
    }

    return true;
  }

  bool validateDatosVehiculo() {
    if (vehiculo == null || tipoModelo == null || color == null) {
      showToastNotification(
        context: _context,
        message: AppLocale.camposObligatorios.getString(_context),
        type: ToastType.error,
      );
      return false;
    }

    return true;
  }

  bool validateDatosVehiculoPlacas() {
    if (groupRadioButtonPlacaActual == '' ||
        groupRadioButtonDesechoPlaca == '' ||
        groupRadioButtonDesechoTarjeta == '' ||
        groupRadioButtonTerminacionPlacaNueva == '') {
      showToastNotification(
        context: _context,
        message: AppLocale.camposObligatorios.getString(_context),
        type: ToastType.error,
      );
      return false;
    }

    return true;
  }

  void changeValueRadio(String value, String groupValue) {
    switch (groupValue) {
      case "groupRadioButtonPlacaActual":
        groupRadioButtonPlacaActual = value;
        break;
      case "groupRadioButtonDesechoPlaca":
        groupRadioButtonDesechoPlaca = value;
        break;
      case "groupRadioButtonDesechoTarjeta":
        groupRadioButtonDesechoTarjeta = value;
        break;
      case "groupRadioButtonTerminacionPlacaNueva":
        groupRadioButtonTerminacionPlacaNueva = value;
        break;
    }
    groupValue = value;
    emit(NuevoTramiteData(catalogos: state.catalogos));
  }
}
