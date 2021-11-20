// To parse this JSON data, do
//
//     final reportsResponse = reportsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:idaipqroo/models/models.dart';

ReportsResponse reportsResponseFromJson(String str) => ReportsResponse.fromJson(json.decode(str));

String reportsResponseToJson(ReportsResponse data) => json.encode(data.toJson());

class ReportsResponse {
    ReportsResponse({
        required this.status,
        required this.reports,
    });

    final bool status;
    final List<Report> reports;

    factory ReportsResponse.fromJson(Map<String, dynamic> json) => ReportsResponse(
        status: json["status"],
        reports: List<Report>.from(json["reports"].map((x) => Report.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "reports": List<dynamic>.from(reports.map((x) => x.toJson())),
    };
}
