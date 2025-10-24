import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/presentation/pages/client/home/screens/home_page.dart';
import 'package:sigev/presentation/pages/client/tramites/screens/tramites_page.dart';
import 'package:sigev/presentation/pages/profile/screens/profile_page.dart';

abstract class MenuState {
  static const int homePageIndex = 0;
  static const int homeMisTramites = 1;
  static const int profileMisTramites = 2;

  static List listScreens = [HomePage(), TramitesPage(), ProfilePage()];

  MenuState({required this.index, required this.catalogoEstatusTramite});

  final int index;
  final List<Status> catalogoEstatusTramite;
  MenuState copyWith();
}

class MenuInitial extends MenuState {
  MenuInitial()
    : super(index: MenuState.homePageIndex, catalogoEstatusTramite: []);

  @override
  MenuState copyWith() => MenuInitial();
}

class MenuLoading extends MenuState {
  MenuLoading({int? index, List<Status>? catalogoEstatusTramite})
    : super(
        index: index ?? MenuState.homePageIndex,
        catalogoEstatusTramite: catalogoEstatusTramite ?? [],
      );

  @override
  MenuState copyWith({int? index, List<Status>? catalogoEstatusTramite}) =>
      MenuLoading(
        index: index ?? this.index,
        catalogoEstatusTramite:
            catalogoEstatusTramite ?? this.catalogoEstatusTramite,
      );
}

class MenuData extends MenuState {
  MenuData({required super.index, required super.catalogoEstatusTramite});

  @override
  MenuState copyWith({int? index, List<Status>? catalogoEstatusTramite}) =>
      MenuData(
        index: index ?? this.index,
        catalogoEstatusTramite:
            catalogoEstatusTramite ?? this.catalogoEstatusTramite,
      );
}

class MenuError extends MenuState {
  MenuError()
    : super(index: MenuState.homePageIndex, catalogoEstatusTramite: []);

  @override
  MenuState copyWith({int? index, List<Status>? catalogoEstatusTramite}) =>
      MenuError();
}
