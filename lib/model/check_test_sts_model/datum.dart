import 'dart:convert';

class TestCheckData {
  int? id;
  int? testId;
  int? userId;
  int? totalQuestion;
  String? attemptTime;
  int? totalAttempt;
  int? correctAnswer;
  int? wrongAnswer;
  int? notAttempt;
  dynamic negativeMarks;
  dynamic overallScore;
  dynamic accuracy;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  TestCheckData({
    this.id,
    this.testId,
    this.userId,
    this.totalQuestion,
    this.attemptTime,
    this.totalAttempt,
    this.correctAnswer,
    this.wrongAnswer,
    this.notAttempt,
    this.negativeMarks,
    this.overallScore,
    this.accuracy,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory TestCheckData.fromMap(Map<String, dynamic> data) => TestCheckData(
        id: data['id'] as int?,
        testId: data['test_id'] as int?,
        userId: data['user_id'] as int?,
        totalQuestion: data['total_question'] as int?,
        attemptTime: data['attempt_time'] as String?,
        totalAttempt: data['total_attempt'] as int?,
        correctAnswer: data['correct_answer'] as int?,
        wrongAnswer: data['wrong_answer'] as int?,
        notAttempt: data['not_attempt'] as int?,
        negativeMarks: data['negative_marks'] as dynamic,
        overallScore: data['overall_score'] as dynamic,
        accuracy: data['accuracy'] as dynamic,
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
        'total_question': totalQuestion,
        'attempt_time': attemptTime,
        'total_attempt': totalAttempt,
        'correct_answer': correctAnswer,
        'wrong_answer': wrongAnswer,
        'not_attempt': notAttempt,
        'negative_marks': negativeMarks,
        'overall_score': overallScore,
        'accuracy': accuracy,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TestCheckData].
  factory TestCheckData.fromJson(String data) {
    return TestCheckData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TestCheckData] to a JSON string.
  String toJson() => json.encode(toMap());
}
