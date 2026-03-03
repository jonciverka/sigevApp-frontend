CategoriaBot categoriaBotFromJsonMap(Map<String, dynamic> json) =>
    CategoriaBot.fromJson(json);
List<CategoriaBot> categoriaBotsFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => CategoriaBot.fromJson(json)).toList();

class CategoriaBot {
  CategoriaBot({this.id, this.categoriaBot, this.idPadreCategoriaBot});

  int? id;
  String? categoriaBot;
  int? idPadreCategoriaBot;

  factory CategoriaBot.fromJson(Map<String, dynamic> json) => CategoriaBot(
    id: json["id"],
    categoriaBot: json["categoria"],
    idPadreCategoriaBot: json["id_padre_categoria"],
  );
}

PreguntaBot preguntaBotFromJsonMap(Map<String, dynamic> json) =>
    PreguntaBot.fromJson(json);
List<PreguntaBot> preguntaBotsFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => PreguntaBot.fromJson(json)).toList();

class PreguntaBot {
  PreguntaBot({this.id, this.pregunta});

  int? id;
  String? pregunta;

  factory PreguntaBot.fromJson(Map<String, dynamic> json) =>
      PreguntaBot(id: json["id"], pregunta: json["pregunta"]);
}

RespuestaBot respuestaBotFromJsonMap(Map<String, dynamic> json) =>
    RespuestaBot.fromJson(json);
List<RespuestaBot> respuestaBotsFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => RespuestaBot.fromJson(json)).toList();

class RespuestaBot {
  RespuestaBot({this.id, this.respuesta});

  int? id;
  String? respuesta;

  factory RespuestaBot.fromJson(Map<String, dynamic> json) =>
      RespuestaBot(id: json["id"], respuesta: json["respuestas"]);
}
