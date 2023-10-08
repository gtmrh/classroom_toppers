import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/model/study_material_model/study_matrl_data.dart';

import '../../utils/app_color.dart';
import '../../utils/my_application.dart';
import '../../utils/strings.dart';
import '../../utils/theme.dart';

class StudyMaterials extends StatefulWidget {
  const StudyMaterials({super.key});

  @override
  State<StudyMaterials> createState() => _StudyMaterialsState();
}

class _StudyMaterialsState extends State<StudyMaterials> {
  List<StudyMaterialData> studyMatList = [];

  @override
  Widget build(BuildContext context) {
    return view();
  }

  Widget view() {
    return Obx(() {
      studyMatList = app.appController.studyMatList;

      return CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [_pdfList()],
      );
    });
  }

  Widget _pdfList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: studyMatList.length,
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
                      child: ExtendedImage.network(
                        BASE_URL + studyMatList[index].imageLink.toString(),
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
                            padding: const EdgeInsets.only(right: 8, top: 8),
                            child: Text(
                              studyMatList[index].pdfTitle.toString(),
                              style: AppTheme.ttlStyl12B,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Html(data: studyMatList[index].description),
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
                                  studyMatList[index].writerName.toString(),
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
                    //     BASE_URL + studyMatList[index].pdfFile.toString());

                    Get.toNamed(PDF_VIEW_SCREEN,
                        arguments:
                            BASE_URL + studyMatList[index].pdfFile.toString());
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

  Widget views() {
    return FutureBuilder<List<dynamic>>(
      future: Future<List<dynamic>>.value(
        Future.wait([
          app.appController.getStudyMat(),
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
            studyMatList = app.appController.studyMatList;

            if (studyMatList == null) {
              return Container();
            } else {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [_pdfList()],
              );
            }
          }
        }
      },
    );
  }
}
