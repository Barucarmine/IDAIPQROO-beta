// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

import 'dart:convert';

import 'package:idaipqroo/models/models.dart';

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
    Service({
        required this.report,
        required this.institute,
        required this.status,
        required this.id,
        this.observations,
        this.qualification,
        required this.contributions,
        this.createdAt,
        this.updatedAt,
    });

    final Report report;
    final Institute institute;
    final String status;
    final String id;
    final String? observations;
    final Qualification? qualification;
    final int contributions;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        report: Report.fromJson(json["report"]),
        institute: Institute.fromJson(json["institute"]),
        status: json["status"],
        id: json["_id"],
        observations: json["observations"],
        contributions: json["contributions"],
        qualification: json["qualification"] == null ? null : Qualification.fromJson(json["qualification"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),

    );

    Map<String, dynamic> toJson() => {
        "report": report.toJson(),
        "institute": institute.toJson(),
        "status": status,
        "_id": id,
        "observations": observations,
        "contributions": contributions,
        "qualification": qualification?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}


class Qualification {
    Qualification({
        required this.points,
        required this.commet,
    });

    final int points;
    final String commet;

    factory Qualification.fromJson(Map<String, dynamic> json) => Qualification(
        points: json["points"],
        commet: json["commet"],
    );

    Map<String, dynamic> toJson() => {
        "points": points,
        "commet": commet,
    };
}

