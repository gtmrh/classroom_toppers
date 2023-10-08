import 'dart:convert';

import 'banner_data.dart';

class BannerModel {
  String? status;
  List<BannerData>? data;

  BannerModel({this.status, this.data});

  factory BannerModel.fromMap(Map<String, dynamic> data) => BannerModel(
        status: data['status'] as String?,
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => BannerData.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BannerModel].
  factory BannerModel.fromJson(String data) {
    return BannerModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BannerModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
