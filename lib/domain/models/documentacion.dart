// ignore: file_names
Documentacion documentacionFromJsonMap(Map<String, dynamic> json) =>
    Documentacion.fromJson(json);
List<Documentacion> documentacionsFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Documentacion.fromJson(json)).toList();

class Documentacion {
  Documentacion({this.nombre, this.valor});

  String? nombre;
  String? valor;

  factory Documentacion.fromJson(Map<String, dynamic> json) =>
      Documentacion(nombre: json["nombre"], valor: json["valor"]);
}
