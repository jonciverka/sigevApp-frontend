import 'package:sigev/domain/models/catalogo_cotizacion.dart';

abstract class NuevoTramiteState {
  NuevoTramiteState({required this.barraFija});

  final CatalogoCotizacion barraFija;
  NuevoTramiteState copyWith();
}

class NuevoTramiteInitial extends NuevoTramiteState {
  NuevoTramiteInitial() : super(barraFija: CatalogoCotizacion());

  @override
  NuevoTramiteState copyWith() => NuevoTramiteInitial();
}

class NuevoTramiteLoading extends NuevoTramiteState {
  NuevoTramiteLoading({CatalogoCotizacion? barraFija})
    : super(barraFija: barraFija ?? CatalogoCotizacion());

  @override
  NuevoTramiteState copyWith({CatalogoCotizacion? barraFija}) =>
      NuevoTramiteLoading(barraFija: barraFija ?? this.barraFija);
}

class NuevoTramiteData extends NuevoTramiteState {
  NuevoTramiteData({required super.barraFija}) : super();

  @override
  NuevoTramiteState copyWith({CatalogoCotizacion? barraFija}) =>
      NuevoTramiteData(barraFija: barraFija ?? this.barraFija);
}

class NuevoTramiteError extends NuevoTramiteState {
  NuevoTramiteError() : super(barraFija: CatalogoCotizacion());

  @override
  NuevoTramiteState copyWith({CatalogoCotizacion? barraFija}) =>
      NuevoTramiteError();
}
