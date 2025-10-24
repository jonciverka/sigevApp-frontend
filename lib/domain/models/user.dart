import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str)["user"]);
User userFromJsonData(String str) => User.fromJson(json.decode(str)["data"]);

class User {
  User({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.referralCode,
    this.roleId,
    this.phone,
    this.phoneAlternative,
  });

  int? id;
  String? name;
  String? lastName;
  String? email;
  String? referralCode;
  String? phone;
  String? phoneAlternative;
  int? roleId;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"] ?? json["nombre"],
    lastName: json["lastName"] ?? json["apellidos"],
    email: json["email"] ?? json["correo"],
    referralCode: json["referralCode"],
    roleId: json["roleId"],
    phone: json["phone"] ?? json["telefono"],
    phoneAlternative: json["telefono_alterno"],
  );
}
