import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:classroom_toppers/model/assigned_course_model/asgn_course_data.dart';
import 'package:classroom_toppers/model/course_model/courses_data.dart';

import '../../utils/app_color.dart';
import '../../utils/my_application.dart';
import '../../utils/strings.dart';
import '../../utils/theme.dart';
import '../no_data/course_suggt.dart';

class MyCourses extends StatefulWidget {
  final Function() switchToTest;

  const MyCourses({super.key, required this.switchToTest});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  List<AsgnCourseData> myCList = [];

  List<CoursesData> cList = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 253, 244, 248),

        // resizeToAvoidBottomInset
        body: view());
  }

  getData() async {
    await app.appController.getMyCourses();
  }

  Widget view() {
    return Obx(() {
      cList = app.appController.coursesList;
      myCList = app.appController.myCoursesList;
      print("len>>${myCList.length}");
      return myCList.isEmpty
          ? CourseSuggest(
              title: NotEnrolled,
            )
          : CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [_mineCourses()],
            );
    });
  }

  _mineCourses() {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: myCList.length,
          addRepaintBoundaries: true,
          (context, index) {
            return Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    // border: BoxBorder.lerp(a, b, t),
                    color: appColor.white,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      cList
                          .where((e) => e.id == myCList[index].courseId)
                          .toList()[0]
                          .name
                          .toString(),
                      style: AppTheme.ttlStyl14B,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        print("courseid>>${myCList[index].courseId}");

                        if (cList
                                .where((e) => e.id == myCList[index].courseId)
                                .toList()[0]
                                .name!
                                .toLowerCase()
                                .contains(TEST) ||
                            cList
                                .where((e) => e.id == myCList[index].courseId)
                                .toList()[0]
                                .name!
                                .toLowerCase()
                                .contains(EXAM)) {
                          widget.switchToTest();
                        } else {
                          Get.toNamed(My_Course_Details_Screen,
                              arguments: myCList[index].courseId);
                        }
                      },
                      child: ExtendedImage.network(
                        BASE_URL +
                            cList
                                .where((e) => e.id == myCList[index].courseId)
                                .toList()[0]
                                .image
                                .toString(),
                        fit: BoxFit.fitWidth,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8),
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.book,
                          color: appColor.greyDark,
                          size: 15,
                        ),
                        Html(
                          data: cList
                              .where((e) => e.id == myCList[index].courseId)
                              .toList()[0]
                              .description
                              .toString(),
                          shrinkWrap: true,
                          style: {
                            "body": Style(
                              fontSize: FontSize(14.0),
                              fontWeight: FontWeight.w500,
                              maxLines: 2,
                              fontFamily: GoogleFonts.rubik().fontFamily,
                            ),
                          },
                        ),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 3,
                    // ),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 3,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.calendar,
                          color: appColor.greyDark,
                          size: 15,
                          // weight: 10,
                        ),
                        Text(
                          cList
                              .where((e) => e.id == myCList[index].courseId)
                              .toList()[0]
                              .duration
                              .toString(),
                          style: AppTheme.ttlStyl12B,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ));
          },
        ),
      ),
    );
  }

  Widget views() {
    return FutureBuilder<List<dynamic>>(
      future: Future<List<dynamic>>.value(
        Future.wait([
          app.appController.getAllCourses(),
          app.appController.getMyCourses(),
          app.appController.getCat(),
          app.appController.getSubCat(),
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
            cList = app.appController.coursesList;
            myCList = app.appController.myCoursesList;

            if (myCList == null) {
              return Container();
            } else {
              return myCList.isEmpty
                  ? CourseSuggest(
                      title: NotEnrolled,
                    )
                  : CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [_mineCourses()],
                    );
            }
          }
        }
      },
    );
  }

  Widget myCourses() {
    return SliverToBoxAdapter(
      child: Container(
        padding:
            const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Courses",
              style: AppTheme.ttlStyl,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
