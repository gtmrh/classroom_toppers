import 'dart:convert';

import 'test_sol_data.dart';

class TestSolModel {
  String? status;
  List<TestSolData>? data;

  TestSolModel({this.status, this.data});

  factory TestSolModel.fromMap(Map<String, dynamic> data) => TestSolModel(
        status: data['status'] as String?,
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => TestSolData.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TestSolModel].
  factory TestSolModel.fromJson(String data) {
    return TestSolModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TestSolModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
