import 'dart:convert';

import 'all_test_data.dart';

class AllTestModel {
  String? status;
  List<AllTestData>? data;

  AllTestModel({this.status, this.data});

  factory AllTestModel.fromMap(Map<String, dynamic> data) => AllTestModel(
        status: data['status'] as String?,
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => AllTestData.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AllTestModel].
  factory AllTestModel.fromJson(String data) {
    return AllTestModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AllTestModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
