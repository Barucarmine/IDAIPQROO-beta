// To parse this JSON data, do
//
//     final institute = instituteFromJson(jsonString);
// ignore_for_file: unnecessary_null_in_if_null_operators


import 'dart:convert';

import 'package:idaipqroo/global/environment.dart';

Institute instituteFromJson(String str) => Institute.fromJson(json.decode(str));

String instituteToJson(Institute data) => json.encode(data.toJson());

class Institute {
    Institute({
        required this.id,
        required this.manager,
        required this.name,
        required this.description,
        required this.municipality,
        required this.adress,
        this.image,
    });

    final String id;
    final String manager;
    final String name;
    final String municipality;
    final String adress;
    final String description;
    final String? image;

    factory Institute.fromJson(Map<String, dynamic> json) => Institute(
        id: json["_id"],
        manager: json["manager"],
        name: json["name"],
        description: json["description"],
        municipality: json["municipality"],
        adress: json["adress"],
        image: json["image"] ?? null,
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "manager": manager,
        "name": name,
        "description": description,
        "municipality": municipality,
        "adress": adress,
        "image": image ?? null,
    };

    getImage() {

      return '${ Environment.apiUrl }/upload/institutes/$image';
      
    }
}
