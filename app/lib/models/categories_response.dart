
import 'dart:convert';

CategoriesResponse categoriesResponseFromJson(String str) => CategoriesResponse.fromJson(json.decode(str));

String categoriesResponseToJson(CategoriesResponse data) => json.encode(data.toJson());

class CategoriesResponse {
    CategoriesResponse({
        required this.status,
        required this.categories,
    });

    bool status;
    List<String> categories;

    factory CategoriesResponse.fromJson(Map<String, dynamic> json) => CategoriesResponse(
        status: json["status"],
        categories: List<String>.from(json["categories"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "categories": List<dynamic>.from(categories.map((x) => x)),
    };
}
