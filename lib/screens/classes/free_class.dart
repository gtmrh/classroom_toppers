import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/widgets/app_logo.dart';

import '../../model/video_model/video_data.dart';
import '../../utils/app_color.dart';
import '../../utils/my_application.dart';
import '../../utils/strings.dart';
import '../../utils/theme.dart';
import '../no_data/course_suggt.dart';

class FreeClass extends StatefulWidget {
  const FreeClass({super.key});

  @override
  State<FreeClass> createState() => _FreeClassState();
}

class _FreeClassState extends State<FreeClass> {
  List<VideoData> courseVideo = [];

  @override
  Widget build(BuildContext context) {
    return view();
  }

  Widget view() {
    return Obx(() {
      var typeid = app.appController.cTypeId.value;
      print("typeid${typeid}");

      List<String> filterCListId = app.appController.coursesList
          .where((e) => e.courseTypeId.toString().contains(typeid.toString()))
          .toList()
          .map((e) => e.id.toString())
          .toList();

      //filter live video as per course type
      courseVideo = app.appController.videosList
          .where((e) =>
              e.access.toString() != 'Paid' &&
              filterCListId.contains(e.courseId.toString()))
          .toList();

      return courseVideo.isEmpty
          ?  Center(child: Text("No Free Classes Available!!", style: AppTheme.ttlStyl,
                textAlign: TextAlign.center,))
          // CourseSuggest(
          //     title: NotVideo,
          //   )
          : CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _videoList(),
                const SliverPadding(padding: EdgeInsets.only(bottom: 50))
              ],
            );
    });
  }

  Widget _videoList() {
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
              margin: const EdgeInsets.only(left: 8, right: 8, top: 5),
              decoration: BoxDecoration(
                  color: appColor.bgColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: appColor.fill,
                          // Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                          // Color.fromARGB(255, 243, 243, 243),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                      child: Stack(
                        children: [
                          Container(
                            child: courseVideo[index].imageLink != null
                                ? ExtendedImage.network(
                                    BASE_URL +
                                        courseVideo[index].imageLink.toString(),
                                    height: 100,
                                    width: 150,
                                    fit: BoxFit.fill,

                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                    // color: Color.fromARGB(255, 228, 218, 255),
                                    colorBlendMode: BlendMode.darken,
                                  )
                                : AppLogo().tinyLogo(),
                          ),
                          const Positioned(
                              right: 50.0,
                              left: 40,
                              top: 40,
                              // bottom: 80,
                              child: Icon(Icons.play_circle))
                        ],
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      const SizedBox(
                        height: 10,
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

  Widget views() {
    return FutureBuilder<List<dynamic>>(
      future: Future<List<dynamic>>.value(
        Future.wait([
          app.appController.getAllVideos(),
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
            courseVideo = app.appController.videosList
                .where((e) => e.access.toString() != 'Paid')
                .toList();

            if (courseVideo == null) {
              return Container();
            } else {
              return courseVideo.isEmpty
                  ? CourseSuggest(
                      title: NotVideo,
                    )
                  : CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        _videoList(),
                        const SliverPadding(
                            padding: EdgeInsets.only(bottom: 50))
                      ],
                    );
            }
          }
        }
      },
    );
  }
}
