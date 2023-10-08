import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/model/check_test_sts_model/datum.dart';
import 'package:classroom_toppers/utils/my_application.dart';

import '../../model/all_test_model/all_test_data.dart';
import '../../utils/app_color.dart';
import '../../utils/strings.dart';
import '../../utils/theme.dart';
import '../../utils/widget_util.dart';
import '../../widgets/app_logo.dart';

class TestResultCheck extends StatefulWidget {
  TestResultCheck({super.key});

  @override
  State<TestResultCheck> createState() => _TestResultCheckState();
}

class _TestResultCheckState extends State<TestResultCheck> {
  TestCheckData data = app.appController.checkTestStstModel.data![0];

  @override
  void initState() {
    getData();

    super.initState();
  }

  getData() async {
    //getting test solutions
    await app.appController.getTestSol(data.testId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Test Result",
          style: AppTheme.t14B,
        ),
      ),
      backgroundColor: AppColor().bgclr,
      body: view(),
    );
  }

  Widget view() {
    return SingleChildScrollView(
      // controller: controller,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Test Summary",
              style: AppTheme.fieldTxt,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: appColor.white),
              margin: const EdgeInsets.only(top: 20),
              alignment: Alignment.topLeft,
              width: MediaQuery.of(context).size.width,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              shape: BoxShape.rectangle,
                              color: appColor.vochBg),
                          child: Icon(
                            FontAwesomeIcons.trophy,
                            color: appColor.vochIcon,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "My Score",
                          style: AppTheme.t14B,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        double.tryParse(data.overallScore.toString())!
                            .toStringAsFixed(2),

                        // .replaceAll("-", ""),
                        style: AppTheme.t14B,
                      ),
                    ),
                  ]),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: appColor.white),
              margin: const EdgeInsets.only(top: 20),
              alignment: Alignment.topLeft,
              width: MediaQuery.of(context).size.width,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              shape: BoxShape.rectangle,
                              color: appColor.settingBg),
                          child: Icon(
                            FontAwesomeIcons.clock,
                            color: appColor.settingIcon,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Time Taken",
                          style: AppTheme.t14B,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        WidgetUtil()
                            .formatAttemptTime(data.attemptTime.toString()),
                        // "${data.attemptTime.toString()} mins",
                        style: AppTheme.t14B,
                      ),
                    ),
                  ]),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: appColor.white),
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.topLeft,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  shape: BoxShape.rectangle,
                                  color: appColor.notifBg),
                              child: Icon(
                                FontAwesomeIcons.lightbulb,
                                color: appColor.notifIcon,
                                size: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Accuracy",
                              style: AppTheme.t14B,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            double.tryParse(data.accuracy.toString())!
                                .toStringAsFixed(2),
                            style: AppTheme.t14B,
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  shape: BoxShape.rectangle,
                                  color: appColor.locBg),
                              child: Icon(
                                FontAwesomeIcons.solidPaperPlane,
                                color: appColor.locIcon,
                                size: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Qs. Attempted",
                              style: AppTheme.t14B,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Row(
                            children: [
                              Text(
                                data.totalAttempt.toString(),
                                style: AppTheme.t14B,
                              ),
                              Text(
                                "/${data.totalQuestion}",
                                style: AppTheme.ttlStyl14,
                              ),
                            ],
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  shape: BoxShape.rectangle,
                                  color: appColor.greyBg),
                              child: Icon(
                                Icons.remove,
                                color: appColor.greyDark,
                                size: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Negative Marks",
                              style: AppTheme.t14B,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Row(
                            children: [
                              Text(
                                double.tryParse(data.negativeMarks.toString())!
                                    .toStringAsFixed(2),
                                style: AppTheme.t14B,
                              ),
                            ],
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        // width: 40,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                            color: appColor.notifBg),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(
                              Icons.done,
                              color: appColor.notifIcon,
                              size: 20,
                            ),
                            Text(
                              "Correct\n${data.correctAnswer}",
                              style: AppTheme.ttlStyl12B,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        // width: 40,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                            color: appColor.settingBg),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(
                              Icons.close,
                              color: appColor.settingIcon,
                              size: 20,
                            ),
                            Text(
                              "Incorrect\n${data.wrongAnswer}",
                              style: AppTheme.ttlStyl12B,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        // width: 40,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                            color: appColor.bgclr),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(
                              Icons.question_mark,
                              color: appColor.greyDark,
                              size: 20,
                            ),
                            Text(
                              "Unattempeted\n${data.notAttempt}",
                              style: AppTheme.ttlStyl12B,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                AllTestData testData = app.appController.allTestList
                    .where((element) => element.id == data.testId)
                    .toList()[0];

                Get.toNamed(Solution_SCREEN, arguments: [
                  testData.testSeriesName,
                  testData.noOfQuestion,
                  testData.time,
                  testData.id,
                  testData.isAdvanceMode
                ]);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: appColor.btn),
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              shape: BoxShape.rectangle,
                              color: appColor.white),
                          child: AppLogo().tinyLogo()),
                      Text(
                        "View Solutions",
                        style: AppTheme.ttlWhiteStyl20,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: appColor.white,
                        size: 20,
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
