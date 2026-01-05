// ignore: file_names
Pasajeros pasajerosFromJsonMap(Map<String, dynamic> json) =>
    Pasajeros.fromJson(json);
List<Pasajeros> pasajerosFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Pasajeros.fromJson(json)).toList();

class Pasajeros {
  Pasajeros({this.nombre, this.valor});

  String? nombre;
  String? valor;

  factory Pasajeros.fromJson(Map<String, dynamic> json) => Pasajeros(
    nombre: json["nombre"].toString(),
    valor: json["valor"].toString(),
  );
}
