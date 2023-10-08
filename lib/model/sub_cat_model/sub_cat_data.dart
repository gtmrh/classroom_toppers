import 'dart:convert';

class SubCatData {
  int? id;
  int? courseId;
  int? categoryId;
  String? name;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  SubCatData({
    this.id,
    this.courseId,
    this.categoryId,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory SubCatData.fromMap(Map<String, dynamic> data) => SubCatData(
        id: data['id'] as int?,
        courseId: data['course_id'] as int?,
        categoryId: data['category_id'] as int?,
        name: data['name'] as String?,
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
        'course_id': courseId,
        'category_id': categoryId,
        'name': name,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SubCatData].
  factory SubCatData.fromJson(String data) {
    return SubCatData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SubCatData] to a JSON string.
  String toJson() => json.encode(toMap());
}
