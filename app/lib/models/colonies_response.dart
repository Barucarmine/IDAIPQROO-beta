// To parse this JSON data, do
//
//     final coloniesResponse = coloniesResponseFromJson(jsonString);

import 'dart:convert';

ColoniesResponse coloniesResponseFromJson(String str) => ColoniesResponse.fromJson(json.decode(str));

String coloniesResponseToJson(ColoniesResponse data) => json.encode(data.toJson());

class ColoniesResponse {
    ColoniesResponse({
        required this.status,
        required this.colonies,
    });

    final bool status;
    final List<String> colonies;

    factory ColoniesResponse.fromJson(Map<String, dynamic> json) => ColoniesResponse(
        status: json["status"],
        colonies: List<String>.from(json["colonies"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "colonies": List<dynamic>.from(colonies.map((x) => x)),
    };
}
