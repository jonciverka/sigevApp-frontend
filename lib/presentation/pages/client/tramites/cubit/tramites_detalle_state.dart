import 'package:sigev/domain/models/documentacion.dart';
import 'package:sigev/domain/models/tramite.dart';

abstract class TramiteDetalleState {
  TramiteDetalleState({required this.documentacion, required this.tramite});

  final List<Documentacion> documentacion;
  final Tramite tramite;
  TramiteDetalleState copyWith();
}

class TramiteDetalleInitial extends TramiteDetalleState {
  TramiteDetalleInitial() : super(documentacion: [], tramite: Tramite());

  @override
  TramiteDetalleState copyWith() => TramiteDetalleInitial();
}

class TramiteDetalleLoading extends TramiteDetalleState {
  TramiteDetalleLoading({List<Documentacion>? documentacion, Tramite? tramite})
    : super(documentacion: documentacion ?? [], tramite: tramite ?? Tramite());

  @override
  TramiteDetalleState copyWith({
    List<Documentacion>? documentacion,
    Tramite? tramite,
  }) => TramiteDetalleLoading(
    documentacion: documentacion ?? this.documentacion,
    tramite: tramite ?? this.tramite,
  );
}

class TramiteDetalleData extends TramiteDetalleState {
  TramiteDetalleData({required super.documentacion, required super.tramite})
    : super();

  @override
  TramiteDetalleState copyWith({
    List<Documentacion>? documentacion,
    Tramite? tramite,
  }) => TramiteDetalleData(
    documentacion: documentacion ?? this.documentacion,
    tramite: tramite ?? this.tramite,
  );
}

class TramiteDetalleError extends TramiteDetalleState {
  TramiteDetalleError() : super(documentacion: [], tramite: Tramite());

  @override
  TramiteDetalleState copyWith({
    List<Documentacion>? documentacion,
    Tramite? tramite,
  }) => TramiteDetalleError();
}
