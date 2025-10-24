// ignore: file_names
Catalogo catalogoFromJsonMap(Map<String, dynamic> json) =>
    Catalogo.fromJson(json);
List<Catalogo> catalogosFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Catalogo.fromJson(json)).toList();

class Catalogo {
  Catalogo({
    this.entidad,
    this.tramiteAlias,
    this.tipoVehiculo,
    this.cl,
    this.vip,
    this.xp,
    this.tiempoEntrega,
    this.notas,
    this.actualizacion,
  });

  String? entidad;
  String? tramiteAlias;
  String? tipoVehiculo;
  String? cl;
  String? vip;
  String? xp;
  String? tiempoEntrega;
  String? notas;
  String? actualizacion;

  factory Catalogo.fromJson(Map<String, dynamic> json) => Catalogo(
    entidad: json["entidad_abreviatura"],
    tramiteAlias: json["tramite_alias"],
    tipoVehiculo: json["tipovehiculo_nombre"],
    cl: json["CL"],
    vip: json["VIP"],
    xp: json["XP"],
    tiempoEntrega: json["tiempo_entrega"],
    notas: json["notas"],
    actualizacion: json["actualizacion"],
  );
}
