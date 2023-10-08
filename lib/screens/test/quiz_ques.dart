import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:classroom_toppers/screens/test/quiz_controller.dart';
import 'package:classroom_toppers/utils/theme.dart';

import '../../utils/app_color.dart';
import '../../utils/strings.dart';
import '../../utils/widget_util.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final quizController = Get.put(QuizController(
    Get.arguments[3].toString(),
    Get.arguments[2].toString(),
  ));

  // bool isAdvance = Get.arguments[4].toString() == "no";

  int optionIndex = Get.arguments[4].toString() == "no" ? 4 : 5;

  @override
  void initState() {
    quizController.fetchQuestions(Get.arguments[3].toString());
    super.initState();
  }

  @override
  void dispose() {
    quizController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<QuizController>(
          init: quizController,
          builder: (controller) {
            final timeRemaining = controller.timeRemaining;
            return Obx(
              () => Text(
                '${Get.arguments[1]} Qs.      Time Remaining: ${timeRemaining.value} mins',
                style: AppTheme.ttlStyl14,
              ),
            );
          },
        ),
      ),
      body: GetBuilder<QuizController>(
        init: quizController,
        builder: (controller) {
          if (controller.questions.value.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        alignment: Alignment.topLeft,
                        child: SingleChildScrollView(
                          child: Html(
                            data:
                                "${controller.questions[controller.currentIndex.value].qNo}. ${controller.questions[controller.currentIndex.value].question.toString().replaceAll('<p>', "").replaceAll('</p>', "").trim()}",
                            style: {
                              'body': Style(
                                  color: appColor.txtTitle,
                                  fontFamily: GoogleFonts.rubik().fontFamily,
                                  fontSize: FontSize(14),
                                  fontWeight: FontWeight.bold),
                            },
                          ),
                        ),

                        // Text(
                        //   controller.questions.isEmpty
                        //       ? 'Loading...'
                        //       : "${controller.questions[controller.currentIndex.value].qNo}. ${controller.questions[controller.currentIndex.value].question}",
                        // style: AppTheme.title20,
                        // ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: List.generate(optionIndex, (index) {
                            final option = controller.questions.isNotEmpty
                                ? "${optionNo[index]}. ${controller.questions[controller.currentIndex.value].options[index]}"
                                : '';
                            return InkWell(
                              onTap: () {
                                controller
                                    .questions[controller.currentIndex.value]
                                    .setSelectedOption(index);
                                controller.answerQuestion(
                                  controller
                                      .questions[controller.currentIndex.value]
                                      .id
                                      .toString(),
                                  index,
                                  controller
                                      .questions[controller.currentIndex.value]
                                      .correctOption
                                      .toString(),
                                );
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                margin: EdgeInsets.all(8),
                                width: MediaQuery.of(context).size.width,
                                // height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                    width: 2,
                                  ),
                                  color:
                                      // controller.questions[
                                      //             controller.currentIndex.value]
                                      //         .isOptionSelected(index)
                                      //     ? Colors.green
                                      //     :
                                      controller.selectedAnswers[controller
                                                  .questions[controller
                                                      .currentIndex.value]
                                                  .id
                                                  .toString()] ==
                                              index
                                          ? Colors.green
                                          : Colors.white,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    option,
                                    textAlign: TextAlign.start,
                                    style: AppTheme.ttlStyl12,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                if (controller.isQuizFinished.value) WidgetUtil.loaderSpin(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        controller.questions[controller.currentIndex.value]
                                    .currentQues ==
                                "1"
                            ? Container(
                                width: 50,
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green[600]),
                                onPressed: () {
                                  // controller.questions[
                                  //         controller.currentIndex.value]
                                  //     .clearSelectedOption();
                                  controller.fetchQuestions(controller
                                      .questions[controller.currentIndex.value]
                                      .prev);
                                  setState(() {});
                                },
                                child: Text(
                                  'Previous',
                                  style: AppTheme.ttlWhiteStyl12,
                                ),
                              ),
                        controller.questions[controller.currentIndex.value]
                                    .currentQues ==
                                controller
                                    .questions[controller.currentIndex.value]
                                    .totalQues
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent),
                                onPressed: () async {
                                  //submit test
                                  controller
                                      .submitQuiz(Get.arguments[2].toString());
                                  // Fluttertoast.showToast(msg: "end");
                                  bool answered = controller.selectedAnswers
                                      .containsKey(controller
                                          .questions[
                                              controller.currentIndex.value]
                                          .id
                                          .toString());

                                  // if (answered) {
                                  //   controller.submitQuiz(
                                  //       Get.arguments[2].toString());
                                  // } else {
                                  //   Fluttertoast.showToast(
                                  //       msg: "Please answer the question");
                                  // }
                                },
                                child: Text(
                                  'Submit Test',
                                  style: AppTheme.ttlWhiteStyl12,
                                ),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent),
                                onPressed: () {
                                  //fetched
                                  controller.fetchQuestions(controller
                                      .questions[controller.currentIndex.value]
                                      .next);

                                  print(controller
                                      .questions[controller.currentIndex.value]
                                      .id);

                                  bool answered = controller.selectedAnswers
                                      .containsKey(controller
                                          .questions[
                                              controller.currentIndex.value]
                                          .id
                                          .toString());

                                  // if (answered) {
                                  //   //load next question
                                  //   controller.fetchQuestions(controller
                                  //       .questions[
                                  //           controller.currentIndex.value]
                                  //       .next);
                                  // } else {
                                  //   controller.answerQuestion(
                                  //       controller
                                  //           .questions[
                                  //               controller.currentIndex.value]
                                  //           .id
                                  //           .toString(),
                                  //       5);

                                  //   //load next question
                                  //   controller.fetchQuestions(controller
                                  //       .questions[
                                  //           controller.currentIndex.value]
                                  //       .next);

                                  // }
                                },
                                child: Text(
                                  'Save & Next',
                                  style: AppTheme.ttlWhiteStyl12,
                                ),
                              ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildResult(QuizController controller) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Quiz Finished!',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          Text(
            'Final Score: ${controller.score} / ${controller.questions.length}',
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
