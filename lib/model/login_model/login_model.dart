import 'dart:convert';

import 'login_data.dart';

class LoginModel {
  String? token;
  LoginData? data;

  LoginModel({this.token, this.data});

  factory LoginModel.fromMap(Map<String, dynamic> data) => LoginModel(
        token: data['token'] as String?,
        data: data['data'] == null
            ? null
            : LoginData.fromMap(data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'token': token,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginModel].
  factory LoginModel.fromJson(String data) {
    return LoginModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
