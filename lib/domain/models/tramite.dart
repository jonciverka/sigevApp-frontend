// ignore: file_names
import 'package:sigev/domain/models/documentacion.dart';

Tramite tramiteFromJsonMap(Map<String, dynamic> json) => Tramite.fromJson(json);
List<Tramite> tramitesFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Tramite.fromJson(json)).toList();

class Tramite {
  Tramite({
    this.id,
    this.nombre,
    this.clave,
    this.idsucursal,
    this.sucursal,
    this.idcontribuyente,
    this.apellidos,
    this.telefono,
    this.telefonoAlterno,
    this.correo,
    this.mismoContribuyente,
    this.idsocio,
    this.socio,
    this.noessocio,
    this.noessocioNombre,
    this.idTipoTramite,
    this.tipoTramite,
    this.idTipoVehiculo,
    this.tipoVehiculo,
    this.identidad,
    this.entidad,
    this.idTipoServicio,
    this.tipoServicio,
    this.idModelo,
    this.modelo,
    this.idMarca,
    this.marca,
    this.submarca,
    this.idColor,
    this.placasNa,
    this.placaActual,
    this.identidadPlaca,
    this.entidadPlaca,
    this.desechoNa,
    this.desechoTipo,
    this.desechoPlacaEntregado,
    this.desechoTarjetaNa,
    this.desechoTarjetaEntregado,
    this.terminacionPnNa,
    this.termPlaca1,
    this.termPlaca2,
    this.subtotal,
    this.total,
    this.acuenta,
    this.descuento,
    this.saldo,
    this.formaPago,
    this.idNota,
    this.nota,
    this.usuario,
    this.fechaCreacion,
    this.estatus,
    this.idUsuario,
    this.terminosCondiciones,
    this.documentaciones,
    this.numeroSerie,
    this.numeroMotor,
    this.idCombustible,
    this.combustible,
    this.puertas,
    this.pasajeros,
    this.cilindrada,
    this.idClase,
    this.clase,
    this.capacidad,
    this.idTransporta,
    this.transporta,
    this.cmCubicos,
    this.idTransmicion,
    this.transmicion,
  });

  int? id;
  String? nombre;
  String? clave;
  String? idsucursal;
  String? sucursal;
  String? idcontribuyente;
  String? apellidos;
  String? telefono;
  String? telefonoAlterno;
  String? correo;
  int? mismoContribuyente;
  int? idsocio;
  String? socio;
  int? noessocio;
  String? noessocioNombre;
  int? idTipoTramite;
  String? tipoTramite;
  int? idTipoVehiculo;
  String? tipoVehiculo;
  int? identidad;
  String? entidad;
  int? idTipoServicio;
  String? tipoServicio;
  int? idModelo;
  String? modelo;
  int? idMarca;
  String? marca;
  String? submarca;
  int? idColor;
  int? placasNa;
  String? placaActual;
  int? identidadPlaca;
  String? entidadPlaca;
  int? desechoNa;
  String? desechoTipo;
  int? desechoPlacaEntregado;
  int? desechoTarjetaNa;
  String? desechoTarjetaEntregado;
  int? terminacionPnNa;
  String? termPlaca1;
  String? termPlaca2;
  double? subtotal;
  double? total;
  double? acuenta;
  double? saldo;
  String? formaPago;
  double? descuento;
  int? idNota;
  String? nota;
  int? idUsuario;
  String? usuario;
  String? fechaCreacion;
  List<StatusTramite>? estatus;
  List<Documentacion>? documentaciones;
  int? terminosCondiciones;
  String? numeroSerie;
  String? numeroMotor;
  int? idCombustible;
  String? combustible;
  int? puertas;
  int? pasajeros;
  int? cilindrada;
  int? idTransmicion;
  String? transmicion;
  int? idClase;
  String? clase;
  int? capacidad;
  int? idTransporta;
  String? transporta;
  int? cmCubicos;

  factory Tramite.fromJson(Map<String, dynamic> json) => Tramite(
    id: json["id"],
    clave: json["clave"],
    idsucursal: json["idsucursal"],
    sucursal: json["sucursal"],
    idcontribuyente: json["idcontribuyente"],
    nombre: json["nombre"],
    apellidos: json["apellidos"],
    telefono: json["telefono"],
    telefonoAlterno: json["telefono_alterno"],
    correo: json["correo"],
    mismoContribuyente: json["mismo_contribuyente"],
    idsocio: json["idsocio"],
    socio: json["socio"],
    noessocio: json["noessocio"],
    noessocioNombre: json["noessocio_nombre"],
    idTipoTramite: json["idtipo_tramite"],
    tipoTramite: json["tipo_tramite"],
    idTipoVehiculo: json["idtipo_vehiculo"],
    tipoVehiculo: json["tipo_vehiculo"],
    identidad: json["identidad"],
    entidad: json["entidad"],
    idTipoServicio: json["id_tiposervicio"],
    tipoServicio: json["tipo_servicio"],
    idModelo: json["idmodelo"],
    modelo: json["modelo"],
    idMarca: json["idmarca"],
    marca: json["marca"],
    submarca: json["submarca"],
    idColor: json["idcolor"],
    placasNa: json["placas_na"],
    placaActual: json["placa_actual"],
    identidadPlaca: json["identidadplaca"],
    entidadPlaca: json["entidadplaca"],
    desechoNa: json["desechoplaca_na"],
    desechoTipo: json["desechotipo"],
    desechoPlacaEntregado: json["desechoplaca_entregado"],
    desechoTarjetaNa: json["desechotarjetac_na"],
    desechoTarjetaEntregado: json["desechotarjetac_entregado"],
    terminacionPnNa: json["terminacionpn_na"],
    termPlaca1: json["term_placa1"],
    termPlaca2: json["term_placa2"],
    subtotal: double.tryParse(json["subtotal"].toString()),
    total: double.tryParse(json["total"].toString()),
    acuenta: double.tryParse(json["acuenta"].toString()),
    descuento: double.tryParse(json["descuento"].toString()),
    saldo: double.tryParse(json["saldo"].toString()),
    idNota: json["idnota"],
    nota: json["nota"],
    idUsuario: json["idusuario"],
    usuario: json["usuario"],
    fechaCreacion: json["fecha_creacion"],
    terminosCondiciones: json["terminos_condiciones"],
    estatus: statusTramiteFromJsonList(
      json["estatus"] is! List ? json["ultimo_status"] : json["estatus"],
    ),
    documentaciones: documentacionsFromJsonList(json["documentaciones"]),
  );
  StatusTramite get ultimoStatus =>
      estatus?.reduce((a, b) => (a.id ?? 0) > (b.id ?? 0) ? a : b) ??
      StatusTramite();
  bool yaPaso(int idEstatus) =>
      ultimoStatus.idestatus == idEstatus ||
      ultimoStatus.idestatus! > idEstatus;
  String get tituloCarta => '$tipoTramite - $entidad - $tipoServicio';
  bool get tieneTodasLasDocumentaciones =>
      documentaciones?.every((item) => item.path != null) ?? false;
  bool get tieneTerminosCondiciones => terminosCondiciones == 1;
  Map<String, dynamic> toJson() => {
    "numeroSerie": numeroSerie,
    "numeroMotor": numeroMotor,
    "idCombustible": idCombustible,
    "combustible": combustible,
    "puertas": puertas,
    "pasajeros": pasajeros,
    "cilindrada": cilindrada,
    "idClase": idClase,
    "clase": clase,
    "capacidad": capacidad,
    "idTransporta": idTransporta,
    "transporta": transporta,
    "cmCubicos": cmCubicos,
    "idTransmicion": idTransmicion,
    "transmicion": transmicion,
  };
}

List<StatusTramite> statusTramiteFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => StatusTramite.fromJson(json)).toList();

class StatusTramite {
  StatusTramite({
    this.id,
    this.clave,
    this.idestatus,
    this.fecha,
    this.usuario,
    this.comentario,
    this.cancelado,
    this.urgente,
    this.status,
  });

  int? id;
  String? clave;
  int? idestatus;
  String? fecha;
  String? usuario;
  String? comentario;
  int? cancelado;
  String? urgente;
  Status? status;

  factory StatusTramite.fromJson(Map<String, dynamic> json) => StatusTramite(
    id: json["id"],
    clave: json["clave"],
    idestatus: json["idestatus"],
    fecha: json["fecha"],
    usuario: json["usuario"],
    comentario: json["comentario"],
    cancelado: json["cancelado"],
    urgente: json["urgente"],
    status: json["cat_estatus"] == null
        ? null
        : Status.fromJson(json["cat_estatus"]),
  );
}

List<Status> statusFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Status.fromJson(json)).toList();

class Status {
  Status({
    this.id,
    this.nombre,
    this.nombrePortada,
    this.idArea,
    this.orden,
    this.general,
    this.habilitado,
    this.avance,
    this.visualizar,
  });

  int? id;
  String? nombre;
  String? nombrePortada;
  int? idArea;
  int? orden;
  int? general;
  int? habilitado;
  int? avance;
  int? visualizar;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json["id"],
    nombre: json["nombre"],
    nombrePortada: json["nombre_portada"],
    idArea: json["idarea"],
    orden: json["orden"],
    general: json["general"],
    habilitado: json["habilitado"],
    avance: json["avance"],
    visualizar: json["visualizar"],
  );
}
