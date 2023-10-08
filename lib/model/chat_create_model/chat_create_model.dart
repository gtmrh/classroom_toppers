import 'dart:convert';

import 'chat_data.dart';

class ChatCreateModel {
  String? status;
  ChatData? data;

  ChatCreateModel({this.status, this.data});

  factory ChatCreateModel.fromMap(Map<String, dynamic> data) {
    return ChatCreateModel(
      status: data['status'] as String?,
      data: data['data'] == null
          ? null
          : ChatData.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ChatCreateModel].
  factory ChatCreateModel.fromJson(String data) {
    return ChatCreateModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ChatCreateModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
