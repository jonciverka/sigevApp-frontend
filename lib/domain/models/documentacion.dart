// ignore: file_names
Documentacion documentacionFromJsonMap(Map<String, dynamic> json) =>
    Documentacion.fromJson(json);
List<Documentacion> documentacionsFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Documentacion.fromJson(json)).toList();

class Documentacion {
  Documentacion({this.id, this.nombre, this.valor});
  int? id;
  String? nombre;
  String? valor;

  factory Documentacion.fromJson(Map<String, dynamic> json) => Documentacion(
    id: json["id"],
    nombre: json["nombre"],
    valor: json["valor"],
  );
}
