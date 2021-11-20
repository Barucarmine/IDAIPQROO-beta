import 'package:idaipqroo/global/environment.dart';

class Event {
    Event({
        required this.id,
        required this.title,
        required this.subtitle,
        required this.description,
        required this.municipality,
        required this.direction,
        required this.date,
        this.hour,
        this.image,
    });

    final String id;
    final String title;
    final String subtitle;
    final String description;
    final String municipality;
    final String direction;
    final String date;
    final String? hour;
    final String? image;

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["_id"],
        title: json["title"],
        subtitle: json["subtitle"],
        description: json["description"],
        municipality: json["municipality"],
        direction: json["direction"],
        date: json["date"],
        hour: json["hour"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "subtitle": subtitle,
        "description": description,
        "municipality": municipality,
        "direction": direction,
        "date": date,
        "hour": hour,
        "image": image,
    };

    getImage() {

      return '${ Environment.apiUrl }/upload/users/$image';
      
    }
}
