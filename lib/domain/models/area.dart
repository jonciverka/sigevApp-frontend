// ignore: file_names
Area areaFromJsonMap(Map<String, dynamic> json) => Area.fromJson(json);
List<Area> areasFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Area.fromJson(json)).toList();

class Area {
  Area({this.id, this.nombre, this.alias});

  int? id;
  String? nombre;
  String? alias;

  factory Area.fromJson(Map<String, dynamic> json) =>
      Area(id: json["id"], nombre: json["nombre"], alias: json["alias"]);
}
