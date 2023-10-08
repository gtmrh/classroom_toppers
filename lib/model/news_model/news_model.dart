import 'dart:convert';

import 'news_data.dart';

class NewsModel {
  String? status;
  List<NewsData>? data;

  NewsModel({this.status, this.data});

  factory NewsModel.fromMap(Map<String, dynamic> data) => NewsModel(
        status: data['status'] as String?,
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => NewsData.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [NewsModel].
  factory NewsModel.fromJson(String data) {
    return NewsModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [NewsModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
