// ignore: file_names
Extra extraFromJsonMap(Map<String, dynamic> json) => Extra.fromJson(json);
List<Extra> extrasFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Extra.fromJson(json)).toList();

class Extra {
  Extra({this.id, this.alias, this.descripcion, this.estatus, this.fecha});

  int? id;
  String? alias;
  String? descripcion;
  int? estatus;
  String? fecha;

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
    id: json["id"],
    alias: json["alias"],
    descripcion: json["descripcion"],
    estatus: json["estatus"],
    fecha: json["fecha"],
  );
}
