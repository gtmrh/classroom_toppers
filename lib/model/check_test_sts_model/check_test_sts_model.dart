import 'dart:convert';

import 'datum.dart';

class CheckTestStsModel {
  String? status;
  List<TestCheckData>? data;

  CheckTestStsModel({this.status, this.data});

  factory CheckTestStsModel.fromMap(Map<String, dynamic> data) {
    return CheckTestStsModel(
      status: data['status'] as String?,
      data: (data['data'] as List<dynamic>?)
          ?.map((e) => TestCheckData.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CheckTestStsModel].
  factory CheckTestStsModel.fromJson(String data) {
    return CheckTestStsModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CheckTestStsModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
