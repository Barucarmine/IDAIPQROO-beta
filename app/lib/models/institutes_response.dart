// To parse this JSON data, do
//
//     final institutesResponse = institutesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:idaipqroo/models/models.dart';

InstitutesResponse institutesResponseFromJson(String str) => InstitutesResponse.fromJson(json.decode(str));

String institutesResponseToJson(InstitutesResponse data) => json.encode(data.toJson());

class InstitutesResponse {
    InstitutesResponse({
        required this.status,
        required this.institutes,
    });

    final bool status;
    final List<Institute> institutes;

    factory InstitutesResponse.fromJson(Map<String, dynamic> json) => InstitutesResponse(
        status: json["status"],
        institutes: List<Institute>.from(json["institutes"].map((x) => Institute.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "institutes": List<dynamic>.from(institutes.map((x) => x.toJson())),
    };
}

