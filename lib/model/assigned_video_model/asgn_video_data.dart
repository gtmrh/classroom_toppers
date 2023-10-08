import 'dart:convert';

class AsgnVideoData {
  int? id;
  int? courseId;
  int? categoryId;
  int? subcategoryId;
  String? videoTitle;
  String? videoLink;
  String? sourceType;
  String? imageLink;
  String? access;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  AsgnVideoData({
    this.id,
    this.courseId,
    this.categoryId,
    this.subcategoryId,
    this.videoTitle,
    this.videoLink,
    this.sourceType,
    this.imageLink,
    this.access,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory AsgnVideoData.fromMap(Map<String, dynamic> data) => AsgnVideoData(
        id: data['id'] as int?,
        courseId: data['course_id'] as int?,
        categoryId: data['category_id'] as int?,
        subcategoryId: data['subcategory_id'] as int?,
        videoTitle: data['video_title'] as String?,
        videoLink: data['video_link'] as String?,
        sourceType: data['source_type'] as String?,
        imageLink: data['image_link'] as String?,
        access: data['access'] as String?,
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
        'subcategory_id': subcategoryId,
        'video_title': videoTitle,
        'video_link': videoLink,
        'source_type': sourceType,
        'image_link': imageLink,
        'access': access,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AsgnVideoData].
  factory AsgnVideoData.fromJson(String data) {
    return AsgnVideoData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AsgnVideoData] to a JSON string.
  String toJson() => json.encode(toMap());
}
