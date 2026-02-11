import 'package:sigev/domain/models/tramite.dart';

abstract class SeguimientoState {
  SeguimientoState({required this.tramite});
  final Tramite tramite;

  SeguimientoState copyWith();
}

class SeguimientoInitial extends SeguimientoState {
  SeguimientoInitial() : super(tramite: Tramite());

  @override
  SeguimientoState copyWith() => SeguimientoInitial();
}

class SeguimientoLoading extends SeguimientoState {
  SeguimientoLoading({Tramite? tramite}) : super(tramite: tramite ?? Tramite());

  @override
  SeguimientoState copyWith({Tramite? tramite}) =>
      SeguimientoLoading(tramite: tramite ?? this.tramite);
}

class SeguimientoData extends SeguimientoState {
  SeguimientoData({required super.tramite}) : super();

  @override
  SeguimientoState copyWith({Tramite? tramite}) =>
      SeguimientoData(tramite: tramite ?? this.tramite);
}

class SeguimientoError extends SeguimientoState {
  SeguimientoError() : super(tramite: Tramite());

  @override
  SeguimientoState copyWith({Tramite? tramite}) => SeguimientoError();
}
