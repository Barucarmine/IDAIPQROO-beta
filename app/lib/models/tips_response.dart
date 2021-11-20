// To parse this JSON data, do
//
//     final tipsResponse = tipsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:idaipqroo/models/models.dart';

TipsResponse tipsResponseFromJson(String str) => TipsResponse.fromJson(json.decode(str));

String tipsResponseToJson(TipsResponse data) => json.encode(data.toJson());

class TipsResponse {
    TipsResponse({
        required this.status,
        required this.tips,
    });

    bool status;
    List<Tip> tips;

    factory TipsResponse.fromJson(Map<String, dynamic> json) => TipsResponse(
        status: json["status"],
        tips: List<Tip>.from(json["tips"].map((x) => Tip.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "tips": List<dynamic>.from(tips.map((x) => x.toJson())),
    };
}

