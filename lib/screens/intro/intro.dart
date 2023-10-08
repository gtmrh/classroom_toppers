import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_color.dart';
import '../../utils/sharedpref.dart';
import '../../utils/strings.dart';
import '../../utils/theme.dart';
import '../../utils/widget_util.dart';
import '../../widgets/app_logo.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final _pageController = PageController();
  String pageIndex = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          print("value$value");
          setState(() {
            pageIndex = value.toString();
          });
        },
        children: <Widget>[
          _buildIntroScreen(context, appColor.bgWhite, title1, subtitle1,
              AppLogo().smallLogo()),
          _buildIntroScreen(
            context,
            appColor.bgWhite,
            title2,
            subtitle2,
            WidgetUtil.qualityLottie(),
          ),
          _buildIntroScreen(
            context,
            appColor.bgWhite,
            title3,
            subtitle3,
            WidgetUtil.learningLottie(),
          ),
          _buildIntroScreen(
            context,
            appColor.bgWhite,
            title4,
            subtitle4,
            WidgetUtil.freedomLottie(),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroScreen(BuildContext context, Color bg, String title,
      String description, Widget icon) {
    return Container(
      // width: double.infinity,
      // height: double.infinity,
      padding: EdgeInsets.all(8),
      color: bg,
      // alignment: Alignment.center,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretc,
          children: <Widget>[
            const SizedBox(height: 100.0),
            icon,
            const SizedBox(height: 24.0),
            Text(
              title,
              style: AppTheme.mainTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            Text(
              description,
              style: AppTheme.subTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: Container(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _skipNextBtn(),
              // _buildNextButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
          );
        },
        child: const Text("Next"));
  }

  Widget _skipNextBtn() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          pageIndex.toString().contains("3")
              ? const SizedBox(
                  width: 1,
                )
              : InkWell(
                  child: Text(
                    "Skip",
                    style: AppTheme.subTitle,
                  ),
                  onTap: () async {
                    await SharedPref().setStepsDone('true');
                    Get.toNamed(LOGIN_SCREEN);
                  },
                ),
          InkWell(
            onTap: () {},
            child: pageIndex.toString().contains("3")
                ? InkWell(
                    child: Text(
                      "Start",
                      style: AppTheme.subTitle,
                    ),
                    onTap: () async {
                      await SharedPref().setStepsDone('true');
                      Get.toNamed(LOGIN_SCREEN);
                    },
                  )
                : InkWell(
                    child: Text(
                      "Next",
                      style: AppTheme.subTitle,
                    ),
                    onTap: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutCubic,
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
