import 'dart:convert';

class ChatData {
  int? userId;
  String? videoId;
  String? message;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  ChatData({
    this.userId,
    this.videoId,
    this.message,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory ChatData.fromMap(Map<String, dynamic> data) => ChatData(
        userId: data['user_id'] as int?,
        videoId: data['video_id'] as String?,
        message: data['message'] as String?,
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        id: data['id'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'user_id': userId,
        'video_id': videoId,
        'message': message,
        'updated_at': updatedAt?.toIso8601String(),
        'created_at': createdAt?.toIso8601String(),
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ChatData].
  factory ChatData.fromJson(String data) {
    return ChatData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ChatData] to a JSON string.
  String toJson() => json.encode(toMap());
}
