// ignore: file_names
TipoTramite tipoTramiteFromJsonMap(Map<String, dynamic> json) =>
    TipoTramite.fromJson(json);
List<TipoTramite> tipoTramitesFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => TipoTramite.fromJson(json)).toList();

class TipoTramite {
  TipoTramite({this.id, this.alias, this.nombre, this.status});

  int? id;
  String? alias;
  String? nombre;
  int? status;

  factory TipoTramite.fromJson(Map<String, dynamic> json) => TipoTramite(
    id: json["id"],
    alias: json["tramite_alias"],
    nombre: json["tramite_nombre"],
    status: json["tramite_estatus"],
  );
}
