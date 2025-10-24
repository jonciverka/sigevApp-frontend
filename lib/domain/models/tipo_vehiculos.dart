// ignore: file_names
TipoVehiculo tipoVehiculoFromJsonMap(Map<String, dynamic> json) =>
    TipoVehiculo.fromJson(json);
List<TipoVehiculo> tipoVehiculosFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => TipoVehiculo.fromJson(json)).toList();

class TipoVehiculo {
  TipoVehiculo({this.id, this.nombre, this.status});

  int? id;
  String? nombre;
  int? status;

  factory TipoVehiculo.fromJson(Map<String, dynamic> json) => TipoVehiculo(
    id: json["id"],
    nombre: json["tipovehiculo_nombre"],
    status: json["estatus"],
  );
}
