// ignore: file_names
TipoDesecho tipoDesechoFromJsonMap(Map<String, dynamic> json) =>
    TipoDesecho.fromJson(json);
List<TipoDesecho> tipoDesechosFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => TipoDesecho.fromJson(json)).toList();

class TipoDesecho {
  TipoDesecho({this.nombre});

  String? nombre;

  factory TipoDesecho.fromJson(Map<String, dynamic> json) =>
      TipoDesecho(nombre: json["tipoDesecho_nombre"]);
}
