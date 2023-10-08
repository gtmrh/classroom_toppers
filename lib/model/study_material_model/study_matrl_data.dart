import 'dart:convert';

class StudyMaterialData {
  int? id;
  int? courseId;
  int? categoryId;
  int? subcategoryId;
  String? writerName;
  String? pdfTitle;
  int? price;
  String? access;
  String? pdfFile;
  String? description;
  String? imageLink;
  String? downloadOption;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  StudyMaterialData({
    this.id,
    this.courseId,
    this.categoryId,
    this.subcategoryId,
    this.writerName,
    this.pdfTitle,
    this.price,
    this.access,
    this.pdfFile,
    this.description,
    this.imageLink,
    this.downloadOption,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory StudyMaterialData.fromMap(Map<String, dynamic> data) =>
      StudyMaterialData(
        id: data['id'] as int?,
        courseId: data['course_id'] as int?,
        categoryId: data['category_id'] as int?,
        subcategoryId: data['subcategory_id'] as int?,
        writerName: data['writer_name'] as String?,
        pdfTitle: data['pdf_title'] as String?,
        price: data['price'] as int?,
        access: data['access'] as String?,
        pdfFile: data['pdf_file'] as String?,
        description: data['description'] as String?,
        imageLink: data['image_link'] as String?,
        downloadOption: data['download_option'] as String?,
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
        'writer_name': writerName,
        'pdf_title': pdfTitle,
        'price': price,
        'access': access,
        'pdf_file': pdfFile,
        'description': description,
        'image_link': imageLink,
        'download_option': downloadOption,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [StudyMaterialData].
  factory StudyMaterialData.fromJson(String data) {
    return StudyMaterialData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [StudyMaterialData] to a JSON string.
  String toJson() => json.encode(toMap());
}
