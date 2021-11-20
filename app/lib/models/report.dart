// To parse this JSON data, do
//
//     final report = reportFromJson(jsonString);

// ignore_for_file: unnecessary_null_in_if_null_operators

import 'dart:convert';

import 'package:idaipqroo/global/environment.dart';
import 'package:idaipqroo/models/models.dart';

Report reportFromJson(String str) => Report.fromJson(json.decode(str));

String reportToJson(Report data) => json.encode(data.toJson());

class Report {
    Report({
        this.id,
        this.user,
        required this.title,
        this.category,
        required this.description,
        this.location,
        this.municipality,
        this.colony,
        required this.anonymous,
        this.assigned = false,
        this.image,
        this.createdAt,
        this.updatedAt,
    });

    String? id;
    User? user;
    String title;
    String? category;
    String description;
    Location? location;
    String? municipality;
    String? colony;
    bool anonymous;
    bool? assigned;
    String? image;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["_id"] ?? null,
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        title: json["title"],
        category: json["category"],
        description: json["description"],
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        municipality: json["municipality"],
        colony: json["colony"],
        anonymous: json["anonymous"],
        assigned: json["assigned"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user?.toJson(),
        "title": title,
        "category": category,
        "description": description,
        "location": location?.toJson(),
        "municipality": municipality,
        "colony": colony,
        "anonymous": anonymous,
        "assigned": assigned,
        "image": image,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };

    Report copy() => Report(
      id: id,
      user: user,
      title: title,
      category: category,
      description: description,
      location: location,
      municipality: municipality,
      colony: colony,
      anonymous: anonymous,
      assigned: assigned,
      image: image,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );


    getImage() {

      if ( image == null ) {
        return '${ Environment.apiUrl }/upload/reports/$image';
      }

      if ( image!.startsWith('/data') ){
        return image;
      } else {
        return '${ Environment.apiUrl }/upload/reports/$image';
      }
    }
}

class Location {
    Location({
        required this.lat,
        required this.lng,
    });

    final double lat;
    final double lng;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"],
        lng: json["lng"],
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };



    
}
