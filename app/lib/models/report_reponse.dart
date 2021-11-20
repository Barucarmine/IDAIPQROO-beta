// To parse this JSON data, do
//
//     final reportResponse = reportResponseFromJson(jsonString);

import 'dart:convert';

import 'package:idaipqroo/models/models.dart';

ReportResponse reportResponseFromJson(String str) => ReportResponse.fromJson(json.decode(str));

String reportResponseToJson(ReportResponse data) => json.encode(data.toJson());

class ReportResponse {
    ReportResponse({
        required this.status,
        required this.report,
    });

    final bool status;
    final Report report;

    factory ReportResponse.fromJson(Map<String, dynamic> json) => ReportResponse(
        status: json["status"],
        report: Report.fromJson(json["report"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "report": report.toJson(),
    };
}


