import 'dart:convert';

class NewsData {
  int? id;
  String? newsTitle;
  String? date;
  String? time;
  String? imageLink;
  String? description;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  NewsData({
    this.id,
    this.newsTitle,
    this.date,
    this.time,
    this.imageLink,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory NewsData.fromMap(Map<String, dynamic> data) => NewsData(
        id: data['id'] as int?,
        newsTitle: data['news_title'] as String?,
        date: data['date'] as String?,
        time: data['time'] as String?,
        imageLink: data['image_link'] as String?,
        description: data['description'] as String?,
        status: data['status'] as int?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'news_title': newsTitle,
        'date': date,
        'time': time,
        'image_link': imageLink,
        'description': description,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [NewsData].
  factory NewsData.fromJson(String data) {
    return NewsData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [NewsData] to a JSON string.
  String toJson() => json.encode(toMap());
}
