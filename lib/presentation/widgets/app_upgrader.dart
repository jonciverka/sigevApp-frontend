import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sigev/config/theme/upgrader_msg.dart';
import 'package:upgrader/upgrader.dart';

class AppUpgrader extends StatelessWidget {
  const AppUpgrader({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      upgrader: Upgrader(
        messages: AppUpgraderMessages(code: "es"),
        debugLogging: kDebugMode,
        durationUntilAlertAgain: const Duration(hours: 5),
        countryCode: "mx",
        languageCode: "es",
      ),
      showReleaseNotes: false,
      showIgnore: false,
      dialogStyle: Platform.isIOS
          ? UpgradeDialogStyle.cupertino
          : UpgradeDialogStyle.material,
      child: child,
    );
  }
}
