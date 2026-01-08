// ignore: file_names
Combustible combustibleFromJsonMap(Map<String, dynamic> json) =>
    Combustible.fromJson(json);
List<Combustible> combustiblesFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Combustible.fromJson(json)).toList();

class Combustible {
  Combustible({this.nombre, this.valor});

  String? nombre;
  int? valor;

  factory Combustible.fromJson(Map<String, dynamic> json) =>
      Combustible(nombre: json["nombre"], valor: json["id"]);
}
