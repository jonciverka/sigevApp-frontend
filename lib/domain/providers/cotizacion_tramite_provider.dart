import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sigev/config/dependency_injection.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/api_constants.dart';
import 'package:sigev/core/services/api_service.dart';
import 'package:sigev/core/utilities/utilities_headers.dart';
import 'package:sigev/domain/models/catalogo.dart';
import 'package:sigev/domain/models/catalogo_cotizacion.dart';
import 'package:sigev/domain/models/cotizacion.dart';
import 'package:sigev/domain/models/documentacion.dart';
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

  @override
  Future<void> uploadImage({
    required List<Documentacion> documentacionesAMandar,
    required List<Documentacion> documentaciones,
  }) async {
    try {
      final String baseUrl = "http://${ApiConstants.urlBase}";
      final String extension = ApiConstants.url;
      final String endpoint = ApiConstants.apiUploadDocumentsTramiteCliente;
      final Uri url = Uri.parse('$baseUrl$extension$endpoint');
      var request = http.MultipartRequest("POST", url);
      for (var i = 0; i < documentacionesAMandar.length; i++) {
        final doc = documentacionesAMandar[i];
        doc.toJsonWithoutFile().forEach((key, value) {
          request.fields["documentaciones[$i][$key]"] = value;
        });
        if (doc.file != null) {
          request.files.add(
            await http.MultipartFile.fromPath(
              "documentaciones[$i][file]",
              doc.file!.path,
            ),
          );
        }
      }
      // Agregar headers si necesitas autenticación
      request.headers.addAll(UtilitiesHeaders.getHeader());
      var res = await request.send();
      final responseBody = await res.stream.bytesToString();
      var jsonDecoded = json.decode(responseBody);
      for (var i = 0; i < documentaciones.length; i++) {
        final List docServidor = jsonDecoded['documentos'];
        for (var element in docServidor) {
          if (int.tryParse(element['id']) == documentaciones[i].id) {
            documentaciones[i].path = element['url_recurso'];
            documentaciones[i].urlRecurso =
                "http://${ApiConstants.urlBase}${ApiConstants.url}${ApiConstants.apiGetImages}/${element['url_recurso']}";
          }
        }
      }
    } on ApiClientException catch (exc) {
      throw exc.message.toString();
    } catch (exc) {
      rethrow;
    }
  }
}
