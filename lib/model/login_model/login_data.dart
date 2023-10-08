import 'dart:convert';

class LoginData {
  int? id;
  String? name;
  String? email;
  int? mobile;
  dynamic imageLink;
  String? city;
  dynamic apiToken;
  dynamic fcmToken;
  String? status;
  String? isLogin;
  String? joinDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  LoginData({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.imageLink,
    this.city,
    this.apiToken,
    this.fcmToken,
    this.status,
    this.isLogin,
    this.joinDate,
    this.createdAt,
    this.updatedAt,
  });

  factory LoginData.fromMap(Map<String, dynamic> data) => LoginData(
        id: data['id'] as int?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        mobile: data['mobile'] as int?,
        imageLink: data['image_link'] as dynamic,
        city: data['city'] as String?,
        apiToken: data['api_token'] as dynamic,
        fcmToken: data['fcm_token'] as dynamic,
        status: data['status'] as String?,
        isLogin: data['is_login'] as String?,
        joinDate: data['join_date'] as String?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'mobile': mobile,
        'image_link': imageLink,
        'city': city,
        'api_token': apiToken,
        'fcm_token': fcmToken,
        'status': status,
        'is_login': isLogin,
        'join_date': joinDate,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginData].
  factory LoginData.fromJson(String data) {
    return LoginData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginData] to a JSON string.
  String toJson() => json.encode(toMap());
}
