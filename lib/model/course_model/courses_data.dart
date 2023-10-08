import 'dart:convert';

class CoursesData {
  int? id;
  int? courseTypeId;
  String? name;
  String? image;
  dynamic syllabus;
  String? duration;
  int? courseFee;
  int? discountFee;
  String? description;
  String? whatsAppLink;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  CoursesData({
    this.id,
    this.courseTypeId,
    this.name,
    this.image,
    this.syllabus,
    this.duration,
    this.courseFee,
    this.discountFee,
    this.description,
    this.whatsAppLink,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory CoursesData.fromMap(Map<String, dynamic> data) => CoursesData(
        id: data['id'] as int?,
        courseTypeId: data['course_type_id'] as int?,
        name: data['name'] as String?,
        image: data['image'] as String?,
        syllabus: data['syllabus'] as dynamic,
        duration: data['duration'] as String?,
        courseFee: data['course_fee'] as int?,
        discountFee: data['discount_fee'] as int?,
        description: data['description'] as String?,
        whatsAppLink: data['whats_app_link'] as String?,
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
        'course_type_id': courseTypeId,
        'name': name,
        'image': image,
        'syllabus': syllabus,
        'duration': duration,
        'course_fee': courseFee,
        'discount_fee': discountFee,
        'description': description,
        'whats_app_link': whatsAppLink,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CoursesData].
  factory CoursesData.fromJson(String data) {
    return CoursesData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CoursesData] to a JSON string.
  String toJson() => json.encode(toMap());
}
