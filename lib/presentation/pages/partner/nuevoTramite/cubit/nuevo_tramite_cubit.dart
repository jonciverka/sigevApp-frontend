// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/core/utilities/utilities.dart';
import 'package:sigev/domain/models/catalogo_cotizacion.dart';
import 'package:sigev/domain/models/cilindros.dart';
import 'package:sigev/domain/models/clase.dart';
import 'package:sigev/domain/models/color.dart';
import 'package:sigev/domain/models/combustible.dart';
import 'package:sigev/domain/models/cotizacion.dart';
import 'package:sigev/domain/models/documentacion.dart';
import 'package:sigev/domain/models/entidad.dart';
import 'package:sigev/domain/models/extra.dart';
import 'package:sigev/domain/models/pasajeros.dart';
import 'package:sigev/domain/models/puerta.dart';
import 'package:sigev/domain/models/sucursal.dart';
import 'package:sigev/domain/models/terminacion_placa.dart';
import 'package:sigev/domain/models/tipo_desecho.dart';
import 'package:sigev/domain/models/tipo_modelo.dart';
import 'package:sigev/domain/models/tipo_servicio.dart';
import 'package:sigev/domain/models/tipo_tramite.dart';
import 'package:sigev/domain/models/tipo_vehiculos.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/domain/models/transmision.dart';
import 'package:sigev/domain/models/transporta.dart';
import 'package:sigev/domain/models/vehiculo.dart';
import 'package:sigev/domain/providers/cotizacion_tramite_provider.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_state.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_loader_creando_tramite.dart';
import 'package:sigev/presentation/widgets/app_toast_notification.dart';

enum ProgressBarStatus {
  contribuyente(1.0),
  tramite(2.0),
  vehiculo(3.0),
  pago(5.0);

  final double value;

  const ProgressBarStatus(this.value);
}

class NuevoTramiteCubit extends Cubit<NuevoTramiteState> {
  final provider = CotizacionTramiteProvider();
  final BuildContext _context;

  final PageController _pageController = PageController();
  PageController get pageController => _pageController;
  double get page => _pageController.hasClients ? _pageController.page ?? 0 : 0;

  //Datos contribuyente
  GlobalKey<FormState> formularioStateContribuyente = GlobalKey<FormState>();
  GlobalKey<FormState> formularioStateDatosContribuyente =
      GlobalKey<FormState>();
  Sucursal? sucursal;
  final correoElectronicoController = TextEditingController();
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final telefonoController = TextEditingController();
  final telefonoAlternoController = TextEditingController();
  //Datos tramite
  GlobalKey<FormState> formularioStateDatosTramite = GlobalKey<FormState>();
  TipoTramite? tipoTramite;
  TipoVehiculo? tipoVehiculo;
  Entidad? entidad;
  TipoServicio? tipoServicio;
  //Datos del vehiculo
  GlobalKey<FormState> formularioStateVehiculo = GlobalKey<FormState>();
  Vehiculo? vehiculo;
  final subMarcaController = TextEditingController();
  TipoModelo? tipoModelo;
  ColorVehiculo? color;
  //Datos del vehiculo detalle
  GlobalKey<FormState> formularioStateVehiculoDetalle = GlobalKey<FormState>();
  final noSerieController = TextEditingController();
  final noMotorController = TextEditingController();
  Combustible? combustible;
  Puerta? puerta;
  Pasajeros? pasajeros;
  Clase? clase;
  Clase? claseCarga;
  Cilindros? cilindros;
  Transmision? transmision;
  final capacidadCarga = TextEditingController();
  Transporta? transporta;
  Clase? claseMoto;
  final centimetrosCubicos = TextEditingController();
  Clase? claseRemol;

  //Datos del vehiculo placa
  GlobalKey<FormState> formularioStateVehiculoPlaca = GlobalKey<FormState>();
  String groupRadioButtonPlacaActual = "2";
  String groupRadioButtonDesechoPlaca = "2";
  String groupRadioButtonDesechoTarjeta = "2";
  String groupRadioButtonTerminacionPlacaNueva = "2";
  final placaActualController = TextEditingController();
  Entidad? entidadPlacaActual;
  String groupRadioButtonDesechoPlacaEntregado = "1";
  TipoDesecho? tipoDesechoPlacaEntregado;
  String groupRadioButtonDesechoTarjetaEntregado = "1";
  TerminacionPlaca? terminacionPlacaEntregadoOpcionUno;
  TerminacionPlaca? terminacionPlacaEntregadoOpcionDos;

  //Detalles de pago
  GlobalKey<FormState> formularioStateDetalleDePago = GlobalKey<FormState>();
  GlobalKey<FormState> formularioStateDetalleDePagoSaldo =
      GlobalKey<FormState>();
  final subtotalController = TextEditingController();
  final extrasController = TextEditingController();
  final descuentoController = TextEditingController();
  final totalController = TextEditingController();
  final aCuentaController = TextEditingController();
  //Extras
  List<Extra> extras = [];
  GlobalKey<FormState> formularioStateExtras = GlobalKey<FormState>();

  final saldoController = TextEditingController();
  final notasController = TextEditingController();
  //Documentos
  List<Documentacion> documentaciones = [];
  //Resultado
  String claveTramite = '';

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

  Future<void> cambiarPagina(int index, {bool isBack = false}) async {
    FocusScope.of(_context).unfocus();
    if (!isBack) {
      switch (index - 1) {
        case NuevoTramiteState.datosDelContribuyenteSucursal:
          if (!validateDatosContribuyenteSucursal()) {
            return;
          }
          break;
        case NuevoTramiteState.datosDelContribuyente:
          if (!validateDatosContribuyente()) {
            return;
          }
          break;
        case NuevoTramiteState.datosDelTramite:
          if (!validateDatosTramite()) {
            return;
          }
          break;
        case NuevoTramiteState.datosDelVehiculo:
          if (!validateDatosVehiculo()) {
            return;
          }
          break;
        case NuevoTramiteState.datosDelVehiculoPlacas:
          if (!validateDatosVehiculoPlacas()) {
            return;
          }
          break;
        case NuevoTramiteState.detallePago:
          if (!validateDetalleDePago()) {
            return;
          }
        case NuevoTramiteState.detallePagoSaldo:
          if (!validateDetalleDePagoSaldo()) {
            return;
          }
          break;
        case NuevoTramiteState.datosDelVehiculoDetalle:
          if (mostrarDatosVehiculoDetalle()) {
            if (!validateDatosVehiculoDetalle()) return;
          }

          break;
      }
    }
    await _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    emit(NuevoTramiteData(catalogos: state.catalogos));
  }

  bool mostrarDatosVehiculoDetalle() {
    if (tipoTramite?.id == 18) return false;
    return true;
  }

  bool validateDatosContribuyenteSucursal() {
    if (!formularioStateContribuyente.currentState!.validate()) {
      _showToastNotification();
      return false;
    }
    if (sucursal == null) {
      _showToastNotification();
      return false;
    }
    return true;
  }

  bool validateDatosContribuyente() {
    if (!formularioStateDatosContribuyente.currentState!.validate()) {
      _showToastNotification();
      return false;
    }
    if (correoElectronicoController.text.isEmpty ||
        nombreController.text.isEmpty ||
        apellidoController.text.isEmpty ||
        telefonoController.text.isEmpty) {
      _showToastNotification();
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
    if (!formularioStateDatosTramite.currentState!.validate()) {
      _showToastNotification();
      return false;
    }
    if (tipoTramite == null ||
        tipoVehiculo == null ||
        entidad == null ||
        tipoServicio == null) {
      _showToastNotification();
      return false;
    }

    return true;
  }

  bool validateDatosVehiculo() {
    if (!formularioStateVehiculo.currentState!.validate()) {
      _showToastNotification();
      return false;
    }
    if (vehiculo == null || tipoModelo == null || color == null) {
      _showToastNotification();
      return false;
    }

    return true;
  }

  bool validateDatosVehiculoDetalle() {
    if (!formularioStateVehiculoDetalle.currentState!.validate()) {
      _showToastNotification();
      return false;
    }

    return true;
  }

  bool validateDatosVehiculoPlacas() {
    if (!formularioStateVehiculoPlaca.currentState!.validate()) {
      _showToastNotification();
      return false;
    }
    if (groupRadioButtonPlacaActual == '' ||
        groupRadioButtonDesechoPlaca == '' ||
        groupRadioButtonDesechoTarjeta == '' ||
        groupRadioButtonTerminacionPlacaNueva == '') {
      _showToastNotification();
      return false;
    }
    if (groupRadioButtonPlacaActual == '1') {
      if (placaActualController.text.isEmpty || entidadPlacaActual == null) {
        _showToastNotification();
        return false;
      }
    }
    if (groupRadioButtonDesechoPlaca == '1') {
      if (tipoDesechoPlacaEntregado == null ||
          groupRadioButtonDesechoPlacaEntregado == '') {
        _showToastNotification();
        return false;
      }
    }
    if (groupRadioButtonDesechoTarjeta == '1') {
      if (groupRadioButtonDesechoTarjetaEntregado == '') {
        _showToastNotification();
        return false;
      }
    }
    if (groupRadioButtonTerminacionPlacaNueva == '1') {
      if (terminacionPlacaEntregadoOpcionUno == null ||
          terminacionPlacaEntregadoOpcionDos == null) {
        _showToastNotification();
        return false;
      }
    }

    return true;
  }

  bool validateDetalleDePago() {
    if (!formularioStateDetalleDePago.currentState!.validate()) {
      _showToastNotification();
      return false;
    }

    return true;
  }

  bool validateDetalleDePagoSaldo() {
    if (!formularioStateDetalleDePagoSaldo.currentState!.validate()) {
      _showToastNotification();
      return false;
    }

    return true;
  }

  bool validateExtras() {
    if (!formularioStateExtras.currentState!.validate()) {
      _showToastNotification();
      return false;
    }

    extrasController.text = extras
        .fold<double>(0, (sum, e) => sum + (e.monto ?? 0))
        .toString();
    if (extrasController.text == '0.0') extrasController.clear();
    setTotal();
    return true;
  }

  void _showToastNotification() {
    showToastNotification(
      context: _context,
      message: AppLocale.camposObligatorios.getString(_context),
      type: ToastType.error,
    );
  }

  void changeValueRadio(String value, String groupValue) {
    switch (groupValue) {
      case "groupRadioButtonPlacaActual":
        placaActualController.clear();
        entidadPlacaActual = null;
        groupRadioButtonPlacaActual = value;
        break;
      case "groupRadioButtonDesechoPlaca":
        groupRadioButtonDesechoPlaca = value;
        tipoDesechoPlacaEntregado = null;
        groupRadioButtonDesechoPlacaEntregado = '';
        break;
      case "groupRadioButtonDesechoTarjeta":
        groupRadioButtonDesechoTarjeta = value;
        groupRadioButtonDesechoTarjetaEntregado = '';
        break;
      case "groupRadioButtonTerminacionPlacaNueva":
        groupRadioButtonTerminacionPlacaNueva = value;
        terminacionPlacaEntregadoOpcionUno = null;
        terminacionPlacaEntregadoOpcionDos = null;
        break;
      case "groupRadioButtonDesechoPlacaEntregado":
        groupRadioButtonDesechoPlacaEntregado = value;
        break;
      case "groupRadioButtonDesechoTarjetaEntregado":
        groupRadioButtonDesechoTarjetaEntregado = value;
        break;
      case "groupRadioButtonPasajeros":
        pasajeros = null;
        break;
      case "groupRadioButtonRemolque":
        claseCarga = null;
        break;
      case "groupRadioButtonTransporta":
        transporta = null;
        break;
    }
    groupValue = value;
    emit(NuevoTramiteData(catalogos: state.catalogos));
  }

  void addExtras(Extra extra) {
    extras.add(extra.copyWith());

    emit(NuevoTramiteData(catalogos: state.catalogos));
  }

  void removeExtras(Extra extra) {
    extras.remove(extra);

    emit(NuevoTramiteData(catalogos: state.catalogos));
  }

  void setTotal() {
    double subTotal = double.tryParse(subtotalController.text) ?? 0;
    double extras = double.tryParse(extrasController.text) ?? 0;
    double descuento = double.tryParse(descuentoController.text) ?? 0;
    totalController.text = (subTotal + extras - descuento).toString();
    setSaldo();
    emit(NuevoTramiteData(catalogos: state.catalogos));
  }

  void setSaldo() {
    double total = double.tryParse(totalController.text) ?? 0;
    double aCuenta = double.tryParse(aCuentaController.text) ?? 0;
    saldoController.text = (total - aCuenta).toString();
    emit(NuevoTramiteData(catalogos: state.catalogos));
  }

  void addDocumentacion({required Documentacion documentacion}) {
    documentaciones.add(documentacion);
    emit(NuevoTramiteData(catalogos: state.catalogos));
  }

  bool haveDocumentacion({required Documentacion documentacion}) {
    return documentaciones.contains(documentacion);
  }

  void removeDocumentacion({required Documentacion documentacion}) {
    documentaciones.remove(documentacion);
    emit(NuevoTramiteData(catalogos: state.catalogos));
  }

  Future<void> generarTramite() async {
    Cotizacion cotizacion = Cotizacion(
      sucursal: "${sucursal?.id}-${sucursal?.alias}",
      telefono: telefonoController.text,
      nombre: nombreController.text,
      apellidos: apellidoController.text,
      telefonoAlterno: telefonoAlternoController.text == ''
          ? null
          : telefonoAlternoController.text,
      correo: correoElectronicoController.text,
      tipoTramite: "${tipoTramite?.id}-${tipoTramite?.alias}",
      tipoVehiculo: "${tipoVehiculo?.id}-${tipoVehiculo?.nombre}",
      entidad: "${entidad?.id}-${entidad?.entidadNombre}",
      tipoServicio: "${tipoServicio?.id}-${tipoServicio?.nombre}",
      marca: "${vehiculo?.id}-${vehiculo?.marca}",
      submarca: subMarcaController.text,
      modelo: "${tipoModelo?.id}-${tipoModelo?.anio}",
      idColor: color?.id,
      placasNa: groupRadioButtonPlacaActual == '1' ? null : 1,
      placaActual: placaActualController.text,
      entidadPlaca: entidadPlacaActual == null
          ? null
          : "${entidadPlacaActual?.id}-${entidadPlacaActual?.entidadAbreviatura}",
      desechoNa: groupRadioButtonDesechoPlaca == '1' ? null : 1,
      desechoTipo: tipoDesechoPlacaEntregado?.nombre,
      desechoPlacaEntregado: groupRadioButtonDesechoPlacaEntregado == '1'
          ? 1
          : groupRadioButtonDesechoPlacaEntregado == ''
          ? null
          : 0,
      desechoTarjetaNa: groupRadioButtonDesechoTarjeta == '1' ? null : 1,
      desechoTarjetaEntregado: groupRadioButtonDesechoTarjetaEntregado == '1'
          ? "1"
          : groupRadioButtonDesechoTarjetaEntregado == ''
          ? null
          : "0",
      terminacionPnNa: groupRadioButtonTerminacionPlacaNueva == '1' ? null : 1,
      termPlaca1: terminacionPlacaEntregadoOpcionUno?.valor,
      termPlaca2: terminacionPlacaEntregadoOpcionDos?.valor,
      subtotal: double.tryParse(subtotalController.text) ?? 0,
      descuento: double.tryParse(descuentoController.text),
      total: double.tryParse(totalController.text) ?? 0,
      acuenta: double.tryParse(aCuentaController.text) ?? 0,
      saldo: double.tryParse(saldoController.text),
      nota: notasController.text == '' ? null : notasController.text,
      extrasConcepto: extras.map((e) => e.alias ?? '').toList(),
      extrasImporte: extras.map((e) => (e.monto ?? 0).toString()).toList(),
      documentacion: documentaciones,
    );
    Tramite tramiteNormal = Tramite(
      numeroSerie: noSerieController.text,
      numeroMotor: noMotorController.text,
      idCombustible: combustible?.valor ?? 0,
      combustible: combustible?.nombre ?? '',
      puertas: puerta?.valor ?? 0,
      pasajeros: pasajeros?.valor ?? 0,
      idClase: clase?.valor ?? 0,
      clase: clase?.nombre ?? '',
      cilindrada: cilindros?.valor ?? 0,
      idTransmicion: transmision?.valor ?? 0,
      transmicion: transmision?.nombre ?? '',
    );
    Tramite tramiteCarga = Tramite(
      numeroSerie: noSerieController.text,
      numeroMotor: noMotorController.text,
      pasajeros: pasajeros?.valor ?? 0,
      idCombustible: combustible?.valor ?? 0,
      combustible: combustible?.nombre ?? '',
      cilindrada: cilindros?.valor ?? 0,
      puertas: puerta?.valor ?? 0,
      idClase: claseCarga?.valor ?? 0,
      clase: claseCarga?.nombre ?? '',
      capacidad: int.tryParse(capacidadCarga.text) ?? 0,
      idTransporta: transporta?.valor ?? 0,
      transporta: transporta?.nombre ?? '',
    );
    Tramite tramiteRemol = Tramite(
      numeroSerie: noSerieController.text,
      numeroMotor: noMotorController.text,
      capacidad: int.tryParse(capacidadCarga.text) ?? 0,
      pasajeros: pasajeros?.valor,
      idClase: claseRemol?.valor,
      clase: claseRemol?.nombre,
      combustible: combustible?.nombre ?? '',
      cilindrada: cilindros?.valor ?? 0,
      idTransporta: transporta?.valor,
      transporta: transporta?.nombre,
    );
    Tramite tramiteMoto = Tramite(
      numeroSerie: noSerieController.text,
      numeroMotor: noMotorController.text,
      idClase: claseMoto?.valor ?? 0,
      clase: claseMoto?.nombre ?? '',
      cmCubicos: int.tryParse(centimetrosCubicos.text) ?? 0,
      combustible: combustible?.nombre ?? '',
      cilindrada: cilindros?.valor ?? 0,
    );
    try {
      emit(
        NuevoTramiteLoadingCreate(
          catalogos: state.catalogos,
          status: StatusCreandoTramite.creandoCotizacion,
        ),
      );
      var clave = await provider.createCotizacion(cotizacion: cotizacion);
      await Future.delayed(const Duration(seconds: 5), () {});
      Tramite? tramiteMandar = switch (tipoVehiculo?.id ?? 0) {
        3 => tramiteCarga,
        5 => tramiteRemol,
        2 => tramiteMoto,
        _ => tramiteNormal,
      };
      emit(
        NuevoTramiteLoadingCreate(
          catalogos: state.catalogos,
          status: StatusCreandoTramite.creandoTramite,
        ),
      );
      claveTramite = await provider.createTramite(
        clave: clave,
        tramite: mostrarDatosVehiculoDetalle() ? tramiteMandar : null,
      );
      await Future.delayed(const Duration(seconds: 4), () {});
      emit(
        NuevoTramiteLoadingCreate(
          catalogos: state.catalogos,
          status: StatusCreandoTramite.esperando,
        ),
      );
      await Future.delayed(const Duration(seconds: 4), () {});
      emit(
        NuevoTramiteLoadingCreate(
          catalogos: state.catalogos,
          status: StatusCreandoTramite.esperando,
        ),
      );
      await Future.delayed(const Duration(seconds: 1), () {});
      emit(
        NuevoTramiteLoadingCreate(
          catalogos: state.catalogos,
          status: StatusCreandoTramite.finalizado,
        ),
      );
      await Future.delayed(const Duration(seconds: 1), () {});
      emit(
        NuevoTramiteLoadingSucess(
          catalogos: state.catalogos,
          status: StatusCreandoTramite.inicio,
        ),
      );
    } on ServerErrorException {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(NuevoTramiteData(catalogos: state.catalogos));
      return;
    } on NetworkException {
      showToastNotification(
        context: _context,
        message: AppLocale.avisoSinInternet.getString(_context),
        type: ToastType.error,
      );
      emit(NuevoTramiteData(catalogos: state.catalogos));
      return;
    } on ApiClientException catch (e) {
      showToastNotification(
        context: _context,
        message: e.message,
        type: ToastType.error,
      );
      emit(NuevoTramiteData(catalogos: state.catalogos));
      return;
    } catch (e) {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(NuevoTramiteData(catalogos: state.catalogos));
      return;
    }
    // print(cotizacion.toJson());
  }

  ProgressBarStatus getStatusPage() {
    if (page == NuevoTramiteState.datosDelContribuyenteSucursal ||
        page == NuevoTramiteState.datosDelContribuyente) {
      return ProgressBarStatus.contribuyente;
    } else if (page == NuevoTramiteState.datosDelTramite) {
      return ProgressBarStatus.tramite;
    } else if (page == NuevoTramiteState.datosDelVehiculo ||
        page == NuevoTramiteState.datosDelVehiculoPlacas ||
        page == NuevoTramiteState.datosDelVehiculoDetalle) {
      return ProgressBarStatus.vehiculo;
    } else if (page == NuevoTramiteState.detallePago ||
        page == NuevoTramiteState.detallePagoSaldo ||
        page == NuevoTramiteState.detallePago ||
        page == NuevoTramiteState.detalleDocumentos) {
      return ProgressBarStatus.pago;
    } else {
      return ProgressBarStatus.contribuyente;
    }
  }

  onSelectItem(Function onSelectItem) {
    emit(NuevoTramiteData(catalogos: state.catalogos));
    FocusScope.of(_context).unfocus();
    onSelectItem();
  }
}
