// ignore: file_names
Sucursal sucursalFromJsonMap(Map<String, dynamic> json) =>
    Sucursal.fromJson(json);
List<Sucursal> sucursalsFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Sucursal.fromJson(json)).toList();

class Sucursal {
  Sucursal({
    this.id,
    this.nombre,
    this.alias,
    this.domicilio,
    this.telefono,
    this.celular,
    this.fecha,
    this.status,
  });

  int? id;
  String? nombre;
  String? alias;
  String? domicilio;
  String? telefono;
  String? celular;
  String? fecha;
  int? status;

  factory Sucursal.fromJson(Map<String, dynamic> json) => Sucursal(
    id: json["id"],
    nombre: json["sucursal_nombre"],
    alias: json["sucursal_alias"],
    domicilio: json["sucursal_domicilio"],
    telefono: json["sucursal_telefono"],
    celular: json["sucursal_celular"],
    fecha: json["sucursal_fecha"],
    status: json["sucursal_estatus"],
  );
}
