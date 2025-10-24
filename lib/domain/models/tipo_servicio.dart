// ignore: file_names
TipoServicio tipoServicioFromJsonMap(Map<String, dynamic> json) =>
    TipoServicio.fromJson(json);
List<TipoServicio> tipoServiciosFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => TipoServicio.fromJson(json)).toList();

class TipoServicio {
  TipoServicio({this.id, this.nombre, this.estatus});

  int? id;
  String? nombre;
  int? estatus;

  factory TipoServicio.fromJson(Map<String, dynamic> json) => TipoServicio(
    id: json["id"],
    nombre: json["tiposervicio_nombre"],
    estatus: json["estatus"],
  );
}
