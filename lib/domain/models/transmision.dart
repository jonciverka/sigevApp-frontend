// ignore: file_names
Transmision transmisionFromJsonMap(Map<String, dynamic> json) =>
    Transmision.fromJson(json);
List<Transmision> transmisionsFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Transmision.fromJson(json)).toList();

class Transmision {
  Transmision({this.nombre, this.valor});

  String? nombre;
  int? valor;

  factory Transmision.fromJson(Map<String, dynamic> json) =>
      Transmision(nombre: json["nombre"].toString(), valor: json["id"]);
}
