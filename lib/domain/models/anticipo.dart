// ignore: file_names
Anticipo anticipoFromJsonMap(Map<String, dynamic> json) =>
    Anticipo.fromJson(json);
List<Anticipo> anticiposFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Anticipo.fromJson(json)).toList();

class Anticipo {
  Anticipo({this.nombre, this.valor});

  String? nombre;
  int? valor;

  factory Anticipo.fromJson(Map<String, dynamic> json) =>
      Anticipo(nombre: json["nombre"], valor: json["valor"]);
}
