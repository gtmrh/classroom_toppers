import 'dart:convert';

class LiveUserCountModel {
  String? status;

  LiveUserCountModel({this.status});

  factory LiveUserCountModel.fromMap(Map<String, dynamic> data) {
    return LiveUserCountModel(
      status: data['status'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LiveUserCountModel].
  factory LiveUserCountModel.fromJson(String data) {
    return LiveUserCountModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LiveUserCountModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
