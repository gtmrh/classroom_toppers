import 'dart:convert';

import 'video_data.dart';

class VideoModel {
  String? status;
  List<VideoData>? data;

  VideoModel({this.status, this.data});

  factory VideoModel.fromMap(Map<String, dynamic> data) => VideoModel(
        status: data['status'] as String?,
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => VideoData.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [VideoModel].
  factory VideoModel.fromJson(String data) {
    return VideoModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [VideoModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
