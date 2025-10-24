import 'dart:convert';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

class Token {
  Token({this.accessToken});

  String? accessToken;

  factory Token.fromJson(Map<String, dynamic> json) =>
      Token(accessToken: json["token"]);
}
