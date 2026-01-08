// ignore: file_names
Clase claseFromJsonMap(Map<String, dynamic> json) => Clase.fromJson(json);
List<Clase> clasesFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Clase.fromJson(json)).toList();

class Clase {
  Clase({this.nombre, this.valor});

  String? nombre;
  int? valor;

  factory Clase.fromJson(Map<String, dynamic> json) =>
      Clase(nombre: json["nombre"].toString(), valor: json["id"]);
}
