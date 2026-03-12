import 'package:intl/intl.dart';

enum TipoMensaje {
  texto(1),
  imagen(2),
  video(3),
  opcion(4);

  final int value;
  const TipoMensaje(this.value);
}

Mensaje mensajesFromJsonMap(Map<String, dynamic> json) =>
    Mensaje.fromJson(json);
List<Mensaje> mensajessFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Mensaje.fromJson(json)).toList();

class Mensaje {
  String? mensaje;
  TipoMensaje? tipoMensaje;
  DateTime? fechaRegistro;
  int? pkUsuario;
  Function? onTap;
  Mensaje({
    this.mensaje,
    this.tipoMensaje,
    this.fechaRegistro,
    this.pkUsuario,
    this.onTap,
  });
  Mensaje.fromJson(Map json) {
    DateTime dateTime = DateTime.now();
    pkUsuario = int.tryParse(json['PK_USUARIO']);
    mensaje = json['MENSAJE'];
    tipoMensaje = json['TIPO_MENSAJE'] == 1
        ? TipoMensaje.texto
        : json['TIPO_MENSAJE'] == 2
        ? TipoMensaje.imagen
        : json['TIPO_MENSAJE'] == 3
        ? TipoMensaje.video
        : json['TIPO_MENSAJE'] == 4
        ? TipoMensaje.opcion
        : null;
    fechaRegistro = DateFormat(
      "yyyy-MM-ddTHH:mm:ss",
    ).parse(json['FECHA_REGISTRO']).add(dateTime.timeZoneOffset);
  }
  Mensaje.mensajeLocal(Map<String, dynamic> json) {
    mensaje = json['MENSAJE'];
    tipoMensaje = json['TIPO_MENSAJE'];
    fechaRegistro = json['FECHA_REGISTRO'];
    pkUsuario = json['PK_USUARIO'];
  }

  toJson() => {
    "MENSAJE": mensaje,
    "TIPO_MENSAJE": tipoMensaje,
    "FECHA_REGISTRO": fechaRegistro!.toString().replaceAll(" ", "T"),
    "PK_USUARIO": pkUsuario,
  };
}
