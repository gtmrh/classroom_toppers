import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/utils/widget_util.dart';

import '../../model/assigned_video_model/asgn_video_data.dart';
import '../../model/course_model/courses_data.dart';
import '../../utils/app_color.dart';
import '../../utils/my_application.dart';
import '../../utils/strings.dart';
import '../../utils/theme.dart';
import '../../widgets/app_logo.dart';
import '../payment_gateway/razorpay_integration.dart';

class PaidCourses extends StatefulWidget {
  const PaidCourses({Key? key}) : super(key: key);

  @override
  State<PaidCourses> createState() => _PaidCoursesState();
}

class _PaidCoursesState extends State<PaidCourses> {
  final RazorPayIntegration _integration = RazorPayIntegration();

  final ScrollController _scrollController = ScrollController();
  String id = Get.arguments.toString();
  CoursesData coursesData = app.appController.coursesList
      .where((e) => e.id == Get.arguments)
      .toList()[0];

  List<AsgnVideoData> courseVideo = [];

  // late YoutubePlayerController _ytbPlayerController;

  @override
  void initState() {
    getData();
    _integration.intiateRazorPay();

    super.initState();
  }

  getData() async {
    print(">>>>$id");
    await app.appController.getCourseVideo(id);
    courseVideo = app.appController.myVideoCoursesList;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appColor.white,
          elevation: 1,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: appColor.black,
              size: 20,
            ),
          ),
          title: Text(
            "Course Details",
            style: AppTheme.ttlStyl,
            textAlign: TextAlign.start,
          ),
          centerTitle: true,
        ),
        backgroundColor: appColor.white,
        body: _view(),
      ),
    );
  }

  Widget _view() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      slivers: [
        _courseImg(),
        _courseName(),
        _courseDetails(),
        _buyNowBtn(),
        _playlistTxt(),
        _videoList()
      ],
    );
  }

  Widget _courseImg() {
    return SliverToBoxAdapter(
      child: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: ExtendedImage.network(
          BASE_URL + coursesData.image.toString(),
          fit: BoxFit.fitWidth,

          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(2),
          // color: Color.fromARGB(255, 228, 218, 255),
          colorBlendMode: BlendMode.darken,
          // height: 150,
          // width: 150,
        ),
      ),
    );
  }

  Widget _courseName() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  coursesData.name.toString(),
                  style: AppTheme.ttlStyl,
                  // style: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, color:  ),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                ),
                SizedBox(
                  // height: 30,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        coursesData.courseFee != coursesData.discountFee
                            ? Text(
                                "\u{20B9}${coursesData.courseFee}",
                                style: AppTheme.priceStrike,
                                textAlign: TextAlign.start,
                              )
                            : Container(),
                        Text(
                          "  \u{20B9}${coursesData.discountFee}",
                          style: AppTheme.t18Med,
                          textAlign: TextAlign.start,
                        )
                      ]),
                ),
              ],
            ),
            Text(
              WidgetUtil().offPercent(coursesData.courseFee.toString(),
                  coursesData.discountFee.toString()),
              style: AppTheme.offerStyl,
            )
          ],
        ),
      ),
    );
  }

  Widget _courseDetails() {
    return SliverToBoxAdapter(
      child: Container(
        // margin: const EdgeInsets.only(top: 20),
        child: Html(
          data: coursesData.description.toString(),
        ),
        // Text(

        //   coursesData.description.toString(),
        //   style: AppTheme.hinttxt,
        // ),
      ),
    );
  }

  Widget _buyNowBtn() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        // margin: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                // paymentDialog();

                WidgetUtil().paymentDialog(
                    img: coursesData.image.toString(),
                    name: coursesData.name.toString(),
                    fees: coursesData.discountFee.toString(),
                    itemId: coursesData.id.toString());
              },
              child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                      color: appColor.btn),
                  child: Text(
                    "Buy Now",
                    style: AppTheme.txtWhite,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _playlistTxt() {
    return SliverToBoxAdapter(
      child: Container(
        padding:
            const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Course Playlist",
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

  Widget _videoList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                WidgetUtil().paymentDialog(
                    img: coursesData.image.toString(),
                    name: coursesData.name.toString(),
                    fees: coursesData.discountFee.toString(),
                    itemId: coursesData.id.toString());
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin:
                  const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: appColor.bgColor,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 130,
                    decoration: BoxDecoration(
                      color: appColor.fill,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Stack(
                      children: [
                        courseVideo[index].imageLink != null
                            ? ExtendedImage.network(
                                BASE_URL +
                                    courseVideo[index].imageLink.toString(),
                                fit: BoxFit.fill,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                              )
                            : AppLogo().tinyLogo(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(right: 8, top: 8),
                          child: Text(
                            courseVideo[index].videoTitle.toString(),
                            style: AppTheme.ttlStyl12B,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: courseVideo.length,
      ),
    );
  }
}
