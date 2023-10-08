import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/model/book_list_model/book_list_data.dart';
import 'package:classroom_toppers/utils/widget_util.dart';

import '../../utils/app_color.dart';
import '../../utils/my_application.dart';
import '../../utils/strings.dart';
import '../../utils/theme.dart';

class Books extends StatefulWidget {
  const Books({super.key});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  List<BookListData> bookList = [];

  @override
  Widget build(BuildContext context) {
    return view();
  }

  Widget view() {
    return Obx(() {
      bookList = app.appController.bookList;

      return CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [_pdfList()],
      );
    });
  }

  Widget _pdfList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: bookList.length,
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
                        BASE_URL + bookList[index].imageLink.toString(),
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
                            padding: const EdgeInsets.only(right: 8, top: 8),
                            child: Text(
                              bookList[index].bookTitle.toString(),
                              style: AppTheme.ttlStyl12B,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Html(data: bookList[index].description),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(
                              right: 8,
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  bookList[index].bookPrice !=
                                          bookList[index].bookSalePrice
                                      ? Text(
                                          "\u{20B9}${bookList[index].bookPrice}",
                                          style: AppTheme.priceStrike,
                                          textAlign: TextAlign.start,
                                        )
                                      : Container(),
                                  Text(
                                    "  \u{20B9}${bookList[index].bookSalePrice}",
                                    style: AppTheme.t18Med,
                                    textAlign: TextAlign.start,
                                  ),
                                  // SizedBox(
                                  //   width: 5,
                                  // ),

                                  InkWell(
                                    onTap: () {
                                      WidgetUtil().paymentDialog(
                                          img: bookList[index]
                                              .imageLink
                                              .toString(),
                                          name: bookList[index]
                                              .bookTitle
                                              .toString(),
                                          fees: bookList[index]
                                              .bookSalePrice
                                              .toString(),
                                          itemId:
                                              bookList[index].id.toString());
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
                                          "Buy Now",
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
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 5, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          // bottomLeft: Radius.circular(100)
                        ),
                        shape: BoxShape.rectangle,
                        color: appColor.settingIcon),
                    child: Text(
                      offPercent(index),
                      style: AppTheme.offerStylSmall,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  offPercent(int index) {
    double off = (double.parse(bookList[index].bookPrice.toString()) -
            double.parse(bookList[index].bookSalePrice.toString())) /
        double.parse(bookList[index].bookPrice.toString()) *
        100;
    if (off != 0) {
      return "${off.toStringAsFixed(0)}% \n off";
    } else {
      return "";
    }
  }

  Widget views() {
    return FutureBuilder<List<dynamic>>(
      future: Future<List<dynamic>>.value(
        Future.wait([
          app.appController.getBooks(),
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
            bookList = app.appController.bookList;

            if (bookList == null) {
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
