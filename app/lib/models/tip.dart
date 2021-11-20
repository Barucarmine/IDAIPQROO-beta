class Tip {
    Tip({
        required this.id,
        required this.text,
        required this.createdAt,
        required this.updatedAt,
    });

    String id;
    String text;
    DateTime createdAt;
    DateTime updatedAt;

    factory Tip.fromJson(Map<String, dynamic> json) => Tip(
        id: json["_id"],
        text: json["text"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "text": text,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
