import 'dart:convert';

class AllTestData {
  int? id;
  int? courseId;
  int? subcategoryId;
  String? testSeriesName;
  String? price;
  int? time;
  String? postBy;
  String? imageLink;
  String? testCategory;
  String? noOfQuestion;
  String? description;
  dynamic isSupportNegative;
  dynamic negativeMarks;
  dynamic isAdvanceMode;
  String? access;
  String? testType;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  AllTestData({
    this.id,
    this.courseId,
    this.subcategoryId,
    this.testSeriesName,
    this.price,
    this.time,
    this.postBy,
    this.imageLink,
    this.testCategory,
    this.noOfQuestion,
    this.description,
    this.isSupportNegative,
    this.negativeMarks,
    this.isAdvanceMode,
    this.access,
    this.testType,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory AllTestData.fromMap(Map<String, dynamic> data) => AllTestData(
        id: data['id'] as int?,
        courseId: data['course_id'] as int?,
        subcategoryId: data['subcategory_id'] as int?,
        testSeriesName: data['test_series_name'] as String?,
        price: data['price'] as String?,
        time: data['time'] as int?,
        postBy: data['post_by'] as String?,
        imageLink: data['image_link'] as String?,
        testCategory: data['test_category'] as String?,
        noOfQuestion: data['no_of_question'] as String?,
        description: data['description'] as String?,
        isSupportNegative: data['is_support_negative'] as dynamic,
        isAdvanceMode: data['is_advance_mode'] as dynamic,
        negativeMarks: data['negative_marks'] as dynamic,
        access: data['access'] as String?,
        testType: data['test_type'] as String?,
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
        'subcategory_id': subcategoryId,
        'test_series_name': testSeriesName,
        'price': price,
        'time': time,
        'post_by': postBy,
        'image_link': imageLink,
        'test_category': testCategory,
        'no_of_question': noOfQuestion,
        'description': description,
        'is_support_negative': isSupportNegative,
        'is_advance_mode': isAdvanceMode,
        'negative_marks': negativeMarks,
        'access': access,
        'test_type': testType,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AllTestData].
  factory AllTestData.fromJson(String data) {
    return AllTestData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AllTestData] to a JSON string.
  String toJson() => json.encode(toMap());
}
