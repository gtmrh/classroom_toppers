import 'dart:convert';

class ChatListData {
  int? id;
  int? videoId;
  int? userId;
  String? message;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? username;

  ChatListData({
    this.id,
    this.videoId,
    this.userId,
    this.message,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.username,
  });

  factory ChatListData.fromMap(Map<String, dynamic> data) => ChatListData(
        id: data['id'] as int?,
        videoId: data['video_id'] as int?,
        userId: data['user_id'] as int?,
        message: data['message'] as String?,
        status: data['status'] as int?,
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
        username: data['username'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'video_id': videoId,
        'user_id': userId,
        'message': message,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'username': username,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ChatListData].
  factory ChatListData.fromJson(String data) {
    return ChatListData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ChatListData] to a JSON string.
  String toJson() => json.encode(toMap());
}
