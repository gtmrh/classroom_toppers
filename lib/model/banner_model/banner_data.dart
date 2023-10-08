import 'dart:convert';

class BannerData {
  int? id;
  int? courseId;
  String? bannerTitle;
  String? imageLink;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  BannerData({
    this.id,
    this.courseId,
    this.bannerTitle,
    this.imageLink,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory BannerData.fromMap(Map<String, dynamic> data) => BannerData(
        id: data['id'] as int?,
        courseId: data['course_id'] as int?,
        bannerTitle: data['banner_title'] as String?,
        imageLink: data['image_link'] as String?,
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
        'banner_title': bannerTitle,
        'image_link': imageLink,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BannerData].
  factory BannerData.fromJson(String data) {
    return BannerData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BannerData] to a JSON string.
  String toJson() => json.encode(toMap());
}
