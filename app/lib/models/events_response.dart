import 'dart:convert';

import 'package:idaipqroo/models/models.dart';

EventsResponse eventsResponseFromJson(String str) => EventsResponse.fromJson(json.decode(str));

String eventsResponseToJson(EventsResponse data) => json.encode(data.toJson());

class EventsResponse {
    EventsResponse({
        required this.status,
        required this.events,
    });

    final bool status;
    final List<Event> events;

    factory EventsResponse.fromJson(Map<String, dynamic> json) => EventsResponse(
        status: json["status"],
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
    };
}