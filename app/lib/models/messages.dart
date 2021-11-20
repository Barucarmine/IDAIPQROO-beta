
// To parse this JSON data, do
//
//     final messagesChatResponse = messagesChatResponseFromJson(jsonString);

import 'dart:convert';

MessagesChatResponse messagesChatResponseFromJson(String str) => MessagesChatResponse.fromJson(json.decode(str));

String messagesChatResponseToJson(MessagesChatResponse data) => json.encode(data.toJson());

class MessagesChatResponse {
    MessagesChatResponse({
        required this.status,
        required this.messages,
    });

    bool status;
    List<Message> messages;

    factory MessagesChatResponse.fromJson(Map<String, dynamic> json) => MessagesChatResponse(
        status: json["status"],
        messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
    };
}

class Message {
    Message({
        required this.from,
        required this.to,
        required this.message,
        required this.createdAt,
        required this.updatedAt,
    });

    String from;
    String to;
    String message;
    DateTime createdAt;
    DateTime updatedAt;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        from: json["from"],
        to: json["to"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
