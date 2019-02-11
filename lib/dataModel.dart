import 'dart:convert';

Posts postsFromJson(String str) {
  final jsonData = json.decode(str);
  return Posts.fromJson(jsonData);
}

String postsToJson(Posts data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Posts {
  int id;
  String title;
  String body;

  Posts({
    this.id,
    this.title,
    this.body,
  });

  factory Posts.fromMap(Map<String, dynamic> json) => new Posts(
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  factory Posts.fromJson(Map<String, dynamic> json) => new Posts(
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
      };
}
