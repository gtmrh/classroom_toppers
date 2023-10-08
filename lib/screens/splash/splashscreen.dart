// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/utils/app_color.dart';
import 'package:classroom_toppers/utils/my_application.dart';
import 'package:classroom_toppers/utils/widget_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/strings.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  late String logo = "";
  late bool logoCheck = false;

  late bool loggedCheck = false;

  late bool isStudent = false;

  @override
  void initState() {
    super.initState();

    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: initScreen(context),
        backgroundColor: appColor.white);
  }

  startTime() async {

    var duration = Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("FirstTime")) {
      if (prefs.containsKey("UserId")) {
        if (prefs.containsKey('courseType')) {
          // app.appController.onInit();
          await app.appController.getData();
          Get.offNamed(HOME_SCREEN, arguments: '0');
        } else {
          Get.toNamed(TYPE_SCREEN);
        }
      } else {
        Get.offNamed(LOGIN_SCREEN);
      }
    } else {
      Get.offNamed(INTRO_SCREEN);
    }
  }

  initScreen(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WidgetUtil().appLogo(),
          SizedBox(
            height: 20,
          ),
          WidgetUtil.loaderSpin()
        ],
      ),
    );
  }
}
