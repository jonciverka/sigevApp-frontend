import 'package:sigev/domain/models/catalogo_cotizacion.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_loader_creando_tramite.dart';

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
  NuevoTramiteState({
    required this.catalogos,
    this.status = StatusCreandoTramite.inicio,
  });

  final CatalogoCotizacion catalogos;
  final StatusCreandoTramite status;
  NuevoTramiteState copyWith();
}

class NuevoTramiteInitial extends NuevoTramiteState {
  NuevoTramiteInitial()
    : super(
        catalogos: CatalogoCotizacion(),
        status: StatusCreandoTramite.inicio,
      );

  @override
  NuevoTramiteState copyWith() => NuevoTramiteInitial();
}

class NuevoTramiteLoading extends NuevoTramiteState {
  NuevoTramiteLoading({
    CatalogoCotizacion? catalogos,
    StatusCreandoTramite? status,
  }) : super(
         catalogos: catalogos ?? CatalogoCotizacion(),
         status: status ?? StatusCreandoTramite.inicio,
       );

  @override
  NuevoTramiteState copyWith({
    CatalogoCotizacion? catalogos,
    StatusCreandoTramite? status,
  }) => NuevoTramiteLoading(
    catalogos: catalogos ?? this.catalogos,
    status: status ?? this.status,
  );
}

class NuevoTramiteLoadingCreate extends NuevoTramiteState {
  NuevoTramiteLoadingCreate({
    CatalogoCotizacion? catalogos,
    StatusCreandoTramite? status,
  }) : super(
         catalogos: catalogos ?? CatalogoCotizacion(),
         status: status ?? StatusCreandoTramite.inicio,
       );

  @override
  NuevoTramiteState copyWith({
    CatalogoCotizacion? catalogos,
    StatusCreandoTramite? status,
  }) => NuevoTramiteLoading(
    catalogos: catalogos ?? this.catalogos,
    status: status ?? this.status,
  );
}

class NuevoTramiteLoadingSucess extends NuevoTramiteState {
  NuevoTramiteLoadingSucess({
    CatalogoCotizacion? catalogos,
    StatusCreandoTramite? status,
  }) : super(
         catalogos: catalogos ?? CatalogoCotizacion(),
         status: status ?? StatusCreandoTramite.inicio,
       );

  @override
  NuevoTramiteState copyWith({
    CatalogoCotizacion? catalogos,
    StatusCreandoTramite? status,
  }) => NuevoTramiteLoading(
    catalogos: catalogos ?? this.catalogos,
    status: status ?? this.status,
  );
}

class NuevoTramiteData extends NuevoTramiteState {
  NuevoTramiteData({required super.catalogos, super.status}) : super();

  @override
  NuevoTramiteState copyWith({
    CatalogoCotizacion? catalogos,
    StatusCreandoTramite? status,
  }) => NuevoTramiteData(
    catalogos: catalogos ?? this.catalogos,
    status: status ?? this.status,
  );
}

class NuevoTramiteError extends NuevoTramiteState {
  NuevoTramiteError()
    : super(
        catalogos: CatalogoCotizacion(),
        status: StatusCreandoTramite.inicio,
      );

  @override
  NuevoTramiteState copyWith({
    CatalogoCotizacion? catalogos,
    StatusCreandoTramite? status,
  }) => NuevoTramiteError();
}
