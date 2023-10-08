import 'dart:convert';

class Data {
  int? userId;
  int? mobile;
  int? courseId;
  int? amount;
  String? joinDate;
  String? expireDate;
  String? remarks;

  Data({
    this.userId,
    this.mobile,
    this.courseId,
    this.amount,
    this.joinDate,
    this.expireDate,
    this.remarks,
  });

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        userId: data['user_id'] as int?,
        mobile: data['mobile'] as int?,
        courseId: data['course_id'] as int?,
        amount: data['amount'] as int?,
        joinDate: data['join_date'] as String?,
        expireDate: data['expire_date'] as String?,
        remarks: data['remarks'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'user_id': userId,
        'mobile': mobile,
        'course_id': courseId,
        'amount': amount,
        'join_date': joinDate,
        'expire_date': expireDate,
        'remarks': remarks,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());
}
