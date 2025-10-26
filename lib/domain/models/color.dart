// ignore: file_names
ColorVehiculo colorFromJsonMap(Map<String, dynamic> json) =>
    ColorVehiculo.fromJson(json);
List<ColorVehiculo> colorsFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => ColorVehiculo.fromJson(json)).toList();

class ColorVehiculo {
  ColorVehiculo({this.id, this.color});

  int? id;
  String? color;

  factory ColorVehiculo.fromJson(Map<String, dynamic> json) =>
      ColorVehiculo(id: json["id"], color: json["color"]);
}
