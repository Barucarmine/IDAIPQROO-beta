// To parse this JSON data, do
//
//     final adminResponse = adminResponseFromJson(jsonString);

import 'dart:convert';

import 'package:idaipqroo/models/models.dart';

AdminResponse adminResponseFromJson(String str) => AdminResponse.fromJson(json.decode(str));

String adminResponseToJson(AdminResponse data) => json.encode(data.toJson());

class AdminResponse {
    AdminResponse({
        required this.status,
        required this.user,
    });

    bool status;
    User user;

    factory AdminResponse.fromJson(Map<String, dynamic> json) => AdminResponse(
        status: json["status"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "user": user.toJson(),
    };
}

