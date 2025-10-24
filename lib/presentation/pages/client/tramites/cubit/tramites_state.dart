import 'package:sigev/domain/models/tramite.dart';

abstract class TramitesState {
  TramitesState({required this.tramites, required this.tramitesBuscados});

  final List<Tramite> tramites;
  final List<Tramite> tramitesBuscados;
  TramitesState copyWith();
}

class TramitesInitial extends TramitesState {
  TramitesInitial() : super(tramites: [], tramitesBuscados: []);

  @override
  TramitesState copyWith() => TramitesInitial();
}

class TramitesLoading extends TramitesState {
  TramitesLoading({
    List<Tramite>? tramites,
    List<Tramite>? tramitesBuscados,
    List<Status>? catalogoEstatusTramite,
  }) : super(tramites: tramites ?? [], tramitesBuscados: []);

  @override
  TramitesState copyWith({
    List<Tramite>? tramites,
    List<Tramite>? tramitesBuscados,
    List<Status>? catalogoEstatusTramite,
  }) => TramitesLoading(
    tramites: tramites ?? this.tramites,
    tramitesBuscados: tramitesBuscados ?? this.tramitesBuscados,
  );
}

class TramitesData extends TramitesState {
  TramitesData({required super.tramites, required super.tramitesBuscados})
    : super();

  @override
  TramitesState copyWith({
    List<Tramite>? tramites,
    List<Tramite>? tramitesBuscados,
  }) => TramitesData(
    tramites: tramites ?? this.tramites,
    tramitesBuscados: tramitesBuscados ?? this.tramitesBuscados,
  );
}

class TramitesError extends TramitesState {
  TramitesError() : super(tramites: [], tramitesBuscados: []);

  @override
  TramitesState copyWith({
    List<Tramite>? tramites,
    List<Tramite>? tramitesBuscados,
    List<Status>? catalogoEstatusTramite,
  }) => TramitesError();
}
