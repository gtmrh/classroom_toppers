import 'dart:convert';

import 'asgn_video_data.dart';

class AssignedVideoModel {
  String? status;
  List<AsgnVideoData>? data;

  AssignedVideoModel({this.status, this.data});

  factory AssignedVideoModel.fromMap(Map<String, dynamic> data) {
    return AssignedVideoModel(
      status: data['status'] as String?,
      data: (data['data'] as List<dynamic>?)
          ?.map((e) => AsgnVideoData.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AssignedVideoModel].
  factory AssignedVideoModel.fromJson(String data) {
    return AssignedVideoModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AssignedVideoModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
