import 'dart:math';

import 'package:flutter/material.dart';

AppColor appColor = AppColor();

class AppColor {
  static final AppColor _appColor = AppColor._i();

  factory AppColor() {
    return _appColor;
  }

  AppColor._i();

  final Color bgclr = Color(0xFFF7F8FA);
  final Color main = const Color(0xFF5297F4);
  final Color primaryColor = const Color(0xFF5297F4);
  final Color primaryDarkColor = const Color(0xFF5297F4);
  final Color primaryLightColor = const Color(0xFF5297F4);
  final Color primaryLight = const Color(0xFF5297F4);
  final Color accentColor = const Color(0xff39446F);
  final Color greyBg = const Color(0xffD8D8D8);

  final Color bg = const Color(0xffF5F6FB);
  final Color pageBg = const Color.fromARGB(255, 250, 250, 250);

  final Color yellow = const Color.fromARGB(255, 255, 231, 15);

  final Color bgColor = const Color(0xFFEAF1FF);

  final Color bgWhite = const Color(0xffFFFFFF);
  final Color txtTitle = const Color(0xff212121);
  final Color txtSubTitle = const Color(0xff969696);
  final Color fieldClr = Colors.black38;
  final Color fill = const Color(0xffF8F8F8);
  final Color bgGreenLight = const Color(0xffE5FCE3);

  final Color btn = const Color(0xff00B761);

  final Color white = Colors.white;
  final Color black = Colors.black;
  final Color transparent = Colors.transparent;

  final Color grey = const Color(0xff898989);
  final Color greyDark = const Color(0xFF424242);
  final Color greyLight = const Color(0xff898989);
  // final Color pink = const Color(0xFFFF4081);
  final Color btnClr = const Color(0xFFED1B24);

  final Color pinkLight = Color.fromARGB(255, 255, 244, 248);

  final Color notWhite = const Color(0xFFEDF0F2);
  final Color notWhite2 = const Color(0xFFF6F6F6);
  final Color nearlyWhite = const Color(0xFFFEFEFE);
  final Color loader = const Color.fromARGB(255, 66, 162, 27);

  final Color locBg = const Color(0xffFEFFE2);
  final Color locIcon = const Color(0xffFFDD44);

  final Color vochBg = const Color(0xffFFEEEA);
  final Color vochIcon = const Color(0xffFE3000);

  final Color walletBg = const Color(0xffFEE2FF);
  final Color walletIcon = const Color(0xffF600FF);

  final Color notifBg = const Color(0xffE5FCE3);
  final Color notifIcon = const Color(0xff00B761);

  final Color settingBg = const Color(0xffFFEDE2);
  final Color settingIcon = const Color(0xffFF5C00);

  final Color logBg = const Color(0xffE2F6FF);
  final Color logIcon = const Color(0xff00B0FF);

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Color generateRandomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];

    Random random = Random();
    return Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}
