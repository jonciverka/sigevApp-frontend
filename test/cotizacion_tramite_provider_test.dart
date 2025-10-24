import 'package:flutter_test/flutter_test.dart';
import 'package:sigev/domain/models/catalogo.dart';
import 'package:sigev/domain/models/catalogo_cotizacion.dart';
import 'package:sigev/domain/models/cotizacion.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/domain/providers/authentication_provider.dart';
import 'package:sigev/domain/providers/cotizacion_tramite_provider.dart';
import 'package:sigev/config/globals.dart' as globals;
import 'package:sigev/config/dependency_injection.dart' as di;

void main() {
  di.setupServiceLocator();

  test('Probar getCatalogos en CotizacionProvider', () async {
    final provider = CotizacionTramiteProvider();
    final aute = AuthenticationProvider();

    try {
      await aute.login(login: 'laura.anzo@outlook.com', password: 'Laura123');
      print('✅ Login correcto: ${globals.token}');
      CatalogoCotizacion catalogoCotizacion = await provider.getCatalogos();
      print(
        '✅ getCatalogos correcto: ${catalogoCotizacion.tiposTramite?.first.id}',
      );
      print(
        '✅ getCatalogos correcto: ${catalogoCotizacion.vehiculos?.first.id}',
      );
      print('✅ getCatalogos correcto: ${catalogoCotizacion.entidad?.first.id}');
      print(
        '✅ getCatalogos correcto: ${catalogoCotizacion.sucursal?.first.id}',
      );
      print(
        '✅ getCatalogos correcto: ${catalogoCotizacion.tipoModelo?.first.id}',
      );
      print(
        '✅ getCatalogos correcto: ${catalogoCotizacion.socios?.first.nombre}',
      );
      print(
        '✅ getCatalogos correcto: ${catalogoCotizacion.tipoServicio?.first.nombre}',
      );
      print(
        '✅ getCatalogos correcto: ${catalogoCotizacion.tipoVehiculo?.first.nombre}',
      );
      print(
        '✅ getCatalogos correcto: ${catalogoCotizacion.colores?.first.color}',
      );
      print(
        '✅ getCatalogos correcto: ${catalogoCotizacion.areas?.first.nombre}',
      );
    } catch (e) {
      print('❌ Error al hacer getCatalogos : $e');
    }
  });
  test('Probar getCotizaciones en CotizacionProvider', () async {
    final provider = CotizacionTramiteProvider();
    final aute = AuthenticationProvider();

    try {
      await aute.login(login: 'laura.anzo@outlook.com', password: 'Laura123');
      print('✅ Login correcto: ${globals.token}');
      List<Cotizacion> cotizaciones = await provider.getCotizaciones();
      print('✅ getCotizaciones correcto: ${cotizaciones.length}');
    } catch (e) {
      print('❌ Error al hacer getCotizaciones : $e');
    }
  });
  test('Probar getCotizacionesCliente en CotizacionProvider', () async {
    final provider = CotizacionTramiteProvider();
    final aute = AuthenticationProvider();

    try {
      await aute.login(login: 'jon@gmail.com', password: 'COTA0024700');
      print('✅ Login correcto: ${globals.token}');
      List<Cotizacion> cotizaciones = await provider
          .apiGetCotizacionesCliente();
      print('✅ getCotizaciones correcto: ${cotizaciones.length}');
    } catch (e) {
      print('❌ Error al hacer getCotizaciones : $e');
    }
  });
  test('Probar apiGetTramitesCliente en CotizacionProvider', () async {
    final provider = CotizacionTramiteProvider();
    final aute = AuthenticationProvider();

    try {
      await aute.login(login: 'jon@gmail.com', password: 'COTA0024700');
      print('✅ Login correcto: ${globals.token}');
      List<Tramite> cotizaciones = await provider.apiGetTramitesCliente();
      print('✅ apiGetTramitesCliente correcto: ${cotizaciones.length}');
    } catch (e) {
      print('❌ Error al hacer apiGetTramitesCliente : $e');
    }
  });
  test('Probar apiGetTramitesCliente en CotizacionProvider', () async {
    final provider = CotizacionTramiteProvider();
    final aute = AuthenticationProvider();

    try {
      await aute.login(login: 'jon@gmail.com', password: 'COTA0024700');
      print('✅ Login correcto: ${globals.token}');
      List<Tramite> cotizaciones = await provider.apiGetTramitesCliente();
      print('✅ apiGetTramitesCliente correcto: ${cotizaciones.length}');
    } catch (e) {
      print('❌ Error al hacer apiGetTramitesCliente : $e');
    }
  });
  test('Probar apiGetCatalogo en CotizacionProvider', () async {
    final provider = CotizacionTramiteProvider();
    final aute = AuthenticationProvider();

    try {
      await aute.login(login: 'laura.anzo@outlook.com', password: 'Laura123');
      print('✅ Login correcto: ${globals.token}');
      List<Catalogo> catalogos = await provider.apiGetCatalogo();
      print('✅ apiGetCatalogo correcto: ${catalogos.length}');
    } catch (e) {
      print('❌ Error al hacer apiGetCatalogo : $e');
    }
  });
  test('Probar apiBuscarTramitePor en CotizacionProvider', () async {
    final provider = CotizacionTramiteProvider();
    final aute = AuthenticationProvider();
    try {
      await aute.login(login: 'laura.anzo@outlook.com', password: 'Laura123');
      print('✅ Login correcto: ${globals.token}');
      List<Tramite> tramites = await provider.apiBuscarTramitePor("2025-W10");
      print('✅ apiGetCatalogo correcto: ${tramites.length}');
    } catch (e) {
      print('❌ Error al hacer apiGetCatalogo : $e');
    }
  });
  test('Probar getCotizacionesCliente en CotizacionProvider', () async {
    final provider = CotizacionTramiteProvider();
    final aute = AuthenticationProvider();

    try {
      await aute.login(login: 'jon@gmail.com', password: 'COTA0024700');
      print('✅ Login correcto: ${globals.token}');
      List<Cotizacion> cotizaciones = await provider
          .apiGetCotizacionesCliente();
      print('✅ getCotizaciones correcto: ${cotizaciones.length}');
    } catch (e) {
      print('❌ Error al hacer getCotizaciones : $e');
    }
  });
  test('Probar apiGetCatalogoTramite en CotizacionProvider', () async {
    final provider = CotizacionTramiteProvider();
    final aute = AuthenticationProvider();

    try {
      await aute.login(login: 'jon@gmail.com', password: 'COTA0024700');
      print('✅ Login correcto: ${globals.token}');
      List<Status> estatusTramite = await provider
          .apiGetCatalogoEstatusTramite();
      print('✅ apiGetCatalogo correcto: ${estatusTramite.length}');
    } catch (e) {
      print('❌ Error al hacer apiGetTramitesCliente : $e');
    }
  });
}
