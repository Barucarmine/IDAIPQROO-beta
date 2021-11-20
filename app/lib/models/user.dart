// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

// ignore_for_file: unnecessary_null_in_if_null_operators

import 'dart:convert';

import 'package:idaipqroo/global/environment.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        required this.id,
        required this.name,
        required this.email,
        required this.role,
        required this.online,
        this.image,
        this.description
    });

    final String id;
    final String name;
    final String email;
    final String role;
    final bool online;
    final String? image;
    final String? description;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        online: json["online"],
        image: json["image"] ?? null,
        description: json["description"] ?? null,
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "role": role,
        "online": online,
        "image": image ?? null,
        "description": description ?? null,
    };

    getImage() {

      return '${ Environment.apiUrl }/upload/users/$image';
      
    }
    
}
