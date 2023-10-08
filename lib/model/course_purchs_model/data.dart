import 'dart:convert';

class Data {
  int? userId;
  String? courseId;
  int? amount;
  String? paymentStatus;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.userId,
    this.courseId,
    this.amount,
    this.paymentStatus,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        userId: data['user_id'] as int?,
        courseId: data['course_id'] as String?,
        amount: data['amount'] as int?,
        paymentStatus: data['payment_status'] as String?,
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        id: data['id'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'user_id': userId,
        'course_id': courseId,
        'amount': amount,
        'payment_status': paymentStatus,
        'updated_at': updatedAt?.toIso8601String(),
        'created_at': createdAt?.toIso8601String(),
        'id': id,
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
