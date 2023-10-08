import 'dart:convert';

class ChangePassModel {
  String? status;
  String? message;

  ChangePassModel({this.status, this.message});

  factory ChangePassModel.fromMap(Map<String, dynamic> data) {
    return ChangePassModel(
      status: data['status'] as String?,
      message: data['message'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ChangePassModel].
  factory ChangePassModel.fromJson(String data) {
    return ChangePassModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ChangePassModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
