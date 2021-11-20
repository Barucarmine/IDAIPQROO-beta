// To parse this JSON data, do
//
//     final serviceJoinResponse = serviceJoinResponseFromJson(jsonString);

import 'dart:convert';

import 'package:idaipqroo/models/models.dart';

ServiceJoinResponse serviceJoinResponseFromJson(String str) => ServiceJoinResponse.fromJson(json.decode(str));

String serviceJoinResponseToJson(ServiceJoinResponse data) => json.encode(data.toJson());

class ServiceJoinResponse {
    ServiceJoinResponse({
        required this.status,
        required this.message,
        this.service,
    });

    bool status;
    String message;
    Service? service;

    factory ServiceJoinResponse.fromJson(Map<String, dynamic> json) => ServiceJoinResponse(
        status: json["status"],
        message: json["message"],
        service: json["service"] == null ? null : Service.fromJson(json["service"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "service": service == null ? null : service!.toJson(),
    };
}

