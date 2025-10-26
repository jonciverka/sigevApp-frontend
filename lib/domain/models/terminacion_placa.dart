// ignore: file_names
TerminacionPlaca terminacionPlacaFromJsonMap(Map<String, dynamic> json) =>
    TerminacionPlaca.fromJson(json);

List<TerminacionPlaca> terminacionPlacasFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => TerminacionPlaca.fromJson(json)).toList();

class TerminacionPlaca {
  TerminacionPlaca({this.nombre, this.valor});

  String? nombre;
  String? valor;

  factory TerminacionPlaca.fromJson(Map<String, dynamic> json) =>
      TerminacionPlaca(nombre: json["nombre"], valor: json["valor"]);
}
