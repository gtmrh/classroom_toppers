import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:classroom_toppers/utils/my_application.dart';
import 'package:classroom_toppers/utils/strings.dart';
import 'package:classroom_toppers/utils/theme.dart';
import 'package:classroom_toppers/widgets/app_logo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/payment_gateway/razorpay_integration.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import 'app_color.dart';
import 'change_password.dart';

class WidgetUtil {
  static WidgetUtil? _instance;

  WidgetUtil._();

  factory WidgetUtil() {
    _instance ??= WidgetUtil._();
    // since you are sure you will return non-null value, add '!' operator
    return _instance!;
  }

  static int rotateH() {
    return 1;
  }

  static Widget loaderSpin() {
    return Center(
      child: SpinKitCircle(
        color: appColor.grey,
        // size: 140,
      ),
    );
  }

  Future<void> preventScreenCapture() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  Future<void> allowScreenCapture() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }

  showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChangePasswordDialog();
      },
    );
  }

  appLogo() {
    return const Image(
      image: AssetImage("assets/images/logo.png"),
      height: 130.0,
      width: 130.0,
      // color: Colors.white,

      alignment: AlignmentDirectional.center,
    );
  }

  appSmallLogo() {
    return const Image(
      image: AssetImage("assets/images/logo.png"),
      height: 100.0,
      width: 100.0,
      // color: Colors.white,

      alignment: AlignmentDirectional.center,
    );
  }

  offPercent(String price, String selling) {
    double off = (double.parse(price) - double.parse(selling)) /
        double.parse(price) *
        100;
    if (off != 0) {
      return "${off.toStringAsFixed(0)}%";
    } else {
      return "";
    }
  }

  closeApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit'),
          content: const Text('Are you sure you want to exit?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future enroll({
    required String img,
    required String name,
    // required String fees,
    required String itemId,
  }) {
    final RazorPayIntegration _integration = RazorPayIntegration();
    _integration.intiateRazorPay();

    return Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: ExtendedImage.network(
                          BASE_URL + img,
                          fit: BoxFit.fitWidth,

                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(2),
                          // color: Color.fromARGB(255, 228, 218, 255),
                          colorBlendMode: BlendMode.darken,
                          // height: 150,
                          // width: 150,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        name,
                        textAlign: TextAlign.center,
                        style: AppTheme.t18Med,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Free",
                        textAlign: TextAlign.start,
                        style: AppTheme.t18Med,
                      ),
                      const SizedBox(height: 20),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
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
                              },
                              child: const Text(
                                'Cancel',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color(0xFFFFFFFF),
                                backgroundColor: Colors.pinkAccent,
                                minimumSize: const Size(0, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {
                                Get.back();
                                await app.appController
                                    .assignCourse(itemId, "0000");

                                // app.appController.onInit();

                                // if (app.appController.verifyPaymentModel!.status == 'success') {

                                // } else {

                                // }

                                // _integration.openSession(
                                //     amount: int.parse(fees),
                                //     orderDesc: name,
                                //     itemId: itemId);
                              },
                              child: Text(
                                "Enroll",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future paymentDialog({
    required String img,
    required String name,
    required String fees,
    required String itemId,
  }) {
    final RazorPayIntegration _integration = RazorPayIntegration();
    _integration.intiateRazorPay();

    return Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: img.isNotEmpty
                            ? ExtendedImage.network(
                                BASE_URL + img,
                                fit: BoxFit.fitWidth,

                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(2),
                                // color: Color.fromARGB(255, 228, 218, 255),
                                colorBlendMode: BlendMode.darken,
                                // height: 150,
                                // width: 150,
                              )
                            : AppLogo().tinyLogo(),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        name,
                        textAlign: TextAlign.center,
                        style: AppTheme.t18Med,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "\u{20B9}$fees",
                        textAlign: TextAlign.start,
                        style: AppTheme.t18Med,
                      ),
                      const SizedBox(height: 20),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
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
                              },
                              child: const Text(
                                'Cancel',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color(0xFFFFFFFF),
                                backgroundColor: Colors.pinkAccent,
                                minimumSize: const Size(0, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                                _integration.openSession(
                                    amount: int.parse(fees.toString()),
                                    orderDesc: name,
                                    itemId: itemId);
                              },
                              child: Text(
                                " Pay  \u{20B9}$fees",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//dateformate
  dateFormate(String inputDate) {
    DateFormat format = DateFormat('yyyy-MM-dd');
    var formatedDate = format.parse(inputDate);
    return DateFormat.MMMEd().format(formatedDate);
  }

  static Widget menuBar() {
    return const Image(
      image: AssetImage(
        "assets/images/menu_bar.png",
      ),
      width: 24,
      height: 24,
    );
  }

  static Widget noDataLottie() {
    return Lottie.asset('assets/images/no_data.json',
        repeat: true, reverse: true, animate: true, height: 100);
  }

  static Widget learningLottie() {
    return Lottie.asset('assets/images/learning.json',
        repeat: true, reverse: true, animate: true, height: 250);
  }

  static Widget qualityLottie() {
    return Lottie.asset('assets/images/online_study.json',
        repeat: true, reverse: true, animate: true, height: 250);
  }

  static Widget freedomLottie() {
    return Lottie.asset('assets/images/studying.json',
        repeat: true, reverse: true, animate: true, height: 250);
  }

  static Widget learnLottie() {
    return Lottie.asset('assets/images/start_learning.json',
        repeat: true, reverse: true, animate: true, height: 200);
  }

  static Widget successLottie() {
    return Lottie.asset(
      'assets/images/success.json',
      repeat: true,
      reverse: true,
      animate: true,
      height: 200,
      // width: 500:
      // width: double.infinity
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: appLogo(),
          title: Text('App Maintenance'),
          content: Text(
              'Thank you for your patience and sorry for the inconvenience caused. We are working to make this app better for your better and more seamless study.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  checkTest(BuildContext context, String test) {
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
              },
              child: const Text(
                'Re-Test',
              ),
            ),
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
                Navigator.of(context).pop();
                Get.toNamed(SCORE_SCREEN_CHECK, arguments: [test]);
              },
              child: const Text(
                'View Result',
              ),
            ),
            // TextButton(
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //     Get.toNamed(SCORE_SCREEN_CHECK, arguments: [test]);
            //   },
            //   child: Text('View Result'),
            // ),
          ],
        );
      },
    );
  }

  testSol(BuildContext context, String qn, String ans) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Html(
            data: qn,
            style: {
              'body': Style(
                  color: appColor.txtTitle,
                  fontFamily: GoogleFonts.rubik().fontFamily,
                  fontSize: FontSize(12),
                  fontWeight: FontWeight.bold),
            },
          ),
          content: Html(
            data: ans,
            style: {
              'body': Style(
                color: appColor.txtTitle,
                fontFamily: GoogleFonts.rubik().fontFamily,
                fontSize: FontSize(12),
              ),
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Get.toNamed(SCORE_SCREEN_CHECK, arguments: [test]);
              },
              child: Text('ok'),
            ),
          ],
        );
      },
    );
  }

  testInfo(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('App Under Maintenance'),
          content: Text(
              'Sorry, the app is currently undergoing maintenance. If you are facing login issue, just try to forget your password from the login screen or Login with the same registered number, that is your password. We will be back from tomorrow'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  joinGroup(String link) async {
    if (link.isNotEmpty) {
      if (await canLaunch(link)) {
        await launch(link);
      } else {
        throw 'Could not launch $link';
      }
    } else {
      Fluttertoast.showToast(
          msg: "Will be available soon please wait",
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  String formatAttemptTime(String attemptTime) {
    final timeComponents = attemptTime.split(':');
    final hours = int.parse(timeComponents[0]);
    final minutes = int.parse(timeComponents[1]);
    final seconds = int.parse(timeComponents[2]);

    if (hours > 0) {
      return '$hours hr';
    } else if (minutes > 0 && seconds > 0) {
      return '$minutes min $seconds sec';
    } else if (minutes > 0) {
      return '$minutes min';
    } else {
      return '$seconds sec';
    }
  }
}
