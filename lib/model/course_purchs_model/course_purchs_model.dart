import 'dart:convert';

import 'data.dart';

class CoursePurchsModel {
  String? status;
  Data? data;

  CoursePurchsModel({this.status, this.data});

  factory CoursePurchsModel.fromMap(Map<String, dynamic> data) {
    return CoursePurchsModel(
      status: data['status'] as String?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CoursePurchsModel].
  factory CoursePurchsModel.fromJson(String data) {
    return CoursePurchsModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CoursePurchsModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
