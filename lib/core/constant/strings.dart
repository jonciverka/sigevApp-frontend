mixin AppLocale {
  static const String cargando = 'Cargando';

  //LOGIN
  static const String inputLoginUsuarioLogin = 'inputLoginUsuarioLogin';
  static const String inputLoginPasswordLogin = 'inputLoginPasswordLogin';
  static const String botonIniciarSesionLogin = 'botonIniciarSesionLogin';
  static const String textoInstruccionLogin = 'textoInstruccionLogin';
  //Home cliente
  static const String textTramitesActivosTotalHomeCliente =
      'textTramitesActivosTotalHomeCliente';
  static const String textTituloHomeCliente = 'textTituloHomeCliente';
  static const String textButtonVerMasTramites = 'textButtonVerMasTramites';
  //Mensajes
  static const String avisoSinInternet = 'avisoSinInternet';
  static const String error = 'error';
  static const String errorInicioSesion = 'errorInicioSesion';
  static const String campoObligatorio = 'campoObligatorio';
  //Tramites
  static const String inputSearchTramite = 'inputSearchTramite';
  //Perfil
  static const String textTituloPerfil = 'textTituloPerfil';
  static const String inputNombreCompletoPerfil = 'inputNombreCompletoPerfil';
  static const String inputCorreoElectronicoPerfil =
      'inputCorreoElectronicoPerfil';
  static const String inputTelefonoCelularPerfil = 'inputTelefonoCelularPerfil';
  static const String inputTelefonoAlternoPerfil = 'inputTelefonoAlternoPerfil';
  static const String textButtonCerrarSesionPerfil =
      'textButtonCerrarSesionPerfil';
  static const String textButtonEliminarCuentaPerfil =
      'textButtonEliminarCuentaPerfil';
  static const String textTituloEliminarCuenta = 'textTituloEliminarCuenta';
  static const String textPreguntaEliminarCuenta = 'textPreguntaEliminarCuenta';
  static const String textoRespuestaSiEliminarCuenta =
      'textoRespuestaSiEliminarCuenta';
  static const String textTituloCerrarSesion = 'textTituloCerrarSesion';
  static const String textPreguntaCerrarSesion = 'textPreguntaCerrarSesion';
  static const String textoRespuestaSiCerrarSesion =
      'textoRespuestaSiCerrarSesion';

  //Menu Cliente
  static const String textButtonInicioMenu = 'textButtonInicioMenu';
  static const String textButtonMisTramitesMenu = 'textButtonMisTramitesMenu';
  static const String textButtonPerfilMenu = 'textButtonPerfilMenu';

  // ignore: constant_identifier_names
  static const Map<String, dynamic> ES = {
    cargando: 'Cargando...',
    error: 'Algo salió mal. Inténtalo de nuevo más tarde, por favor',
    avisoSinInternet: 'No hay conexión a Internet.',
    errorInicioSesion: "Usuario o contraseña incorrectos. Inténtalo de nuevo.",
    campoObligatorio: "Este campo es obligatorio.",
    inputLoginUsuarioLogin: 'Correo Electronico',
    inputLoginPasswordLogin: 'Contraseña',
    botonIniciarSesionLogin: 'Iniciar Sesión',
    textoInstruccionLogin:
        "*Si eres cliente, tu contraseña es tu número de trámite",
    textTramitesActivosTotalHomeCliente: 'Trámites Activos',
    textTituloHomeCliente: "Mis Trámites",
    textButtonVerMasTramites: "Ver Mas",
    inputSearchTramite: "Buscar Trámites",
    textTituloPerfil: "Mi perfíl",
    inputNombreCompletoPerfil: "Nombre Completo",
    inputCorreoElectronicoPerfil: "Correo electrónico",
    inputTelefonoCelularPerfil: "Número de télefono celular",
    inputTelefonoAlternoPerfil: "Número de télefono alterno",
    textButtonCerrarSesionPerfil: "Cerrar Sesión",
    textButtonEliminarCuentaPerfil: "Eliminar cuenta",
    textButtonInicioMenu: "Inicio",
    textButtonMisTramitesMenu: "Mis Trámites",
    textButtonPerfilMenu: "Mi Perfil",
    textTituloEliminarCuenta: "¿Deseas eliminar tu cuenta?",
    textPreguntaEliminarCuenta:
        "Al hacerlo, tus datos y documentos se eliminarán de forma permanente",
    textoRespuestaSiEliminarCuenta: "Eliminar",
    textTituloCerrarSesion: "¿Deseas cerrar sesión?",
    textPreguntaCerrarSesion: "Se cerrará tu cuenta de manera segura.",
    textoRespuestaSiCerrarSesion: "Cerrar Sesión",
  };
}
