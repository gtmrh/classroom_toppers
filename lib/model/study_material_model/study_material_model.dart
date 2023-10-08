import 'dart:convert';

import 'study_matrl_data.dart';

class StudyMaterialModel {
  String? status;
  List<StudyMaterialData>? data;

  StudyMaterialModel({this.status, this.data});

  factory StudyMaterialModel.fromMap(Map<String, dynamic> data) {
    return StudyMaterialModel(
      status: data['status'] as String?,
      data: (data['data'] as List<dynamic>?)
          ?.map((e) => StudyMaterialData.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [StudyMaterialModel].
  factory StudyMaterialModel.fromJson(String data) {
    return StudyMaterialModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [StudyMaterialModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
