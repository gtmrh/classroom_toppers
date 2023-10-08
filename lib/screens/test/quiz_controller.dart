import 'dart:async';
import 'package:get/get.dart';
import 'package:classroom_toppers/utils/my_application.dart';
import 'package:classroom_toppers/utils/strings.dart';

class QuizController extends GetxController {
  RxList<Question> questions = <Question>[].obs;
  RxInt currentIndex = 0.obs;
  RxInt score = 0.obs;
  RxBool isQuizFinished = false.obs;
  RxInt timeRemaining = 120.obs;
  RxInt timeRunning = 0.obs;
  RxBool isNotAtmt = false.obs;

  RxList<bool> userSelections = List<bool>.filled(4, false).obs;
  // List<int> correctAnswers = []; // Store correct answers
  // List<int> selectedAnswers = [];

  Map<String, int> selectedAnswers = Map();

  Map<String, String> correctAnswers = Map();

  final String id;
  final String time;

  QuizController(
    this.id,
    this.time,
  );

  @override
  void onInit() {
    print("oninit>>>");
    fetchQuestions(id);
    _startTimer();
    super.onInit();
  }

  void selectOption(String option) {
    questions[currentIndex.value].selectedOption = option;
  }

  void _startTimer() {
    print("on start>>>");
    Timer.periodic(const Duration(minutes: 1), (timer) {
      if (timeRemaining.value > 0) {
        timeRemaining.value--;
      } else {
        timer.cancel();
        isQuizFinished.value = true;
      }
    });
  }

  fetchQuestions(String quizId) async {
    await app.appController.getTestQues(id: quizId.toString());

    print("on fetchQuestions>>>");

    questions.value = app.appController.testQues!.data?.map((testQuestData) {
          // Store correct answer.... only selected option correct answer will

          // correctAnswers.add(
          //     optionNo.indexOf(testQuestData.answer.toString().toLowerCase()));

          return Question(
            id: testQuestData.id!,
            testCategory: testQuestData.testCategory!,
            question: testQuestData.question!,
            solution:
                testQuestData.solution == null ? "" : testQuestData.solution,
            options: [
              testQuestData.optionA!,
              testQuestData.optionB!,
              testQuestData.optionC!,
              testQuestData.optionD!,
              testQuestData.optionE!,
            ],
            correctOption: testQuestData.answer!,
            qNo: app.appController.testQues!.currentPage.toString(),
            next: app.appController.testQues!.nextPageUrl
                .toString()
                .replaceAll(BASE_URL + TestQuest, "")
                .trim()
                .toString(),
            prev: app.appController.testQues!.prevPageUrl
                .toString()
                .replaceAll(BASE_URL + TestQuest, "")
                .trim()
                .toString(),
            currentQues: app.appController.testQues!.currentPage.toString(),
            totalQues: app.appController.testQues!.total.toString(),
          );
        }).toList() ??
        [];

    update(); // This will trigger UI update when questions are fetched.
  }

  void answerQuestion(String qId, int selectedOptionIndex, String cAns) {
    selectedAnswers[qId] = selectedOptionIndex;
    correctAnswers[qId] = cAns;

    print("qId>>$qId");
    print("Selected Ans >> $selectedAnswers)");

    print("Correct Ans >> $correctAnswers)");
  }

  void submitQuiz(String ttlTime) async {
    isQuizFinished.value = true;
//time
    int atmtTime =
        int.parse(ttlTime) - int.parse(timeRemaining.value.toString());

    // testId
    var testId = Get.arguments[3].toString();

    var questId = correctAnswers.keys.toList();

    var userAns =
        selectedAnswers.values.map((e) => optionNo[e].toUpperCase()).toList();

    var crctAns = correctAnswers.values.toList();

    await app.appController
        .submitTest(testId, atmtTime.toString(), questId, userAns, crctAns);

    if (app.appController.testResultModel.status == "success") {
      isQuizFinished.value = false;
      Get.back();
      Get.toNamed(SCORE_SCREEN);
    }
  }
}

class Question {
  String qNo;
  String totalQues;
  String currentQues;
  String prev;
  String next;
  int id;
  String testCategory;
  String question;
  String solution;
  List<String> options;
  String correctOption;
  String? selectedOption;
  bool isAnswered = false;

  Question({
    required this.totalQues,
    required this.currentQues,
    required this.qNo,
    required this.prev,
    required this.next,
    required this.id,
    required this.testCategory,
    required this.question,
    required this.solution,
    required this.options,
    required this.correctOption,
  });

  bool isOptionSelected(int index) {
    return selectedOption == options[index];
  }

  void setSelectedOption(int index) {
    selectedOption = options[index];
  }

// New method to clear the selected option
  void clearSelectedOption() {
    selectedOption = null;
  }

  int getCorrectOptionIndex() {
    switch (correctOption.toUpperCase()) {
      case 'A':
        return 0;
      case 'B':
        return 1;
      case 'C':
        return 2;
      case 'D':
        return 3;
      default:
        return 0;
    }
  }
}
