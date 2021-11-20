// To parse this JSON data, do
//
//     final municipilitiesResponse = municipilitiesResponseFromJson(jsonString);

import 'dart:convert';

MunicipilitiesResponse municipilitiesResponseFromJson(String str) => MunicipilitiesResponse.fromJson(json.decode(str));

String municipilitiesResponseToJson(MunicipilitiesResponse data) => json.encode(data.toJson());

class MunicipilitiesResponse {
    MunicipilitiesResponse({
        required this.status,
        required this.municipalities,
    });

    final bool status;
    final List<String> municipalities;

    factory MunicipilitiesResponse.fromJson(Map<String, dynamic> json) => MunicipilitiesResponse(
        status: json["status"],
        municipalities: List<String>.from(json["municipalities"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "municipalities": List<dynamic>.from(municipalities.map((x) => x)),
    };
}
