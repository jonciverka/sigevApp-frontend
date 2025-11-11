import 'dart:io';

import 'package:sigev/core/constant/api_constants.dart';

Documentacion documentacionFromJsonMap(Map<String, dynamic> json) =>
    Documentacion.fromJson(json);
List<Documentacion> documentacionsFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Documentacion.fromJson(json)).toList();

class Documentacion {
  Documentacion({
    this.id,
    this.nombre,
    this.urlRecurso,
    this.file,
    this.formato,
    this.apellido,
    this.path,
  });

  int? id;
  String? nombre;
  String? apellido;
  String? urlRecurso;
  File? file;
  String? formato;
  String? path;

  factory Documentacion.fromJson(Map<String, dynamic> json) => Documentacion(
    id: json["id"],
    nombre: json["nombre"] ?? json["documento"]["nombre"],
    apellido: json["apellidos"] ?? json["documento"]["apellidos"],
    path: json["url_recurso"],
    urlRecurso:
        "http://${ApiConstants.urlBase}${ApiConstants.url}${ApiConstants.apiGetImages}/${json["url_recurso"]}",
  );
  get haveUrlRecurso => path != null && path != '';
  Documentacion copyWith({
    int? id,
    String? nombre,
    String? apellido,
    String? urlRecurso,
    File? file,
    String? formato,
    String? path,
  }) {
    return Documentacion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      urlRecurso: urlRecurso ?? this.urlRecurso,
      file: file ?? this.file,
      formato: formato ?? this.formato,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id.toString(),
    "nombre": nombre ?? "",
    "url_recurso": urlRecurso ?? "",
    "file": file ?? "",
    "formato": formato ?? "",
  };
  Map<String, dynamic> toJsonWithoutFile() => {
    "id": id.toString(),
    "nombre": nombre ?? "",
    "url_recurso": urlRecurso ?? "",
    "formato": formato ?? "",
  };
}
