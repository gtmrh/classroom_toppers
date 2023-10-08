import 'dart:convert';

import 'cat_data.dart';

class CatModel {
  String? status;
  List<CatData>? data;

  CatModel({this.status, this.data});

  factory CatModel.fromMap(Map<String, dynamic> data) => CatModel(
        status: data['status'] as String?,
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => CatData.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CatModel].
  factory CatModel.fromJson(String data) {
    return CatModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CatModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
