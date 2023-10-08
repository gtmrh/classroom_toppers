import 'dart:convert';

import 'signup_data.dart';

class SignupModel {
  String? token;
  SignupData? data;

  SignupModel({this.token, this.data});

  factory SignupModel.fromMap(Map<String, dynamic> data) => SignupModel(
        token: data['token'] as String?,
        data: data['data'] == null
            ? null
            : SignupData.fromMap(data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'token': token,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SignupModel].
  factory SignupModel.fromJson(String data) {
    return SignupModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SignupModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
