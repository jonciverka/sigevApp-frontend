import 'package:upgrader/upgrader.dart';

class AppUpgraderMessages extends UpgraderMessages {
  AppUpgraderMessages({super.code});

  @override
  String get body {
    return '¡Hay una nueva versión de {{appName}}! La versión {{currentAppStoreVersion}} ya está disponible, actualmente tienes la versión {{currentInstalledVersion}}.';
  }
}
