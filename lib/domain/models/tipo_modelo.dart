// ignore: file_names
TipoModelo tipoModeloFromJsonMap(Map<String, dynamic> json) =>
    TipoModelo.fromJson(json);
List<TipoModelo> tipoModelosFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => TipoModelo.fromJson(json)).toList();

class TipoModelo {
  TipoModelo({this.id, this.anio});

  int? id;
  String? anio;

  factory TipoModelo.fromJson(Map<String, dynamic> json) =>
      TipoModelo(id: json["id"], anio: json["modelo_anio"]);
}
