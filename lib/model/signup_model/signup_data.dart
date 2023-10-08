import 'dart:convert';

class SignupData {
  String? name;
  String? email;
  String? mobile;
  String? city;
  String? joinDate;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  SignupData({
    this.name,
    this.email,
    this.mobile,
    this.city,
    this.joinDate,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory SignupData.fromMap(Map<String, dynamic> data) => SignupData(
        name: data['name'] as String?,
        email: data['email'] as String?,
        mobile: data['mobile'] as String?,
        city: data['city'] as String?,
        joinDate: data['join_date'] as String?,
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        id: data['id'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'mobile': mobile,
        'city': city,
        'join_date': joinDate,
        'updated_at': updatedAt?.toIso8601String(),
        'created_at': createdAt?.toIso8601String(),
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SignupData].
  factory SignupData.fromJson(String data) {
    return SignupData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SignupData] to a JSON string.
  String toJson() => json.encode(toMap());
}
