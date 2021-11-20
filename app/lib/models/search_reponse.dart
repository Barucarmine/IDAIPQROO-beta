// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);

import 'dart:convert';

import 'package:idaipqroo/models/models.dart';

SearchResponse searchResponseFromJson(String str) => SearchResponse.fromJson(json.decode(str));

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
    SearchResponse({
        required this.status,
        required this.services,
    });

    final bool status;
    final List<Service> services;

    factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        status: json["status"],
        services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
    };
}


