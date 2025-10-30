// ignore_for_file: avoid_print

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sigev/domain/providers/authentication_provider.dart';
import 'package:sigev/config/globals.dart' as globals;
import 'package:sigev/config/dependency_injection.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.setupServiceLocator();

  test('Probar login en AuthenticationProvider', () async {
    final provider = AuthenticationProvider();

    try {
      await provider.login(
        login: 'laura.anzo@outlook.com',
        password: 'Laura123',
      );
      print('✅ Login correcto: ${globals.token}');
    } catch (e) {
      print('❌ Error al hacer login: $e');
    }
  });
}
