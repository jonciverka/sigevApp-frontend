class ApiConstants {
  static String urlBase = "192.168.1.80:80";
  static String urlBaseChat = "192.168.1.80:3002";
  static String protocol = "http://";
  // static String urlBase = "my.grupogevhe.com";
  // static String urlBase = "office.grupogevhe.com";
  static String url = "/api/";

  /// [Endpoints]
  static const String loginEndpoint = 'login';
  static const String refreshTokenEndpoint = 'refreshToken';
  static const String getUserEndpoint = 'getUser';
  static const String getUserClienteEndpoint = 'getUserCliente';
  static const String apiDeleteUserEndpoint = 'apiDeleteUser';
  static const String barrafijaEndpoint = 'barrafija';
  static const String getClientePorCorreoEndpoint = 'apiGetClientePorCorreo';
  static const String apiGetCatalogosNuevaCotizacionEndpoint =
      'apiGetCatalogosNuevaCotizacion';
  static const String apiGetCotizacionesEndpoint = 'apiGetCotizaciones';
  static const String apiGetCotizacionesClienteEndpoint =
      'apiGetCotizacionesCliente';
  static const String apiGetTramitesCliente = 'apiGetTramitesCliente';
  static const String apiGetCatalogo = 'apiGetCatalogo';
  static const String apiBuscarTramitePor = 'apiBuscarTramitePor';
  static const String apiGetCatalogoEstatusTramiteEndpoint =
      'apiGetCatalogoEstatusTramite';
  static const String apiCreateCotizacion = 'apiCreateCotizacion';
  static const String apiCrearBarraFija = 'apiCrearBarraFija';
  static const String apiUploadDocumentsTramiteCliente =
      'apiUploadDocumentsTramiteCliente';
  static const String apiGetImages = 'mostrarArchivo';
  static const String apiAceptTerminosYCondiciones =
      'apiAceptTerminosYCondiciones';
  static const String apiSeguimientoEndpoint = 'seguimiento';
  //CHAT
  static const String generarNuevoChat = "generarNuevoChat";
  static const String finalizarChat = "finalizarChat";
  static const String obtenerMensajesChat = "obtenerMensajesChat";
  static const String obtenerChat = "obtenerChat";
  //BOT
  static const String apiObtenerCategorias = "obtenerCategorias";
  static const String apiObtenerSubCategorias = "obtenerSubCategorias";
  static const String apiObtenerPreguntas = "obtenerPreguntas";
  static const String apiObtenerRespuestas = "obtenerRespuestas";
}
