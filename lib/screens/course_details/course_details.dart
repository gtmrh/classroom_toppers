import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/model/assigned_video_model/asgn_video_data.dart';
import 'package:classroom_toppers/model/course_model/courses_data.dart';
import 'package:classroom_toppers/model/study_material_model/study_matrl_data.dart';
import 'package:classroom_toppers/utils/my_application.dart';
import 'package:classroom_toppers/utils/widget_util.dart';
import 'package:classroom_toppers/widgets/app_logo.dart';

import '../../model/all_test_model/all_test_data.dart';
import '../../utils/app_color.dart';
import '../../utils/strings.dart';
import '../../utils/theme.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({super.key});

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  final ScrollController _scrollController = ScrollController();
  String courseId = Get.arguments.toString();
  CoursesData coursesData = app.appController.coursesList
      .where((e) => e.id == Get.arguments)
      .toList()[0];

  List<AsgnVideoData> courseVideo = [];
  List<AllTestData> courseTests = [];

  // final List<AsgnVideoData> courseVideo = <AsgnVideoData>[].obs;
  List<StudyMaterialData> coursePdf = [];

  List<String?> catId = [];
  List<String?> subCatId = [];

  List<String?> catName = [];
  List<String?> subCatName = [];

  List<AsgnVideoData> videoList = [];
  List<AllTestData> testList = [];

  List<StudyMaterialData> pdfList = [];

  String? _catDropDownValue;
  String? _subCatDropDownValue;

  // String? _catValue = 'Batch';
  // String? _subValue = 'Subject';

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await app.appController.getCourseVideo(courseId);
    await app.appController.getStudyMat();

    videoList = app.appController.myVideoCoursesList;
    testList = app.appController.allTestList;
    pdfList = app.appController.studyMatList;
    // catId =
    //     app.appController.catList.map((e) => e.id.toString()).toSet().toList();
    // subCatId = app.appController.subCatList
    //     .map((e) => e.id.toString())
    //     .toSet()
    //     .toList();
    catId = videoList.map((e) => e.categoryId.toString()).toSet().toList();

    subCatId =
        videoList.map((e) => e.subcategoryId.toString()).toSet().toList();

    _catDropDownValue = catId[0].toString();

    _subCatDropDownValue = subCatId[0].toString();

    filterList(_catDropDownValue.toString(), _subCatDropDownValue.toString());

    setState(() {});
  }

  void filterList(String cat, String subCat) {
    print("cat>> ${cat}subcat>>$subCat");

    courseVideo = videoList.where(
      (x) {
        return x.categoryId.toString() == cat.toString() &&
            x.subcategoryId.toString() == subCat.toString();
      },
    ).toList();

    // courseTests = testList.where(
    //   (x) {
    //     return x.testCategory.toString() == cat.toString() &&
    //         x.subcategoryId.toString() == subCat.toString() &&
    //         x.courseId == coursesData.id;
    //   },
    // ).toList();

    courseTests = testList.where(
      (x) {
        print('>>${x.courseId}>>${coursesData.id}');
        return x.courseId == coursesData.id;
      },
    ).toList();

    coursePdf = pdfList.where(
      (x) {
        return x.courseId.toString() == courseId.toString() &&
            x.categoryId.toString() == cat.toString() &&
            x.subcategoryId.toString() == subCat.toString();
      },
    ).toList();

    print(courseVideo.length);
    // setState(() {});

    if (courseVideo.isEmpty) {
      Fluttertoast.showToast(msg: "No video found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appColor.white,
          // elevation: 0.2,
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
            coursesData.name.toString(),
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
    return NestedScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: filter(),
            ),
            // SliverToBoxAdapter(
            //   child: tablayout(),
            // )
          ];
        },
        body: tablayout()

        // CustomScrollView(
        //   physics: const BouncingScrollPhysics(),
        //   controller: _scrollController,
        //   slivers: [_videoList()],
        // ),
        );
  }

  filter() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DropdownButtonHideUnderline(
              child: DropdownButton(
            hint: Text(
              'Batch',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: catId
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        app.appController.catList
                            .where((e) => e.id.toString() == item)
                            .toList()[0]
                            .name
                            .toString(),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toSet()
                .toList(),
            value: _catDropDownValue,
            onChanged: (Object? value) {
              setState(() {
                _catDropDownValue = value.toString();

                // Reset the subcategory dropdown value to the first subcategory of the newly selected category
                _subCatDropDownValue = subCatId
                    .where((item) =>
                        app.appController.subCatList
                            .firstWhere((e) => e.id.toString() == item)
                            .categoryId ==
                        int.parse(_catDropDownValue!))
                    .toList()
                    .first
                    .toString();

                print(_catDropDownValue);

                filterList(_catDropDownValue.toString(),
                    _subCatDropDownValue.toString());
              });
            },
          )),
          const SizedBox(
            width: 20.0,
          ),
          DropdownButtonHideUnderline(
              child: DropdownButton(
            hint: Text(
              'Subject',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: subCatId
                .where((item) =>
                    app.appController.subCatList
                        .firstWhere((e) => e.id.toString() == item)
                        .categoryId ==
                    int.parse(_catDropDownValue!))
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        app.appController.subCatList
                            .where((e) => e.id.toString() == item)
                            .toList()[0]
                            .name
                            .toString(),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toSet()
                .toList(),
            value: _subCatDropDownValue.toString(),
            onChanged: (Object? value) {
              setState(() {
                _subCatDropDownValue = value.toString();
                // Call the filterList function with the updated values
                filterList(_catDropDownValue.toString(),
                    _subCatDropDownValue.toString());
              });
            },
          )),
        ],
      ),
    );
  }

  Widget tablayout() {
    return SizedBox(
      height: 50,
      child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: _bodyWidegt(),
          )),
    );
  }

  Widget _bodyWidegt() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 30,
          child: TabBar(
              unselectedLabelColor: Colors.redAccent,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.redAccent),
              tabs: [
                Tab(
                  child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.redAccent, width: 1)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("Playlist"),
                    ),
                  ),
                ),
                // Tab(
                //   child: Container(
                //     width: 80,
                //     height: 40,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(50),
                //         border: Border.all(color: Colors.redAccent, width: 1)),
                //     child: const Align(
                //       alignment: Alignment.center,
                //       child: Text("Tests"),
                //     ),
                //   ),
                // ),
                Tab(
                  child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.redAccent, width: 1)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("Pdfs"),
                    ),
                  ),
                ),
              ]),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: TabBarView(children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            slivers: [_videoList()],
          ),
          // CustomScrollView(
          //   physics: const BouncingScrollPhysics(),
          //   controller: _scrollController,
          //   slivers: [_testList()],
          // ),
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            slivers: [_pdfList()],
          ),
        ]))
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

  Widget _videoList() {
    // courseVideo.isEmpty
    //       ? SpinKitCircle(
    //           color: appColor.grey,
    //         )
    //       :
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: courseVideo.length,
        (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                String url = courseVideo[index].videoLink.toString();
                Get.toNamed(VIDEO_SCREEN, arguments: url);
                // getData();
                // scrollToTop();
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin:
                  const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: appColor.bgColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0))),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: appColor.fill,
                          // Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                          // Color.fromARGB(255, 243, 243, 243),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              courseVideo[index].imageLink != null
                                  ? Image.network(
                                      BASE_URL +
                                          courseVideo[index]
                                              .imageLink
                                              .toString(),
                                      height: 100,
                                      width: 100,
                                    )
                                  : AppLogo().tinyLogo(),
                              const Positioned(
                                  right: 50.0,
                                  left: 40,
                                  top: 40,
                                  // bottom: 80,
                                  child: Icon(Icons.play_circle))
                            ],
                          ))),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 30),
                        width: MediaQuery.of(context).size.width - 200,
                        child: Text(
                          courseVideo[index].videoTitle.toString(),
                          style: AppTheme.ttlStyl14,
                          // style: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, color:  ),
                          textAlign: TextAlign.start,
                          maxLines: 5,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        getCatSubCat(index),
                        style: AppTheme.ttlStyl14,
                        // style: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, color:  ),
                        textAlign: TextAlign.start,
                        // maxLines: 5,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _testList() {
    // courseVideo.isEmpty
    //       ? SpinKitCircle(
    //           color: appColor.grey,
    //         )
    //       :
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: courseTests.length,
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
                                    courseTests.contains(
                                            testList[index].courseId.toString())
                                        // testList[index].access != "Free"
                                        ? 'Free'
                                        : "\u{20B9}${testList[index].price}",
                                    // : 'Free',
                                    style: AppTheme.t14B,
                                    textAlign: TextAlign.start,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      // await app.appController.checkTestSts(
                                      //     testList[index].id.toString());

                                      // openTest(index);
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
                                          courseTests.contains(testList[index]
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

    // SliverList(
    //   delegate: SliverChildBuilderDelegate(
    //     childCount: courseVideo.length,
    //     (context, index) {
    //       return InkWell(
    //         onTap: () {
    //           setState(() {
    //             String url = courseVideo[index].videoLink.toString();
    //             Get.toNamed(VIDEO_SCREEN, arguments: url);
    //             // getData();
    //             // scrollToTop();
    //           });
    //         },
    //         child: Container(
    //           width: MediaQuery.of(context).size.width,
    //           margin:
    //               const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
    //           padding: const EdgeInsets.all(10),
    //           decoration: BoxDecoration(
    //               color: appColor.bgColor,
    //               borderRadius: const BorderRadius.all(Radius.circular(10.0))),
    //           child: Row(
    //             // mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               Container(
    //                   decoration: BoxDecoration(
    //                       color: appColor.fill,
    //                       // Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    //                       // Color.fromARGB(255, 243, 243, 243),
    //                       borderRadius:
    //                           const BorderRadius.all(Radius.circular(10.0))),
    //                   child: Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: Stack(
    //                         children: [
    //                           courseVideo[index].imageLink != null
    //                               ? Image.network(
    //                                   BASE_URL +
    //                                       courseVideo[index]
    //                                           .imageLink
    //                                           .toString(),
    //                                   height: 100,
    //                                   width: 100,
    //                                 )
    //                               : AppLogo().tinyLogo(),
    //                           const Positioned(
    //                               right: 50.0,
    //                               left: 40,
    //                               top: 40,
    //                               // bottom: 80,
    //                               child: Icon(Icons.play_circle))
    //                         ],
    //                       )
    //                       // Image.network(
    //                       //   BASE_URL +
    //                       //       app.appController.catList[index].icon.toString(),
    //                       //   // fit: BoxFit.fitWidth,
    //                       //   height: 50,
    //                       //   width: 50,
    //                       // ),
    //                       )),
    //               const SizedBox(
    //                 width: 8,
    //               ),
    //               Column(
    //                 // mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Container(
    //                     padding: const EdgeInsets.only(right: 30),
    //                     width: MediaQuery.of(context).size.width - 200,
    //                     child: Text(
    //                       courseVideo[index].videoTitle.toString(),
    //                       style: AppTheme.ttlStyl14,
    //                       // style: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, color:  ),
    //                       textAlign: TextAlign.start,
    //                       maxLines: 5,
    //                     ),
    //                   ),
    //                   SizedBox(height: 8),
    //                   Text(
    //                     getCatSubCat(index),
    //                     style: AppTheme.ttlStyl14,
    //                     // style: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, color:  ),
    //                     textAlign: TextAlign.start,
    //                     // maxLines: 5,
    //                   ),
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }

  Widget _pdfList() {
    return coursePdf.isEmpty
        ? SliverToBoxAdapter(
            child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: WidgetUtil.noDataLottie(),
          ))
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: coursePdf.length,
              (context, index) {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 8, right: 8, top: 10, bottom: 5),
                      // padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: appColor.bgColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
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
                            child: ExtendedImage.network(
                              BASE_URL + coursePdf[index].imageLink.toString(),
                              // height: 100,
                              // width: 100,
                              fit: BoxFit.fill,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
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
                                  padding:
                                      const EdgeInsets.only(right: 8, top: 8),
                                  child: Text(
                                    coursePdf[index].pdfTitle.toString(),
                                    style: AppTheme.ttlStyl12B,
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Html(data: coursePdf[index].description),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(
                                    right: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        size: 15,
                                        color: appColor.black,
                                      ),
                                      Text(
                                        coursePdf[index].writerName.toString(),
                                        style: AppTheme.ttlStyl14,
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () async {
                          // final file = await app.appController.loadPdfFromNetwork(
                          //     BASE_URL + coursePdf[index].pdfFile.toString());

                          Get.toNamed(PDF_VIEW_SCREEN,
                              arguments: BASE_URL +
                                  coursePdf[index].pdfFile.toString());
                        },
                        child: Icon(
                          Icons.download,
                          // size: 15,
                          color: appColor.black,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
  }

  getCatSubCat(index) {
    String cat = app.appController.catList
        .where((e) => e.id == courseVideo[index].categoryId)
        .toList()[0]
        .name
        .toString();
    print("cat>>$cat");
    String subCat = app.appController.subCatList
        .where((e) => e.id == courseVideo[index].subcategoryId)
        .toList()[0]
        .name
        .toString();
    print("subcat>>$subCat");

    return '$cat\n$subCat';
  }
}
