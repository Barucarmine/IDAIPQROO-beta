// To parse this JSON data, do
//
//     final servicesResponse = servicesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:idaipqroo/models/models.dart';

ServicesResponse servicesResponseFromJson(String str) => ServicesResponse.fromJson(json.decode(str));

String servicesResponseToJson(ServicesResponse data) => json.encode(data.toJson());

class ServicesResponse {
    ServicesResponse({
        required this.status,
        required this.services,
    });

    final bool status;
    final List<Service> services;

    factory ServicesResponse.fromJson(Map<String, dynamic> json) => ServicesResponse(
        status: json["status"],
        services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
    };
}
