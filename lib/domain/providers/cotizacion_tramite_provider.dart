import 'dart:convert';

import 'package:sigev/config/dependency_injection.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/api_constants.dart';
import 'package:sigev/core/services/api_service.dart';
import 'package:sigev/core/utilities/utilities_headers.dart';
import 'package:sigev/domain/models/catalogo.dart';
import 'package:sigev/domain/models/catalogo_cotizacion.dart';
import 'package:sigev/domain/models/cotizacion.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/domain/repositories/cotizacion_tramite_repository.dart';

class CotizacionTramiteProvider implements CotizacionTramiteRepository {
  final ApiService _apiService = getIt<ApiService>();
  @override
  Future<CatalogoCotizacion> getCatalogos() async {
    try {
      final dynamic response = await _apiService.getRequest(
        ApiConstants.apiGetCatalogosNuevaCotizacionEndpoint,
        UtilitiesHeaders.getHeader(),
      );
      CatalogoCotizacion catalogoCotizacion = catalogoCotizacionFromJson(
        response,
      );
      return catalogoCotizacion;
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<List<Cotizacion>> getCotizaciones() async {
    try {
      final dynamic response = await _apiService.getRequest(
        ApiConstants.apiGetCotizacionesEndpoint,
        UtilitiesHeaders.getHeader(),
      );
      List<Cotizacion> cotizaciones = cotizacionsFromJsonList(
        json.decode(response)["data"],
      );
      return cotizaciones;
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<List<Cotizacion>> apiGetCotizacionesCliente() async {
    try {
      final dynamic response = await _apiService.getRequest(
        ApiConstants.apiGetCotizacionesClienteEndpoint,
        UtilitiesHeaders.getHeader(),
      );
      List<Cotizacion> cotizacion = cotizacionsFromJsonList(
        json.decode(response)["data"],
      );
      return cotizacion;
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<List<Tramite>> apiGetTramitesCliente() async {
    try {
      final dynamic response = await _apiService.getRequest(
        ApiConstants.apiGetTramitesCliente,
        UtilitiesHeaders.getHeader(),
      );
      List<Tramite> cotizacion = tramitesFromJsonList(
        json.decode(response)["data"],
      );
      return cotizacion;
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<List<Catalogo>> apiGetCatalogo() async {
    try {
      final dynamic response = await _apiService.getRequest(
        ApiConstants.apiGetCatalogo,
        UtilitiesHeaders.getHeader(),
      );
      List<Catalogo> catalogo = catalogosFromJsonList(
        json.decode(response)["data"],
      );
      return catalogo;
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<List<Tramite>> apiBuscarTramitePor(String week) async {
    try {
      final dynamic response = await _apiService.getRequest(
        "${ApiConstants.apiBuscarTramitePor}?id=$week",
        UtilitiesHeaders.getHeader(),
      );
      List<Tramite> catalogo = tramitesFromJsonList(
        json.decode(response)["data"],
      );
      return catalogo;
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<List<Status>> apiGetCatalogoEstatusTramite() async {
    try {
      final dynamic response = await _apiService.getRequest(
        ApiConstants.apiGetCatalogoEstatusTramiteEndpoint,
        UtilitiesHeaders.getHeader(),
      );
      List<Status> estatusTramite = statusFromJsonList(
        json.decode(response)["data"],
      );
      return estatusTramite;
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<String> createCotizacion({required Cotizacion cotizacion}) async {
    try {
      final dynamic response = await _apiService.postRequest(
        ApiConstants.apiCreateCotizacion,
        cotizacion.toJson(),
        UtilitiesHeaders.getHeader(),
      );
      var clave = json.decode(response)["clave"];
      return clave;
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<String> createTramite({required String clave}) async {
    try {
      final dynamic response = await _apiService.postRequest(
        "${ApiConstants.apiCrearBarraFija}/$clave",
        {},
        UtilitiesHeaders.getHeader(),
      );
      var claveBarrafija = json.decode(response)["clave_barrafija"];
      return claveBarrafija;
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }
}
