// ignore: file_names
Puerta puertaFromJsonMap(Map<String, dynamic> json) => Puerta.fromJson(json);
List<Puerta> puertasFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Puerta.fromJson(json)).toList();

class Puerta {
  Puerta({this.nombre, this.valor});

  String? nombre;
  String? valor;

  factory Puerta.fromJson(Map<String, dynamic> json) => Puerta(
    nombre: json["nombre"].toString(),
    valor: json["valor"].toString(),
  );
}
