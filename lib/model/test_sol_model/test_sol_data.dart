import 'dart:convert';

class TestSolData {
  int? id;
  int? testId;
  int? userId;
  String? attemptTime;
  int? questionId;
  String? answer;
  String? correctAnswer;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  TestSolData({
    this.id,
    this.testId,
    this.userId,
    this.attemptTime,
    this.questionId,
    this.answer,
    this.correctAnswer,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory TestSolData.fromMap(Map<String, dynamic> data) => TestSolData(
        id: data['id'] as int?,
        testId: data['test_id'] as int?,
        userId: data['user_id'] as int?,
        attemptTime: data['attempt_time'] as String?,
        questionId: data['question_id'] as int?,
        answer: data['answer'] as String?,
        correctAnswer: data['correct_answer'] as String?,
        status: data['status'] as int?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'test_id': testId,
        'user_id': userId,
        'attempt_time': attemptTime,
        'question_id': questionId,
        'answer': answer,
        'correct_answer': correctAnswer,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TestSolData].
  factory TestSolData.fromJson(String data) {
    return TestSolData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TestSolData] to a JSON string.
  String toJson() => json.encode(toMap());
}
