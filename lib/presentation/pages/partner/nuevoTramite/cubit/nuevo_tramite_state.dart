import 'package:sigev/domain/models/catalogo_cotizacion.dart';

abstract class NuevoTramiteState {
  static const int datosDelContribuyenteSucursal = 0;
  static const int datosDelContribuyente = 1;
  static const int datosDelTramite = 2;
  static const int datosDelVehiculo = 3;
  static const int datosDelVehiculoPlacas = 4;
  static const int detallePago = 5;
  // static const int detallePagoExtras = 6;
  static const int detallePagoSaldo = 6;
  static const int detalleDocumentos = 7;
  NuevoTramiteState({required this.catalogos});

  final CatalogoCotizacion catalogos;
  NuevoTramiteState copyWith();
}

class NuevoTramiteInitial extends NuevoTramiteState {
  NuevoTramiteInitial() : super(catalogos: CatalogoCotizacion());

  @override
  NuevoTramiteState copyWith() => NuevoTramiteInitial();
}

class NuevoTramiteLoading extends NuevoTramiteState {
  NuevoTramiteLoading({CatalogoCotizacion? catalogos})
    : super(catalogos: catalogos ?? CatalogoCotizacion());

  @override
  NuevoTramiteState copyWith({CatalogoCotizacion? catalogos}) =>
      NuevoTramiteLoading(catalogos: catalogos ?? this.catalogos);
}

class NuevoTramiteData extends NuevoTramiteState {
  NuevoTramiteData({required super.catalogos}) : super();

  @override
  NuevoTramiteState copyWith({CatalogoCotizacion? catalogos}) =>
      NuevoTramiteData(catalogos: catalogos ?? this.catalogos);
}

class NuevoTramiteError extends NuevoTramiteState {
  NuevoTramiteError() : super(catalogos: CatalogoCotizacion());

  @override
  NuevoTramiteState copyWith({CatalogoCotizacion? catalogos}) =>
      NuevoTramiteError();
}
