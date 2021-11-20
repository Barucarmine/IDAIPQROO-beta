// To parse this JSON data, do
//
//     final newsResponse = newsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:idaipqroo/models/models.dart';

NewsResponse newsResponseFromJson(String str) => NewsResponse.fromJson(json.decode(str));

String newsResponseToJson(NewsResponse data) => json.encode(data.toJson());

class NewsResponse {
    NewsResponse({
        required this.status,
        required this.news,
    });

    bool status;
    List<New> news;

    factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
        status: json["status"],
        news: List<New>.from(json["news"].map((x) => New.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "news": List<dynamic>.from(news.map((x) => x.toJson())),
    };
}
