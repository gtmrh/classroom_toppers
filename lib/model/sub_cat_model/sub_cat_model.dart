import 'dart:convert';

import 'sub_cat_data.dart';

class SubCatModel {
  String? status;
  List<SubCatData>? data;

  SubCatModel({this.status, this.data});

  factory SubCatModel.fromMap(Map<String, dynamic> data) => SubCatModel(
        status: data['status'] as String?,
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => SubCatData.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SubCatModel].
  factory SubCatModel.fromJson(String data) {
    return SubCatModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SubCatModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
