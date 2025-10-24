// ignore: file_names
Socio socioFromJsonMap(Map<String, dynamic> json) => Socio.fromJson(json);
List<Socio> sociosFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Socio.fromJson(json)).toList();

class Socio {
  Socio({
    this.id,
    this.clave,
    this.nombre,
    this.apellido,
    this.rfc,
    this.email,
    this.cuenta,
    this.banco,
    this.movil,
    this.estatus,
    this.fecha,
  });

  int? id;
  String? clave;
  String? nombre;
  String? apellido;
  String? rfc;
  String? email;
  String? cuenta;
  String? banco;
  String? movil;
  int? estatus;
  String? fecha;

  factory Socio.fromJson(Map<String, dynamic> json) => Socio(
    id: json["id"],
    clave: json["socio_clave"],
    nombre: json["socio_nombre"],
    apellido: json["socio_apaterno"],
    rfc: json["socio_rfc"],
    email: json["socio_email"],
    cuenta: json["socio_cuenta"],
    banco: json["socio_banco"],
    movil: json["socio_movil"],
    estatus: json["socio_estatus"],
    fecha: json["socio_fecha"],
  );
}
