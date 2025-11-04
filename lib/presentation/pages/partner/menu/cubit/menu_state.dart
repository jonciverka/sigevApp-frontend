import 'package:sigev/domain/models/catalogo.dart';
import 'package:sigev/domain/models/tramite.dart';
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

  MenuState({
    required this.index,
    required this.catalogoPrecios,
    required this.catalogoEstatusTramite,
  });

  final int index;
  final List<Catalogo> catalogoPrecios;
  final List<Status> catalogoEstatusTramite;
  MenuState copyWith();
}

class MenuInitial extends MenuState {
  MenuInitial()
    : super(
        index: MenuState.homePageIndex,
        catalogoPrecios: [],
        catalogoEstatusTramite: [],
      );

  @override
  MenuState copyWith() => MenuInitial();
}

class MenuLoading extends MenuState {
  MenuLoading({
    int? index,
    List<Catalogo>? catalogoPrecios,
    List<Status>? catalogoEstatusTramite,
  }) : super(
         index: index ?? MenuState.homePageIndex,
         catalogoPrecios: catalogoPrecios ?? [],
         catalogoEstatusTramite: catalogoEstatusTramite ?? [],
       );

  @override
  MenuState copyWith({
    int? index,
    List<Catalogo>? catalogoPrecios,
    List<Status>? catalogoEstatusTramite,
  }) => MenuLoading(
    index: index ?? this.index,
    catalogoPrecios: catalogoPrecios ?? this.catalogoPrecios,
    catalogoEstatusTramite:
        catalogoEstatusTramite ?? this.catalogoEstatusTramite,
  );
}

class MenuData extends MenuState {
  MenuData({
    required super.index,
    required super.catalogoPrecios,
    required super.catalogoEstatusTramite,
  });

  @override
  MenuState copyWith({
    int? index,
    List<Catalogo>? catalogoPrecios,
    List<Status>? catalogoEstatusTramite,
  }) => MenuData(
    index: index ?? this.index,
    catalogoPrecios: catalogoPrecios ?? this.catalogoPrecios,
    catalogoEstatusTramite:
        catalogoEstatusTramite ?? this.catalogoEstatusTramite,
  );
}

class MenuError extends MenuState {
  MenuError()
    : super(
        index: MenuState.homePageIndex,
        catalogoPrecios: [],
        catalogoEstatusTramite: [],
      );

  @override
  MenuState copyWith({
    int? index,
    List<Catalogo>? catalogoPrecios,
    List<Status>? catalogoEstatusTramite,
  }) => MenuError();
}
