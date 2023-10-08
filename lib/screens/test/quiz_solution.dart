import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:classroom_toppers/screens/test/quiz_controller.dart';
import 'package:classroom_toppers/utils/my_application.dart';
import 'package:classroom_toppers/utils/theme.dart';

import '../../model/check_test_sts_model/datum.dart';
import '../../utils/app_color.dart';
import '../../utils/strings.dart';
import '../../utils/widget_util.dart';

class QuizSolPage extends StatefulWidget {
  const QuizSolPage({super.key});

  @override
  State<QuizSolPage> createState() => _QuizSolPageState();
}

class _QuizSolPageState extends State<QuizSolPage> {
  Map<String, int> selectedAnswers = Map();

  Map<String, int> correctAnswers = Map();

  final quizController = Get.put(QuizController(
    Get.arguments[3].toString(),
    Get.arguments[2].toString(),
  ));

  int optionIndex = Get.arguments[4].toString() == "no" ? 4 : 5;
  TestCheckData testResult = app.appController.checkTestStstModel.data![0];

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${Get.arguments[1]} Qs.',
              style: AppTheme.ttlStyl14,
            ),
            Text(
              'Time Taken : ${WidgetUtil().formatAttemptTime(testResult.attemptTime.toString())} / ${Get.arguments[2].toString()} mins ',
              style: AppTheme.ttlStyl14,
            ),
          ],
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
                SingleChildScrollView(
                  child: Column(
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
                                        fontFamily:
                                            GoogleFonts.rubik().fontFamily,
                                        fontSize: FontSize(14),
                                        fontWeight: FontWeight.bold),
                                  },
                                ),
                              ),
                            ),
                            Column(
                              children: List.generate(optionIndex, (index) {
                                final option = controller.questions.isNotEmpty
                                    ? "${optionNo[index]}. ${controller.questions[controller.currentIndex.value].options[index]}"
                                    : '';
                                return InkWell(
                                  onTap: () {
                                    print(app.appController.correctAnswers);
                                    print(app.appController.correctAnswers[
                                        controller
                                            .questions[
                                                controller.currentIndex.value]
                                            .id
                                            .toString()]);

                                    print(controller
                                        .questions[
                                            controller.currentIndex.value]
                                        .id);
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
                                        color: bgColor(controller, index)),
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
                            controller.isNotAtmt.value
                                ? Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.red),
                                    child: Text(
                                      "Not Attempted",
                                      textAlign: TextAlign.start,
                                      style: AppTheme.ttlWhiteStyl12,
                                    ),
                                  )
                                : Container(),

                            //solution
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20, left: 10, right: 10),
                                child: Html(
                                  data:
                                      "Solution- ${controller.questions[controller.currentIndex.value].solution.toString().replaceAll('<p>', "").replaceAll('</p>', "").trim()}" ??
                                          "",
                                  style: {
                                    'body': Style(
                                        color: appColor.txtTitle,
                                        fontFamily:
                                            GoogleFonts.rubik().fontFamily,
                                        fontSize: FontSize(14),
                                        fontWeight: FontWeight.bold),
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                      // if (controller.isQuizFinished.value) WidgetUtil.loaderSpin(),
                    ],
                  ),
                ),
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
                        // ElevatedButton(
                        //   style: ElevatedButton.styleFrom(
                        //       backgroundColor: Colors.pinkAccent),
                        //   onPressed: () {
                        //     // controller.questions[
                        //     //         controller.currentIndex.value]
                        //     //     .clearSelectedOption();
                        //     // controller.fetchQuestions(controller
                        //     //     .questions[controller.currentIndex.value]
                        //     //     .prev);
                        //     // setState(() {});

                        //     String ques =
                        //         "${controller.questions[controller.currentIndex.value].qNo}. ${controller.questions[controller.currentIndex.value].question.toString().replaceAll('<p>', "").replaceAll('</p>', "").trim()}";
                        //     String ans =
                        //         "${controller.questions[controller.currentIndex.value].solution.toString().replaceAll('<p>', "").replaceAll('</p>', "").trim()}";

                        //     if (ans.toString() != 'null') {
                        //       ans = 'Solution-  $ans';
                        //       WidgetUtil().testSol(context, ques, ans);
                        //     } else {
                        //       Fluttertoast.showToast(
                        //           msg: "Solution not available");
                        //     }
                        //   },
                        //   child: Text(
                        //     'View Solution',
                        //     style: AppTheme.ttlWhiteStyl12,
                        //   ),
                        // ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent),
                          onPressed: () {
                            //fetched
                            controller.fetchQuestions(controller
                                .questions[controller.currentIndex.value].next);

                            print(controller
                                .questions[controller.currentIndex.value].id);

                            bool answered = controller.selectedAnswers
                                .containsKey(controller
                                    .questions[controller.currentIndex.value].id
                                    .toString());
                          },
                          child: Text(
                            'Next',
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

  bgColor(QuizController controller, int index) {
    print(
        'print>>${app.appController.correctAnswers.containsKey(controller.questions[controller.currentIndex.value].id.toString())}');
    print('print>>${app.appController.correctAnswers}');
    print(
        'print>${controller.questions[controller.currentIndex.value].id.toString()}');
    if (app.appController.correctAnswers.containsKey(
        controller.questions[controller.currentIndex.value].id.toString())) {
      controller.isNotAtmt.value = false;

      if (app.appController.correctAnswers[controller
                  .questions[controller.currentIndex.value].id
                  .toString()] ==
              index &&
          app.appController.selectedAnswers[controller
                  .questions[controller.currentIndex.value].id
                  .toString()] ==
              index) {
        return Colors.green;
      } else if (app.appController.correctAnswers[controller
              .questions[controller.currentIndex.value].id
              .toString()] ==
          index) {
        return Colors.green;
      } else if (app.appController
              .selectedAnswers[controller.questions[controller.currentIndex.value].id.toString()] ==
          index) {
        return Colors.red;
      } else {
        return Colors.white;
      }
    } else {
      controller.isNotAtmt.value = true;
      if (optionNo.indexOf(controller
              .questions[controller.currentIndex.value].correctOption
              .toLowerCase()
              .trim()) ==
          index) {
        return Colors.green;
      } else {
        return Colors.white;
      }
    }
  }
}
