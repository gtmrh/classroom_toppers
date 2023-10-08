import 'dart:convert';

import 'test_result_data.dart';

class TestResultModel {
  String? status;
  TestResultData? data;

  TestResultModel({this.status, this.data});

  factory TestResultModel.fromMap(Map<String, dynamic> data) {
    return TestResultModel(
      status: data['status'] as String?,
      data: data['data'] == null
          ? null
          : TestResultData.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TestResultModel].
  factory TestResultModel.fromJson(String data) {
    return TestResultModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TestResultModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
