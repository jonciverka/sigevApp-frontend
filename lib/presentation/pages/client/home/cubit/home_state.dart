import 'package:sigev/domain/models/tramite.dart';

abstract class HomeState {
  HomeState({required this.tramites});

  final List<Tramite> tramites;
  HomeState copyWith();
}

class HomeInitial extends HomeState {
  HomeInitial() : super(tramites: []);

  @override
  HomeState copyWith() => HomeInitial();
}

class HomeLoading extends HomeState {
  HomeLoading({List<Tramite>? tramites}) : super(tramites: tramites ?? []);

  @override
  HomeState copyWith({List<Tramite>? tramites}) =>
      HomeLoading(tramites: tramites ?? this.tramites);
}

class HomeData extends HomeState {
  HomeData({required super.tramites}) : super();

  @override
  HomeState copyWith({List<Tramite>? tramites}) =>
      HomeData(tramites: tramites ?? this.tramites);
}

class HomeError extends HomeState {
  HomeError() : super(tramites: []);

  @override
  HomeState copyWith({List<Tramite>? tramites}) => HomeError();
}
