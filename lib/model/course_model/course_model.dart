import 'dart:convert';

import 'courses_data.dart';

class CourseModel {
  String? status;
  List<CoursesData>? data;

  CourseModel({this.status, this.data});

  factory CourseModel.fromMap(Map<String, dynamic> data) => CourseModel(
        status: data['status'] as String?,
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => CoursesData.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CourseModel].
  factory CourseModel.fromJson(String data) {
    return CourseModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CourseModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
