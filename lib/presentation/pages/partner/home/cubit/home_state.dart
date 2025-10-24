import 'package:sigev/domain/models/barra_fija.dart';

abstract class HomeState {
  HomeState({required this.barraFija});

  final BarraFija barraFija;
  HomeState copyWith();
}

class HomeInitial extends HomeState {
  HomeInitial() : super(barraFija: BarraFija());

  @override
  HomeState copyWith() => HomeInitial();
}

class HomeLoading extends HomeState {
  HomeLoading({BarraFija? barraFija})
    : super(barraFija: barraFija ?? BarraFija());

  @override
  HomeState copyWith({BarraFija? barraFija}) =>
      HomeLoading(barraFija: barraFija ?? this.barraFija);
}

class HomeData extends HomeState {
  HomeData({required super.barraFija}) : super();

  @override
  HomeState copyWith({BarraFija? barraFija}) =>
      HomeData(barraFija: barraFija ?? this.barraFija);
}

class HomeError extends HomeState {
  HomeError() : super(barraFija: BarraFija());

  @override
  HomeState copyWith({BarraFija? barraFija}) => HomeError();
}
