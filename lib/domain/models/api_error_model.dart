import 'dart:convert';

ApiErrorModel apiErrorModelFromJson(String str) =>
    ApiErrorModel.fromJson(json.decode(str));

class ApiErrorModel {
  ApiErrorModel({
    this.code,
    this.message,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) => ApiErrorModel(
        code: (json['code'] ?? json['errorCode']).toString(),
        message: json['message'] ?? json['msg'],
      );
  String? code;
  String? message;
}
