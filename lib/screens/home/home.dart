import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:classroom_toppers/model/assigned_course_model/asgn_course_data.dart';
import 'package:classroom_toppers/model/banner_model/banner_data.dart';
import 'package:classroom_toppers/model/course_model/courses_data.dart';

import '../../model/course_type_model/course_type_data.dart';
import '../../utils/app_color.dart';
import '../../utils/my_application.dart';
import '../../utils/strings.dart';
import '../../utils/theme.dart';
import '../../utils/widget_util.dart';
import '../../widgets/sliver_search_app_bar.dart';

// final GlobalKey<HomeState> homeKey = GlobalKey();

class Home extends StatefulWidget {
  // final Function(String? value) update;
  final Function() switchToMyCourse;

  const Home({
    super.key,
    required this.switchToMyCourse,
  });

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  late String userName;
  late String userId;

  List<CoursesData> cList = [];

  List<AsgnCourseData> myCList = [];

  List<CourseTypeData> courseType = [];

  List<String> asgnCourseId = [];

  // String? _typeValue;

  late String typeid;

  updateState() {
    setState(() {});
  }

  @override
  void initState() {

    // app.appController.onInit();

    super.initState();
  }

  getData() async {
    // var cTypeId = await SharedPref().getCourseType();
    // var name = await SharedPref().getUserName();
    // var id = await SharedPref().getUserId();

    // setState(() {
    //   typeid = cTypeId.toString();

    //   userName = name.toString();
    //   userId = id.toString();
    //   // courseType = app.appController.coursesType;
    //   print("id>>>>$typeid");
    // });

    // await app.appController.getCat();
    // await app.appController.getSubCat();
  }

  @override
  Widget build(BuildContext context) {
    // WidgetUtil().preventScreenCapture();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 253, 244, 248),
        body: view());
  }

  Widget view() {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              delegate: SliverSearchAppBar(),
              pinned: true,
            ),
            slider(),
            viewCourses(),
            _courseList(),
          ],
        ),
      ],
    );
  }

  Widget slider() {
    return Obx(() {
      if (app.appController.sliderList.isEmpty) {
        return SliverToBoxAdapter(
          child: WidgetUtil.loaderSpin(),
        );
      } else {
        return SliverToBoxAdapter(
          child: CarouselSlider.builder(
            options: CarouselOptions(
              height: 180,
              clipBehavior: Clip.hardEdge,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 1500),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
            ),
            itemCount: app.appController.sliderList.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              final data = app.appController.sliderList[itemIndex];
              return sliderItem(data);
            },
          ),
        );
      }
    });
  }

  sliderItem(BannerData data) {
    return InkWell(
      onTap: () {
        //buy course
        CoursesData cData = app.appController.coursesList
            .where((e) => e.id.toString() == data.courseId.toString())
            .toList()[0];

        WidgetUtil().paymentDialog(
            img: data.imageLink.toString(),
            name: cData.name.toString(),
            fees: cData.discountFee.toString(),
            itemId: cData.id.toString());
      },
      child: Container(
        // padding: EdgeInsets.all(8),
        // height: 100,
        // color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: const BoxDecoration(),
        child: Stack(
          children: [
            ExtendedImage.network(
              BASE_URL + data.imageLink.toString() ?? "",
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              colorBlendMode: BlendMode.darken,
            ),
            Positioned(
              left: 50,
              bottom: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _courseList() {
    return Obx(() {
      typeid = app.appController.cTypeId.value;
      print("typeid${typeid}");

      myCList = app.appController.myCoursesList;

      cList = app.appController.coursesList
          .where((e) => e.courseTypeId.toString().contains(typeid.toString()))
          .toList();

      asgnCourseId = app.appController.asgnIdList;
      if (app.appController.coursesList.isEmpty) {
        return SliverToBoxAdapter(
          child: WidgetUtil.loaderSpin(),
        );
      } else {
        return SliverPadding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: cList.length,
              addRepaintBoundaries: true,
              (context, index) {
                bool alreadyAssignd = app.appController.asgnIdList
                    .contains(cList[index].id.toString());
                print('matchsts>> $alreadyAssignd');
                return InkWell(
                  onTap: () {},
                  child: Container(
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
                            cList[index].name.toString(),
                            style: AppTheme.ttlStyl14B,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
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
                            height: 3,
                          ),
                          Wrap(
                            direction: Axis.horizontal,
                            // spacing: 3,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.book,
                                color: appColor.greyDark,
                                size: 15,
                              ),
                              Html(
                                data: cList[index].description.toString(),
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
                                cList[index].duration.toString(),
                                style: AppTheme.ttlStyl12B,
                                textAlign: TextAlign.start,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "\u{20B9}${cList[index].discountFee}",
                                  style: AppTheme.priceTtl,
                                  textAlign: TextAlign.start,
                                ),
                                cList[index].courseFee !=
                                        cList[index].discountFee
                                    ? Text(
                                        "  \u{20B9}${cList[index].courseFee}",
                                        style: AppTheme.priceStrike,
                                        textAlign: TextAlign.start,
                                      )
                                    : Container(),
                              ]),
                          Text(
                            WidgetUtil().offPercent(
                                cList[index].courseFee.toString(),
                                cList[index].discountFee.toString()),
                            style: AppTheme.offerStyl,
                          ),

                          alreadyAssignd
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.5,
                                          foregroundColor:
                                              const Color(0xFFFFFFFF),
                                          backgroundColor: appColor.btn,
                                          minimumSize: const Size(0, 45),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: () async {
                                          String link = cList[index]
                                              .whatsAppLink
                                              .toString();

                                          WidgetUtil().joinGroup(link);
                                        },
                                        child: Text(
                                          "Join Whatsapp Group",
                                          style: AppTheme.ttlWhiteStyl12,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.5,
                                          // foregroundColor: const Color(0xFFFFFFFF),
                                          backgroundColor: appColor.pinkLight,
                                          minimumSize: const Size(0, 45),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: () {
                                          Get.toNamed(Course_Details_Screen,
                                              arguments: cList[index].id);
                                        },
                                        child: Text(
                                          'Explore More',
                                          style: AppTheme.ttlStyl12B,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: cList[index]
                                                  .discountFee
                                                  .toString() ==
                                              '0'
                                          ? ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0.5,
                                                foregroundColor:
                                                    const Color(0xFFFFFFFF),
                                                backgroundColor:
                                                    appColor.btnClr,
                                                minimumSize: const Size(0, 45),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () {
                                                // if (cList[index]
                                                //         .discountFee
                                                //         .toString() ==
                                                //     '0') {
                                                //   widget.switchToMyCourse();
                                                // } else {
                                                WidgetUtil().enroll(
                                                    img: cList[index]
                                                        .image
                                                        .toString(),
                                                    name: cList[index]
                                                        .name
                                                        .toString(),
                                                    itemId: cList[index]
                                                        .id
                                                        .toString());

                                                // }
                                              },
                                              child: Text(
                                                "Free Enroll",
                                                style: AppTheme.ttlWhiteStyl12,
                                              ),
                                            )
                                          : ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0.5,
                                                foregroundColor:
                                                    const Color(0xFFFFFFFF),
                                                backgroundColor:
                                                    appColor.btnClr,
                                                minimumSize: const Size(0, 45),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () {
                                                // if (
                                                //   cList[index]
                                                //         .discountFee
                                                //         .toString()
                                                //          ==
                                                //     '0') {
                                                //   widget.switchToMyCourse();
                                                // } else {
                                                WidgetUtil().paymentDialog(
                                                    img: cList[index]
                                                        .image
                                                        .toString(),
                                                    name: cList[index]
                                                        .name
                                                        .toString(),
                                                    fees: cList[index]
                                                        .discountFee
                                                        .toString(),
                                                    itemId: cList[index]
                                                        .id
                                                        .toString());
                                                // }
                                              },
                                              child: Text(
                                                "Buy Course",
                                                style: AppTheme.ttlWhiteStyl12,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                        ],
                      )),
                );
              },
            ),
          ),
        );
      }
    });
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

  Widget viewCourses() {
    return SliverToBoxAdapter(
      child: Container(
        padding:
            const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "All Courses",
              style: AppTheme.ttlStyl,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }

  Widget views() {
    return FutureBuilder<List<dynamic>>(
      future: Future<List<dynamic>>.value(
        Future.wait([
          app.appController.getMyCourses(),
          app.appController.getAllCourses(),
          app.appController.getSlider(),
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
            myCList = app.appController.myCoursesList;

            cList = app.appController.coursesList
                .where((e) =>
                    e.courseTypeId.toString().contains(typeid.toString()))
                .toList();

            asgnCourseId = app.appController.asgnIdList;

            // cList = cList
            //     .where((course) => !asgnCourseId.contains(course.id))
            //     .toList();

            if (cList == null) {
              return Container();
            } else {
              return Stack(
                fit: StackFit.passthrough,
                children: [
                  CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverPersistentHeader(
                        delegate: SliverSearchAppBar(),
                        pinned: true,
                      ),
                      slider(),
                      viewCourses(),
                      _courseList(),
                    ],
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
