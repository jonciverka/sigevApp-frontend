import 'package:flutter/cupertino.dart';
import 'package:sigev/domain/models/catalogo.dart';
import 'package:sigev/presentation/pages/partner/home/screens/home_page.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/nuevo_tramite_page.dart';
import 'package:sigev/presentation/pages/partner/tramites/screens/tramites_page.dart';
import 'package:sigev/presentation/pages/profile/screens/profile_page.dart';

abstract class MenuState {
  static const int homePageIndex = 0;
  static const int homeNewProcess = 1;
  static const int homeMyProcess = 2;
  static const int homeProfile = 3;

  static List listScreens = [
    HomePage(),
    NuevoTramite(),
    TramitesPage(),
    ProfilePage(),
  ];

  MenuState({required this.index, required this.catalogoPrecios});

  final int index;
  final List<Catalogo> catalogoPrecios;
  MenuState copyWith();
}

class MenuInitial extends MenuState {
  MenuInitial() : super(index: MenuState.homePageIndex, catalogoPrecios: []);

  @override
  MenuState copyWith() => MenuInitial();
}

class MenuLoading extends MenuState {
  MenuLoading({int? index, List<Catalogo>? catalogoPrecios})
    : super(
        index: index ?? MenuState.homePageIndex,
        catalogoPrecios: catalogoPrecios ?? [],
      );

  @override
  MenuState copyWith({int? index, List<Catalogo>? catalogoPrecios}) =>
      MenuLoading(
        index: index ?? this.index,
        catalogoPrecios: catalogoPrecios ?? this.catalogoPrecios,
      );
}

class MenuData extends MenuState {
  MenuData({required super.index, required super.catalogoPrecios});

  @override
  MenuState copyWith({int? index, List<Catalogo>? catalogoPrecios}) => MenuData(
    index: index ?? this.index,
    catalogoPrecios: catalogoPrecios ?? this.catalogoPrecios,
  );
}

class MenuError extends MenuState {
  MenuError() : super(index: MenuState.homePageIndex, catalogoPrecios: []);

  @override
  MenuState copyWith({int? index, List<Catalogo>? catalogoPrecios}) =>
      MenuError();
}
