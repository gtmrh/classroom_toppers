import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/model/all_test_model/all_test_data.dart';
import 'package:classroom_toppers/model/course_model/courses_data.dart';

import '../../utils/app_color.dart';
import '../../utils/my_application.dart';
import '../../utils/strings.dart';
import '../../utils/theme.dart';
import '../../utils/widget_util.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List<AllTestData> testList = [];
  List<String> myCListId = [];

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 253, 244, 248),

      // resizeToAvoidBottomInset
      body: views(),
    );
  }

  Widget views() {
    return Obx(() {
      var typeid = app.appController.cTypeId.value;
      print("typeid${typeid}");

      List<String> filterCListId = app.appController.coursesList
          .where((e) => e.courseTypeId.toString().contains(typeid.toString()))
          .toList()
          .map((e) => e.id.toString())
          .toList();

      //my course id list, to show free test of mycourse
      myCListId = app.appController.myCoursesList
          .map((e) => e.courseId.toString())
          .toList();

      //filtered test by course type/ only purchased test / course test will appear
      testList = app.appController.allTestList
          .where((e) => filterCListId.contains(e.courseId.toString()))
          .toList();

      return testList.isEmpty
          ? Center(
              child: Text(
                "Sorry! No test available at this time",
                style: AppTheme.ttlStyl,
                textAlign: TextAlign.center,
              ),
            )
          : Stack(
              fit: StackFit.passthrough,
              children: [
                CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [testTxt(), _testsList()],
                ),
              ],
            );
    });
  }

  Widget testTxt() {
    return SliverToBoxAdapter(
      child: Container(
        padding:
            const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "All New Tests",
              style: AppTheme.ttlStyl,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }

  Widget _testsList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: testList.length,
        (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin:
                const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 5),
            // padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: appColor.bgColor,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //image
                    Container(
                      height: 100,
                      width: 130,
                      decoration: BoxDecoration(
                        color: appColor.fill,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: ExtendedImage.network(
                        BASE_URL + testList[index].imageLink.toString(),
                        // height: 100,
                        // width: 100,
                        fit: BoxFit.fill,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 8),
                    //name
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(right: 8, top: 5),
                            child: Text(
                              testList[index].testSeriesName.toString(),
                              style: AppTheme.t14B,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(right: 8, top: 8),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${testList[index].noOfQuestion} Qs",
                                    style: AppTheme.ttlStyl14B,
                                    textAlign: TextAlign.start,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.watch_later,
                                        size: 20,
                                        color: appColor.black,
                                      ),
                                      Text(
                                        "${testList[index].time} mins",
                                        style: AppTheme.ttlStyl14B,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ]),
                          ),

                          // Html(data: testList[index].description),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(right: 8, top: 8),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    myCListId.contains(
                                            testList[index].courseId.toString())
                                        // testList[index].access != "Free"
                                        ? 'Available'
                                        : "\u{20B9}${testList[index].price}",
                                    // : 'Free',
                                    style: AppTheme.t14B,
                                    textAlign: TextAlign.start,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await app.appController.checkTestSts(
                                          testList[index].id.toString());

                                      openTest(index);
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            shape: BoxShape.rectangle,
                                            color: appColor.btn),
                                        child: Text(
                                          myCListId.contains(testList[index]
                                                  .courseId
                                                  .toString())
                                              ? "Start Test"
                                              : "Buy Now",
                                          style: AppTheme.txtWhite,
                                        )),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  openTest(int index) async {
    if (app.appController.checkTestStstModel.data!.isNotEmpty) {
      checkTest(index, context, "check");
    } else {
      testInfo(index);
    }
  }

  checkTest(int index, BuildContext context, String test) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Test Already Submitted!!'),
          content: Text(
              'you already have submitted the test. Want to view your result or start test again?'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFFFFFFFF),
                backgroundColor: Colors.blueGrey,
                minimumSize: const Size(0, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Get.back();
                testInfo(index);
              },
              child: const Text(
                'Re-Test',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFFFFFFFF),
                backgroundColor: appColor.btn,
                minimumSize: const Size(0, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Get.back();
                // Navigator.of(context).pop();
                Get.toNamed(SCORE_SCREEN_CHECK, arguments: [test]);
              },
              child: const Text(
                'View Result',
              ),
            ),
          ],
        );
      },
    );
  }

  testInfo(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            testList[index].testSeriesName.toString(),
            style: AppTheme.t14B,
          ),
          content: Text(
            '- Test Duration: ${testList[index].time} mins \n'
            '- Total Questions: ${testList[index].noOfQuestion}\n'
            '- Total Options: ${testList[index].isAdvanceMode.toString().toLowerCase().contains('yes') ? 5 : 4}\n'
            '- Negative Marks: ${testList[index].negativeMarks} \n',
            style: AppTheme.ttlStyl14,
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFFFFFFFF),
                backgroundColor: Colors.pinkAccent,
                minimumSize: const Size(0, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                CoursesData coursesData = app.appController.coursesList
                    .where((e) =>
                        e.id.toString() == testList[index].courseId.toString())
                    .toList()[0];
                // Navigator.of(context).pop();
                Get.back();
                // check weather test is in my course list
                if (myCListId.contains(coursesData.id.toString())) {
                  Get.toNamed(Quiz_SCREEN, arguments: [
                    testList[index].testSeriesName,
                    testList[index].noOfQuestion,
                    testList[index].time,
                    testList[index].id,
                    testList[index].isAdvanceMode
                  ]);
                } else {
                  WidgetUtil().paymentDialog(
                      img: coursesData.image.toString(),
                      name: coursesData.name.toString(),
                      fees: coursesData.discountFee.toString(),
                      itemId: coursesData.id.toString());
                }
              },
              child: Text(
                'Agree & Continue',
                style: AppTheme.ttlWhiteStyl14,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget view() {
    return FutureBuilder<List<dynamic>>(
      future: Future<List<dynamic>>.value(
        Future.wait([
          app.appController.getAllTests(),
        ]),
      ),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SpinKitCircle(
            color: appColor.grey,
          );
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            testList = app.appController.allTestList;
            // .where((e) => e.courseTypeId.toString().contains(typeid.toString()))
            // .toList();

            if (testList == null) {
              return Container();
            } else {
              return testList.isEmpty
                  ? Center(
                      child: Text(
                        "Sorry! No test available at this time",
                        style: AppTheme.ttlStyl,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Stack(
                      fit: StackFit.passthrough,
                      children: [
                        CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          slivers: [testTxt(), _testsList()],
                        ),
                      ],
                    );
            }
          }
        }
      },
    );
  }
}
