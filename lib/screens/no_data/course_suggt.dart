import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/model/course_model/courses_data.dart';

import '../../utils/app_color.dart';
import '../../utils/my_application.dart';
import '../../utils/strings.dart';
import '../../utils/theme.dart';
import '../../utils/widget_util.dart';

class CourseSuggest extends StatefulWidget {
  CourseSuggest({super.key, required this.title});

  String title;

  @override
  State<CourseSuggest> createState() => _CourseSuggestState();
}

class _CourseSuggestState extends State<CourseSuggest> {
  List<CoursesData> cList = [];

  @override
  Widget build(BuildContext context) {
    return views();
  }

  Widget views() {
    return Obx(() {
      cList = app.appController.coursesList;

      return noData();
    });
  }

  Widget noData() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: WidgetUtil.noDataLottie()),
        SliverToBoxAdapter(
          child: Center(
            child: Text(
              widget.title,
              style: AppTheme.ttlStyl,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        viewCourses(),
        _courseList()
      ],
    );
  }

  Widget viewCourses() {
    return SliverToBoxAdapter(
      child: Container(
        padding:
            const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Popular Courses",
              style: AppTheme.ttlStyl,
              textAlign: TextAlign.start,
            ),
            // InkWell(
            //   onTap: () {
            //     // Get.toNamed(All_Cat_Screen, arguments: [CAT]);
            //   },
            //   child: Text(
            //     "See All",
            //     style: AppTheme.hinttxt,
            //     textAlign: TextAlign.start,
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  _courseList() {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 1.2),
        delegate: SliverChildBuilderDelegate(
          childCount: cList.length,
          // < 6 ? cList.length : 6,
          (context, index) {
            return InkWell(
              onTap: () {
                // if course have already purchased, then open course detils
                if (app.appController.myCoursesList
                    .map((e) => e.courseId)
                    .toList()
                    .contains(cList[index].id)) {
                  Get.toNamed(My_Course_Details_Screen,
                      arguments: cList[index].id);
                } else {
                  Get.toNamed(Course_Details_Screen,
                      arguments: cList[index].id);
                }
              },
              child: Container(
                  // height: 150,
                  width: MediaQuery.of(context).size.width,
                  // alignment: Alignment.center,

                  decoration: BoxDecoration(
                      color: appColor.bgColor,

                      // Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                      // Color.fromARGB(255, 243, 243, 243),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    children: [
                      ExtendedImage.network(
                        BASE_URL + cList[index].image.toString(),
                        fit: BoxFit.fitWidth,

                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8),
                        // color: Color.fromARGB(255, 228, 218, 255),
                        colorBlendMode: BlendMode.darken,
                        // height: 100,
                        // width: 100,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        cList[index].name.toString(),
                        style: AppTheme.ttlStyl12B,
                        // style: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, color:  ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }

  Widget view() {
    return FutureBuilder<List<dynamic>>(
      future: Future<List<dynamic>>.value(
        Future.wait([
          app.appController.getAllCourses(),
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
            // myCList = app.appController.myCoursesList;

            if (cList == null) {
              return Container();
            } else {
              return noData();
            }
          }
        }
      },
    );
  }
}
