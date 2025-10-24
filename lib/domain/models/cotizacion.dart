// ignore: file_names
Cotizacion cotizacionFromJsonMap(Map<String, dynamic> json) =>
    Cotizacion.fromJson(json);
List<Cotizacion> cotizacionsFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Cotizacion.fromJson(json)).toList();

class Cotizacion {
  Cotizacion({
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
  String? noessocio;
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
  double? descuento;
  double? saldo;
  String? formaPago;
  int? idNota;
  String? nota;
  String? usuario;
  String? fechaCreacion;
  int? estatus;
  int? idUsuario;

  factory Cotizacion.fromJson(Map<String, dynamic> json) => Cotizacion(
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
    formaPago: json["formapago"],
    idNota: json["idnota"],
    nota: json["nota"],
    usuario: json["usuario"],
    fechaCreacion: json["fecha_creacion"],
    estatus: json["estatus"],
    idUsuario: json["idusuario"],
  );
}
