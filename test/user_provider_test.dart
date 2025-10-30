// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:sigev/domain/models/user.dart';
import 'package:sigev/domain/models/barra_fija.dart';
import 'package:sigev/domain/providers/authentication_provider.dart';
import 'package:sigev/domain/providers/user_provider.dart';
import 'package:sigev/config/globals.dart' as globals;
import 'package:sigev/config/dependency_injection.dart' as di;

void main() {
  di.setupServiceLocator();

  test('Probar getBarraFija en UserProvider', () async {
    final provider = UserProvider();
    final aute = AuthenticationProvider();

    try {
      await aute.login(login: 'laura.anzo@outlook.com', password: 'Laura123');
      print('✅ Login correcto: ${globals.token}');
      BarraFija barraFija = await provider.getBarraFija();
      print('✅ BarraFija correcto: ${barraFija.grafico?.labels}');
    } catch (e) {
      print('❌ Error al hacer BarraFija: $e');
    }
  });
  test('Probar getUserByCorreo en UserProvider', () async {
    final provider = UserProvider();
    final aute = AuthenticationProvider();

    try {
      await aute.login(login: 'laura.anzo@outlook.com', password: 'Laura123');
      print('✅ Login correcto: ${globals.token}');
      User user = await provider.getClientePorCorreo(correo: "jon@gmail.com");
      print('✅ BarraFija correcto: ${user.email}');
    } catch (e) {
      print('❌ Error al hacer BarraFija: $e');
    }
  });
  test('Probar deleteUser en UserProvider', () async {
    final provider = UserProvider();
    final aute = AuthenticationProvider();
    try {
      await aute.login(login: 'jon@gmail.com', password: 'COTA0024700');
      print('✅ Login correcto: ${globals.token}');
      await provider.apiDeleteUser();
      print('✅ deleteUser correcto');
    } catch (e) {
      print('❌ Error al hacer BarraFija: $e');
    }
  });

  test('Probar getUser en UserProvider', () async {
    final provider = UserProvider();
    final aute = AuthenticationProvider();
    try {
      await aute.login(login: 'laura.anzo@outlook.com', password: 'Laura123');
      print('✅ Login correcto: ${globals.token}');
      await provider.getUser();
      print('✅ getUser correcto  ${globals.user?.name}');
      await aute.login(login: 'jon@gmail.com', password: 'COTA0024700');
      print('✅ Login correcto: ${globals.token}');
      await provider.getUser();
      print('✅ getUser correcto  ${globals.user?.name}');
    } catch (e) {
      print('❌ Error al hacer BarraFija: $e');
    }
  });
}
