import 'package:sigev/domain/models/catalogo.dart';
import 'package:sigev/domain/models/catalogo_cotizacion.dart';
import 'package:sigev/domain/models/cotizacion.dart';
import 'package:sigev/domain/models/tramite.dart';

abstract class CotizacionTramiteRepository {
  Future<CatalogoCotizacion> getCatalogos();
  Future<List<Cotizacion>> getCotizaciones();
  Future<List<Cotizacion>> apiGetCotizacionesCliente();
  Future<List<Tramite>> apiGetTramitesCliente();
  Future<List<Catalogo>> apiGetCatalogo();
  Future<List<Tramite>> apiBuscarTramitePor(String week);
  Future<List<Status>> apiGetCatalogoEstatusTramite();
}
