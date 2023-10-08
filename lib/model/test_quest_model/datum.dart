import 'dart:convert';

class Datum {
  int? id;
  int? testId;
  String? testCategory;
  String? question;
  dynamic questionImage;
  String? optionA;
  dynamic optionAImage;
  String? optionB;
  dynamic optionBImage;
  String? optionC;
  dynamic optionCImage;
  String? optionD;
  String? optionE;
  dynamic optionEImage;
  dynamic optionDImage;
  String? answer;
  dynamic solution;
  dynamic solutionImage;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.testId,
    this.testCategory,
    this.question,
    this.questionImage,
    this.optionA,
    this.optionAImage,
    this.optionB,
    this.optionBImage,
    this.optionC,
    this.optionCImage,
    this.optionD,
    this.optionE,
    this.optionEImage,
    this.optionDImage,
    this.answer,
    this.solution,
    this.solutionImage,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
        id: data['id'] as int?,
        testId: data['test_id'] as int?,
        testCategory: data['test_category'] as String?,
        question: data['question'] as String?,
        questionImage: data['question_image'] as dynamic,
        optionA: data['option_a'] as String?,
        optionAImage: data['option_a_image'] as dynamic,
        optionB: data['option_b'] as String?,
        optionBImage: data['option_b_image'] as dynamic,
        optionC: data['option_c'] as String?,
        optionCImage: data['option_c_image'] as dynamic,
        optionD: data['option_d'] as String?,
        optionE: data['option_e'] as String?,
        optionEImage: data['option_e_image'] as dynamic,
        optionDImage: data['option_d_image'] as dynamic,
        answer: data['answer'] as String?,
        solution: data['solution'] as dynamic,
        solutionImage: data['solution_image'] as dynamic,
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
        'test_category': testCategory,
        'question': question,
        'question_image': questionImage,
        'option_a': optionA,
        'option_a_image': optionAImage,
        'option_b': optionB,
        'option_b_image': optionBImage,
        'option_c': optionC,
        'option_c_image': optionCImage,
        'option_d': optionD,
        'option_e': optionE,
        'option_e_image': optionEImage,
        'option_d_image': optionDImage,
        'answer': answer,
        'solution': solution,
        'solution_image': solutionImage,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Datum].
  factory Datum.fromJson(String data) {
    return Datum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Datum] to a JSON string.
  String toJson() => json.encode(toMap());
}
