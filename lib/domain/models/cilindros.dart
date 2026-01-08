// ignore: file_names
Cilindros cilindrosFromJsonMap(Map<String, dynamic> json) =>
    Cilindros.fromJson(json);
List<Cilindros> cilindrossFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Cilindros.fromJson(json)).toList();

class Cilindros {
  Cilindros({this.nombre, this.valor});

  String? nombre;
  int? valor;

  factory Cilindros.fromJson(Map<String, dynamic> json) =>
      Cilindros(nombre: json["nombre"].toString(), valor: json["valor"]);
}
