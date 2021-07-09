// To parse this JSON data, do
//
//     final hackerNewsComment = hackerNewsCommentFromMap(jsonString);

import 'dart:convert';

class HackerNewsComment {
  HackerNewsComment({
    String? by,
    int? id,
    List<dynamic>? kids,
    int? parent,
    String? text,
    int? time,
    String? type,
  })  : _by = by ?? " ",
        _id = id ?? 0,
        _kids = kids ?? <dynamic>[],
        _parent = parent ?? 0,
        _text = text ?? " ",
        _time = time ?? 0,
        _type = type ?? " ";

  final String _by;
  final int _id;
  final List<dynamic> _kids;
  final int _parent;
  final String _text;
  final int _time;
  final String _type;

  String get by => _by;
  int get id => _id;
  List<dynamic> get kids => _kids;
  int get parent => _parent;
  String get text => _text;
  int get time => _time;
  String get type => _type;

  factory HackerNewsComment.fromJson(String str) =>
      HackerNewsComment.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory HackerNewsComment.fromMap(Map<String, dynamic> json) =>
      HackerNewsComment(
        by: json["by"] as String,
        id: json["id"] as int,
        kids: (json["kids"] ?? <dynamic>[]) as List<dynamic>,
        parent: json["parent"] as int,
        text: json["text"] as String,
        time: json["time"] as int,
        type: json["type"] as String,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        "by": _by,
        "id": _id,
        "kids": List<int>.from(_kids.map((dynamic x) => x)),
        "parent": _parent,
        "text": _text,
        "time": _time,
        "type": _type,
      };

  HackerNewsComment copyWith({
    String? by,
    int? id,
    List<dynamic>? kids,
    int? parent,
    String? text,
    int? time,
    String? type,
  }) =>
      HackerNewsComment(
        by: by ?? _by,
        id: id ?? _id,
        kids: kids ?? _kids,
        parent: parent ?? _parent,
        text: text ?? _text,
        time: time ?? _time,
        type: type ?? _type,
      );
}
