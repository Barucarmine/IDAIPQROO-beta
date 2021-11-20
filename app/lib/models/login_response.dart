// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:idaipqroo/models/models.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    LoginResponse({
        required this.status,
        required this.user,
        required this.accessToken,
    });

    bool status;
    User user;
    String accessToken;

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        user: User.fromJson(json["user"]),
        accessToken: json["accessToken"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "user": user.toJson(),
        "accessToken": accessToken,
    };
}
