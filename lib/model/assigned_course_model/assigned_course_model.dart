import 'dart:convert';

import 'asgn_course_data.dart';

class AssignedCourseModel {
  String? status;
  List<AsgnCourseData>? data;

  AssignedCourseModel({this.status, this.data});

  factory AssignedCourseModel.fromMap(Map<String, dynamic> data) {
    return AssignedCourseModel(
      status: data['status'] as String?,
      data: (data['data'] as List<dynamic>?)
          ?.map((e) => AsgnCourseData.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AssignedCourseModel].
  factory AssignedCourseModel.fromJson(String data) {
    return AssignedCourseModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AssignedCourseModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
