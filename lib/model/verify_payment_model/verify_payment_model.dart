import 'dart:convert';

import 'data.dart';

class VerifyPaymentModel {
  String? status;
  Data? data;

  VerifyPaymentModel({this.status, this.data});

  factory VerifyPaymentModel.fromMap(Map<String, dynamic> data) =>
      VerifyPaymentModel(
        status: data['status'] as String?,
        data: data['data'] == null
            ? null
            : Data.fromMap(data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [VerifyPaymentModel].
  factory VerifyPaymentModel.fromJson(String data) {
    return VerifyPaymentModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [VerifyPaymentModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
