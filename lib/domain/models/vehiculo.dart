// ignore: file_names
Vehiculo vehiculoFromJsonMap(Map<String, dynamic> json) =>
    Vehiculo.fromJson(json);
List<Vehiculo> vehiculosFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Vehiculo.fromJson(json)).toList();

class Vehiculo {
  Vehiculo({this.id, this.marca, this.vehiculoEstatus, this.vehiculoOrden});

  int? id;
  String? marca;
  int? vehiculoEstatus;
  int? vehiculoOrden;

  factory Vehiculo.fromJson(Map<String, dynamic> json) => Vehiculo(
    id: json["id"],
    marca: json["vehiculo_marca"],
    vehiculoEstatus: json["vehiculo_estatus"],
    vehiculoOrden: json["vehiculo_orden"],
  );
}
