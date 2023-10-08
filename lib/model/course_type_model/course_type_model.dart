import 'dart:convert';

import 'course_type_data.dart';

class CourseTypeModel {
  String? status;
  List<CourseTypeData>? data;

  CourseTypeModel({this.status, this.data});

  factory CourseTypeModel.fromMap(Map<String, dynamic> data) {
    return CourseTypeModel(
      status: data['status'] as String?,
      data: (data['data'] as List<dynamic>?)
          ?.map((e) => CourseTypeData.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CourseTypeModel].
  factory CourseTypeModel.fromJson(String data) {
    return CourseTypeModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CourseTypeModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
