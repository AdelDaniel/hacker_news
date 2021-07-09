// To parse this JSON data, do
//
//     final hackerNewsStory = hackerNewsStoryFromMap(jsonString);

import 'dart:convert';

class HackerNewsStory {
  HackerNewsStory({
    required this.by,
    required this.descendants,
    required this.id,
    required this.kids,
    required this.score,
    required this.time,
    required this.title,
    required this.type,
    required this.url,
  });

  final String by;
  final int descendants;
  final int id;
  final List<dynamic> kids;
  final int score;
  final int time;
  final String title;
  final String type;
  final String url;

  HackerNewsStory copyWith({
    required String by,
    required int descendants,
    required int id,
    required List<dynamic> kids,
    required int score,
    required int time,
    required String title,
    required String type,
    required String url,
  }) =>
      HackerNewsStory(
        by: by,
        descendants: descendants,
        id: id,
        kids: kids,
        score: score,
        time: time,
        title: title,
        type: type,
        url: url,
      );

  factory HackerNewsStory.fromJson(String str) =>
      HackerNewsStory.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory HackerNewsStory.fromMap(Map<String, dynamic> json) => HackerNewsStory(
        by: (json["by"] ?? 'unKown') as String,
        descendants: (json["descendants"] ?? 0) as int,
        id: json["id"] as int,
        kids: (json["kids"] ?? <int>[]) as List<dynamic>,
        score: (json["score"] ?? 0) as int,
        time: (json["time"] ?? 0) as int,
        title: (json["title"] ?? 'Not Specified') as String,
        type: (json["type"] ?? 'Not Specified') as String,
        url: (json["url"] ?? 'Not Specified') as String,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        "by": by,
        "descendants": descendants,
        "id": id,
        "kids": List<int>.from(kids.map((dynamic x) => x)),
        "score": score,
        "time": time,
        "title": title,
        "type": type,
        "url": url,
      };

  factory HackerNewsStory.fromDB(Map<String, dynamic> dbItem) =>
      HackerNewsStory(
        by: dbItem["by"] as String,
        descendants: dbItem["descendants"] as int,
        id: dbItem["id"] as int,
        kids: json.decode(dbItem["kids"] as String) as List<dynamic>,
        score: dbItem["score"] as int,
        time: dbItem["time"] as int,
        title: dbItem["title"] as String,
        type: dbItem["type"] as String,
        url: dbItem["url"] as String,
      );

  Map<String, dynamic> toMapForDB() => <String, dynamic>{
        "by": by,
        "descendants": descendants,
        "id": id,
        "kids": json.encode(kids),
        "score": score,
        "time": time,
        "title": title,
        "type": type,
        "url": url,
      };
}
