import 'dart:convert';

import 'chat_list_data.dart';

class ChatListModel {
  String? status;
  List<ChatListData>? data;

  ChatListModel({this.status, this.data});

  factory ChatListModel.fromMap(Map<String, dynamic> data) => ChatListModel(
        status: data['status'] as String?,
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => ChatListData.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ChatListModel].
  factory ChatListModel.fromJson(String data) {
    return ChatListModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ChatListModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
