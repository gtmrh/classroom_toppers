import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/model/course_type_model/course_type_data.dart';
import 'package:classroom_toppers/utils/sharedpref.dart';
import 'package:classroom_toppers/utils/strings.dart';
import 'package:classroom_toppers/widgets/app_logo.dart';

import '../../utils/app_color.dart';
import '../../utils/my_application.dart';
import '../../utils/theme.dart';
import '../../utils/widget_util.dart';

class CourseType extends StatefulWidget {
  CourseType({super.key});

  @override
  State<CourseType> createState() => _CourseTypeState();
}

class _CourseTypeState extends State<CourseType> {
  List<CourseTypeData> cType = [];

  @override
  void initState() {
    // getData();
    super.initState();
  }

  getData() async {
    // await app.appController.getCourseType();

    // await app.appController.getSlider();
    // await app.appController.getAllCourses();
    // await app.appController.getMyCourses();
    // await app.appController.getAllTests();
    // await app.appController.getAllVideos();
    // await app.appController.getCat();
    // await app.appController.getSubCat();
    // await app.appController.getStudyMat();
    // await app.appController.getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(backgroundColor: appColor.white, body: views()));
  }

  Widget views() {
    return Obx(() {
      cType = app.appController.coursesType;
      if (cType.isEmpty) {
        return SpinKitCircle(
          color: appColor.grey,
        );
      } else {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            title(),
            _courseList(),
          ],
        );
      }
    });
  }

  Widget title() {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Container(
          // height: 00,
          padding:
              const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
          decoration: BoxDecoration(color: appColor.walletBg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppLogo().appBarLogo(),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Choose your course",
                    style: AppTheme.title20,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              WidgetUtil.learningLottie(),
            ],
          ),
        ),
      ),
    );
  }

  _courseList() {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 50),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: cType.length,
          addRepaintBoundaries: true,
          (context, index) {
            return InkWell(
              onTap: () async {
                await SharedPref().setCourseType(cType[index].id.toString());
                await app.appController.getData();
                Get.offNamed(HOME_SCREEN, arguments: '0');
              },
              child: Card(
                child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: appColor.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0))),
                    child: Text(
                      cType[index].courseType.toString(),
                      style: AppTheme.ttlStyl14B,
                      textAlign: TextAlign.start,
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
