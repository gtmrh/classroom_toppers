import 'dart:convert';

class CourseTypeData {
  int? id;
  String? courseType;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  CourseTypeData({
    this.id,
    this.courseType,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory CourseTypeData.fromMap(Map<String, dynamic> data) => CourseTypeData(
        id: data['id'] as int?,
        courseType: data['course_type'] as String?,
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
        'course_type': courseType,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CourseTypeData].
  factory CourseTypeData.fromJson(String data) {
    return CourseTypeData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CourseTypeData] to a JSON string.
  String toJson() => json.encode(toMap());
}
