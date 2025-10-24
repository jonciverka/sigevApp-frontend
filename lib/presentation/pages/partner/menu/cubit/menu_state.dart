import 'package:flutter/cupertino.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/presentation/pages/partner/home/screens/home_page.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/nuevo_tramite_page.dart';
import 'package:sigev/presentation/pages/profile/screens/profile_page.dart';

abstract class MenuState {
  static const int homePageIndex = 0;
  static const int homeNewProcess = 1;
  static const int homeMyProcess = 2;
  static const int homeProfile = 3;

  static List listScreens = [
    HomePage(),
    NuevoTramite(),
    Container(),
    ProfilePage(),
  ];

  MenuState({required this.index});

  final int index;
  MenuState copyWith();
}

class MenuInitial extends MenuState {
  MenuInitial() : super(index: MenuState.homePageIndex);

  @override
  MenuState copyWith() => MenuInitial();
}

class MenuLoading extends MenuState {
  MenuLoading({int? index, List<Status>? catalogoEstatusTramite})
    : super(index: index ?? MenuState.homePageIndex);

  @override
  MenuState copyWith({int? index, List<Status>? catalogoEstatusTramite}) =>
      MenuLoading(index: index ?? this.index);
}

class MenuData extends MenuState {
  MenuData({required super.index});

  @override
  MenuState copyWith({int? index, List<Status>? catalogoEstatusTramite}) =>
      MenuData(index: index ?? this.index);
}

class MenuError extends MenuState {
  MenuError() : super(index: MenuState.homePageIndex);

  @override
  MenuState copyWith({int? index, List<Status>? catalogoEstatusTramite}) =>
      MenuError();
}
