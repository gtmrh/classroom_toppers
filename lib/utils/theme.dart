// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class AppTheme {
  AppTheme._();

  static final Color _iconColor = Colors.blueAccent.shade200;
  static const Color _lightPrimaryColor = Color(0xFF546E7A);
  static const Color _lightPrimaryVariantColor = Colors.white;
  static const Color _lightSecondaryColor = Colors.green;
  static const Color _lightOnPrimaryColor = Colors.black;

  static const Color _darkPrimaryColor = Colors.white24;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static const Color _darkSecondaryColor = Colors.white;
  static const Color _darkOnPrimaryColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
            color: _darkSecondaryColor,
            fontFamily: GoogleFonts.rubik().fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 24),
        color: _lightPrimaryVariantColor,
        iconTheme: IconThemeData(color: _lightOnPrimaryColor),
      ),
      colorScheme: ColorScheme.light(
        primary: _lightPrimaryColor,
        secondary: _lightSecondaryColor,
        onPrimary: _lightOnPrimaryColor,
      ),
      iconTheme: IconThemeData(
        color: _iconColor,
      ),
      textTheme: _lightTextTheme,
      dividerTheme: DividerThemeData(color: Colors.black12));

  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: _darkPrimaryVariantColor,
      appBarTheme: AppBarTheme(
        color: _darkPrimaryVariantColor,
        iconTheme: IconThemeData(color: _darkOnPrimaryColor),
      ),
      colorScheme: ColorScheme.dark(
        primary: _darkPrimaryColor,
        secondary: _darkSecondaryColor,
        onPrimary: _darkOnPrimaryColor,
        background: Colors.white12,
      ),
      iconTheme: IconThemeData(
        color: _iconColor,
      ),
      textTheme: _darkTextTheme,
      dividerTheme: DividerThemeData(color: Colors.black));

  static final TextTheme _lightTextTheme = TextTheme(
    headline1: _lightScreenHeading1TextStyle,
    headline2: _noteTextStyle,
  );

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: _darkScreenHeading1TextStyle,
  );

  static final TextStyle mainTitle = TextStyle(
      color: appColor.txtTitle,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 26,
      fontWeight: FontWeight.bold);

  // static final ButtonStyle _alertBtn = ButtonStyle(

  // );

  static final TextStyle title20 = TextStyle(
      color: appColor.txtTitle,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.bold);

  static final TextStyle subTitle = TextStyle(
      color: appColor.txtSubTitle,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w800);

  static final TextStyle txtWhite = TextStyle(
      color: appColor.white,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w800);

  static final TextStyle ulTxt = TextStyle(
      color: appColor.txtSubTitle,
      decoration: TextDecoration.underline,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w800);

  static final TextStyle fieldTxt = TextStyle(
      color: appColor.fieldClr,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w800);

  static final TextStyle ttlStyl = TextStyle(
      color: appColor.txtTitle,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w800);

  static final TextStyle btmUnselected = TextStyle(
    color: appColor.txtTitle,
    fontFamily: GoogleFonts.rubik().fontFamily,
    fontSize: 10,
  );

  static final TextStyle btmSelected = TextStyle(
    color: appColor.txtTitle,
    fontFamily: GoogleFonts.rubik().fontFamily,
    fontSize: 12,
  );

  static final TextStyle ttlStyl12B = TextStyle(
      color: appColor.txtTitle,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w800);

  static final TextStyle ttlStyl14 = TextStyle(
    color: appColor.txtTitle,
    fontFamily: GoogleFonts.rubik().fontFamily,
    fontSize: 14,
  );

  static final TextStyle ttlStyl14B = TextStyle(
      color: appColor.txtTitle,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w800);

  static final TextStyle ttlStyl12 = TextStyle(
    color: appColor.txtTitle,
    fontFamily: GoogleFonts.rubik().fontFamily,
    fontSize: 12,
  );

  static final TextStyle ttlStyl14C = TextStyle(
      color: appColor.greyDark,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w800);

  static final TextStyle t24 = TextStyle(
      color: appColor.greyDark,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w800);

  static final TextStyle ttlWhiteStyl14 = TextStyle(
      color: appColor.white,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w800);

  static final TextStyle ttlWhiteStyl12 = TextStyle(
      color: appColor.white,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w800);

  static final TextStyle ttlWhitel10 = TextStyle(
    color: appColor.white,
    fontFamily: GoogleFonts.rubik().fontFamily,
    fontSize: 10,
    // fontWeight: FontWeight.w800
  );

  static final TextStyle ttlWhiteStyl20 = TextStyle(
      color: appColor.white,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w800);

  static final TextStyle ttlStylStrike = TextStyle(
      color: appColor.greyDark,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 14,
      decoration: TextDecoration.lineThrough,
      fontWeight: FontWeight.w800);

  static final TextStyle priceStrike = TextStyle(
      color: appColor.txtTitle,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 18,
      decoration: TextDecoration.lineThrough,
      fontWeight: FontWeight.w400);

  static final TextStyle t18Med = TextStyle(
      color: appColor.txtTitle,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w500);

  static final TextStyle priceTtl = TextStyle(
      color: appColor.notifIcon,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w500);

  static final TextStyle hinttxt = TextStyle(
      color: appColor.txtTitle,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 12,
      height: 1.5,
      fontWeight: FontWeight.w800);

  static final TextStyle userMob = TextStyle(
    color: Colors.white,
    fontFamily: GoogleFonts.rubik().fontFamily,
    fontSize: 14,
  );

  static final TextStyle userName = TextStyle(
    color: Colors.white,
    fontFamily: GoogleFonts.rubik().fontFamily,
    fontSize: 18,
  );

  static final TextStyle t16N = TextStyle(
    color: appColor.black,
    fontFamily: GoogleFonts.rubik().fontFamily,
    fontSize: 16,
  );

  static final TextStyle t14B = TextStyle(
      color: appColor.black,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w800);

  static final TextStyle _lightScreenHeading1TextStyle = TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.bold,
    color: _lightOnPrimaryColor,
    fontFamily: GoogleFonts.rubik().fontFamily,
  );

  static final TextStyle offerStyl = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w800,
    color: appColor.btn,
    fontFamily: GoogleFonts.rubik().fontFamily,
  );

  static final TextStyle offerStylSmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w800,
    color: appColor.white,
    fontFamily: GoogleFonts.rubik().fontFamily,
  );

  static final TextStyle _noteTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: _lightOnPrimaryColor,
    fontFamily: GoogleFonts.rubik().fontFamily,
  );

  static final TextStyle greenText = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: appColor.btn,
    fontFamily: GoogleFonts.rubik().fontFamily,
  );

  static final TextStyle _darkScreenHeading1TextStyle =
      _lightScreenHeading1TextStyle.copyWith(color: _darkOnPrimaryColor);
}
