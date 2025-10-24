// ignore: file_names
Color colorFromJsonMap(Map<String, dynamic> json) => Color.fromJson(json);
List<Color> colorsFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Color.fromJson(json)).toList();

class Color {
  Color({this.id, this.color});

  int? id;
  String? color;

  factory Color.fromJson(Map<String, dynamic> json) =>
      Color(id: json["id"], color: json["color"]);
}
