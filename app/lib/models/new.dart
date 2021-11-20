
import 'package:idaipqroo/global/environment.dart';

class New {
    New({
        required this.id,
        required this.title,
        required this.subtitle,
        this.image,
        required this.content,
        required this.createdAt,
        required this.updatedAt,
    });

    String id;
    String title;
    String subtitle;
    String? image;
    String content;
    DateTime createdAt;
    DateTime updatedAt;

    factory New.fromJson(Map<String, dynamic> json) => New(
        id: json["_id"],
        title: json["title"],
        subtitle: json["subtitle"],
        image: json["image"],
        content: json["content"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "subtitle": subtitle,
        "image": image,
        "content": content,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    };

    getImage() {

      return '${ Environment.apiUrl }/upload/news/$image';
      
    }

}
