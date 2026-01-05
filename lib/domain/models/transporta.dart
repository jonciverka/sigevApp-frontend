// ignore: file_names
Transporta transportaFromJsonMap(Map<String, dynamic> json) =>
    Transporta.fromJson(json);
List<Transporta> transportasFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Transporta.fromJson(json)).toList();

class Transporta {
  Transporta({this.nombre, this.valor});

  String? nombre;
  String? valor;

  factory Transporta.fromJson(Map<String, dynamic> json) => Transporta(
    nombre: json["nombre"].toString(),
    valor: json["valor"].toString(),
  );
}
