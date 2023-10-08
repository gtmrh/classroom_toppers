import 'dart:convert';

class AsgnCourseData {
  int? id;
  int? userId;
  String? mobile;
  int? courseId;
  String? amount;
  String? joinDate;
  String? expireDate;
  String? status;
  dynamic remarks;
  DateTime? createdAt;
  DateTime? updatedAt;

  AsgnCourseData({
    this.id,
    this.userId,
    this.mobile,
    this.courseId,
    this.amount,
    this.joinDate,
    this.expireDate,
    this.status,
    this.remarks,
    this.createdAt,
    this.updatedAt,
  });

  factory AsgnCourseData.fromMap(Map<String, dynamic> data) => AsgnCourseData(
        id: data['id'] as int?,
        userId: data['user_id'] as int?,
        mobile: data['mobile'] as String?,
        courseId: data['course_id'] as int?,
        amount: data['amount'] as String?,
        joinDate: data['join_date'] as String?,
        expireDate: data['expire_date'] as String?,
        status: data['status'] as String?,
        remarks: data['remarks'] as dynamic,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'mobile': mobile,
        'course_id': courseId,
        'amount': amount,
        'join_date': joinDate,
        'expire_date': expireDate,
        'status': status,
        'remarks': remarks,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AsgnCourseData].
  factory AsgnCourseData.fromJson(String data) {
    return AsgnCourseData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AsgnCourseData] to a JSON string.
  String toJson() => json.encode(toMap());
}
