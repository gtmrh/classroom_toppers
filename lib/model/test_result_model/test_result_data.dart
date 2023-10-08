import 'dart:convert';

class TestResultData {
  String? testId;
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
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  TestResultData({
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
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory TestResultData.fromMap(Map<String, dynamic> data) => TestResultData(
        testId: data['test_id'] as String?,
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
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        id: data['id'] as int?,
      );

  Map<String, dynamic> toMap() => {
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
        'updated_at': updatedAt?.toIso8601String(),
        'created_at': createdAt?.toIso8601String(),
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TestResultData].
  factory TestResultData.fromJson(String data) {
    return TestResultData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TestResultData] to a JSON string.
  String toJson() => json.encode(toMap());
}
