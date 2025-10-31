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
    this.extrasConcepto,
    this.extrasImporte,
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
  List<String>? extrasConcepto;
  List<String>? extrasImporte;

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

  Map<String, dynamic> toJson() => {
    "sucursal": sucursal, //"1-A",
    "telefono": telefono, //"555555",
    "nombre": nombre, //"12312312",
    "apellidos": apellidos, //"3123123",
    "telefono_alterno": telefonoAlterno, // "(12) 31-23-12-31",
    "email": correo, //"quantity",
    "cliente": "mismo_contribuyente",
    "tipo_tramite": tipoTramite, //"3-VOE",
    "tipo_vehiculo": tipoVehiculo, //"1-AUTO",
    "entidad": entidad, //"9-CDMX",
    "tipo_servicio": tipoServicio, //"3-CL",
    "marca": marca, //"1-ACASA",
    "submarca": submarca, //"submarca",
    "modelo": modelo, //"81-2029",
    "color": idColor, //"1",
    "check_plactualnp": placasNa, // No aplica 1 aplica null
    "placa_actual":
        placaActual, // "asd" || null, //es String Si check_plactualnp es null
    "entidad_placa":
        entidadPlaca, //"9-CDMX" || null, //es String Si check_plactualnp es null
    "check_desechonp": desechoNa, // No aplica 1 aplica null,
    "desecho": desechoTipo, //es String Si check_desechonp es null
    "desecho_entregado": desechoPlacaEntregado,
    //     "1" ||
    //     "0" ||
    //     null, //es 1 o 0 Si check_desechonp es null es 1 si es entregado 0 si es pendiente
    "check_desechotcnp": desechoTarjetaNa, // No aplica 1 aplica null,
    "desecho_tarjetac": desechoTarjetaEntregado,
    //     "1" ||
    //     "0" ||
    //     null, //es 1 o 0 Si check_desechotcnp es null es 1 si es entregado 0 si es pendiente
    "check_placasnp": terminacionPnNa, // null || 1, // No aplica 1 aplica null,
    "terminacion_placa_1": termPlaca1,
    //     "5 y 6" || null, //es string Si check_placasnp es null
    "terminacion_placa_2": termPlaca2,
    //     "5 y 6" || null, //es string Si check_placasnp es null
    "subtotal": subtotal,
    "complemento_name": extrasConcepto, //["PERMIPL"],
    "complemento": extrasImporte, //["100"],
    "descuento": descuento, //num || null,
    "total": total, //  "10000000000",
    "acuenta": acuenta, //"10000000000",
    "saldo": saldo, // "10000000000" || null,
    "nota": nota, //String || null,
  };
}
