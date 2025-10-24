// ignore: file_names
Entidad entidadFromJsonMap(Map<String, dynamic> json) => Entidad.fromJson(json);
List<Entidad> entidadsFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Entidad.fromJson(json)).toList();

class Entidad {
  Entidad({
    this.id,
    this.marca,
    this.entidadNombre,
    this.entidadAbreviatura,
    this.entidadOrden,
    this.entidadEstatus,
  });

  int? id;
  String? marca;
  String? entidadNombre;
  String? entidadAbreviatura;
  int? entidadOrden;
  int? entidadEstatus;

  factory Entidad.fromJson(Map<String, dynamic> json) => Entidad(
    id: json["id"],
    marca: json["entidad_clave"],
    entidadNombre: json["entidad_nombre"],
    entidadAbreviatura: json["entidad_abreviatura"],
    entidadOrden: json["entidad_orden"],
    entidadEstatus: json["entidad_estatus"],
  );
}
