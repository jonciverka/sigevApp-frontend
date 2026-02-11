import 'package:sigev/domain/models/catalogo.dart';
import 'package:sigev/domain/models/catalogo_cotizacion.dart';
import 'package:sigev/domain/models/cotizacion.dart';
import 'package:sigev/domain/models/documentacion.dart';
import 'package:sigev/domain/models/tramite.dart';

abstract class CotizacionTramiteRepository {
  Future<CatalogoCotizacion> getCatalogos();
  Future<List<Cotizacion>> getCotizaciones();
  Future<List<Cotizacion>> apiGetCotizacionesCliente();
  Future<List<Tramite>> apiGetTramitesCliente();
  Future<List<Catalogo>> apiGetCatalogo();
  Future<List<Tramite>> apiBuscarTramitePor(String week);
  Future<List<Status>> apiGetCatalogoEstatusTramite();
  Future<String> createCotizacion({required Cotizacion cotizacion});
  Future<String> createTramite({
    required String clave,
    required Tramite tramite,
  });
  Future<void> uploadImage({
    required List<Documentacion> documentacionesAMandar,
    required List<Documentacion> documentaciones,
  });
  Future<void> aceptTerminosYCondiciones({required String clave});
  Future<Tramite> apiGetSeguimiento({
    required String anio,
    required String code,
  });
}
