Chat chatsFromJsonMap(Map<String, dynamic> json) => Chat.fromJson(json);
List<Chat> chatssFromJsonList(List<dynamic> jsonList) =>
    jsonList.map((json) => Chat.fromJson(json)).toList();

class Chat {
  int? chat;
  String? idContribuyente;
  String? idSoporteUsuario;
  Chat({this.chat, this.idContribuyente, this.idSoporteUsuario});
  Chat.fromJson(Map json) {
    chat = json['PK_CHAT'];
    idContribuyente = json['ID_CONTRIBUYENTE'].toString();
    idSoporteUsuario = json['ID_USUARIO_SOPORTE'].toString();
  }
}
