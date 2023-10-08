// ignore_for_file: prefer_const_constructors, unused_import, prefer_final_fields, unused_field, unused_local_variable, unnecessary_null_comparison, import_of_legacy_library_into_null_safe

import 'dart:async';
import 'dart:convert';
// import 'dart:ffi';
// import 'dart:html';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:in_app_update/in_app_update.dart';
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

class Login extends StatefulWidget {
  static const String idScreen = "login";

  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _idtTxtEditingController;
  late final TextEditingController _passwordtTxtEditingController;
  late bool _passwordVisible;

  var data;

  // final DioClient _client = DioClient();
  // bool isCreating = false;
  // List<ClgListModel> clgList = [];

  var _isNetworkAvail;
  bool boxExist = false;

  TextEditingController controller = TextEditingController();
  final TextEditingController _typeAheadController = TextEditingController();

  var url;

  @override
  void initState() {
    // getClgUrl()
    // if (getClgUrl() = false) {
    // getClgList();
    // }

    // checkAppUpdate();

    _idtTxtEditingController = TextEditingController();
    _passwordtTxtEditingController = TextEditingController();
    _passwordVisible = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: 0,
                // ),

                // Image(
                //   image: AssetImage("assets/images/gyanpeeth_logo.png"),
                //   alignment: AlignmentDirectional.center,
                //   width: 180,
                //   height: 150,
                // ),
                Image(
                  image: AssetImage("assets/images/college.jpg"),
                  alignment: AlignmentDirectional.center,
                ),
                userIdField(),
                SizedBox(height: 10),
                passwordField(),
                SizedBox(height: 10),
                // isCreating ? CircularProgressIndicator() :
                loginBtn(),
                SizedBox(height: 10),
                Text(
                  "Or",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 20),
                // isCreating ? CircularProgressIndicator() :

                // otherLogin(),
                // empLoginBtn(),

                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  userIdField() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextFormField(
          scrollPadding: EdgeInsets.only(bottom: 40),
          controller: _idtTxtEditingController,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.blueAccent,
              ),
              border: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderRadius: BorderRadius.all(Radius.circular(90.0)),
                borderSide: BorderSide.none,
                //borderSide: const BorderSide(),
              ),
              hintStyle: TextStyle(
                  color: Colors.blueAccent, fontFamily: "WorkSansLight"),
              filled: true,
              fillColor: Color.fromARGB(255, 221, 232, 254),
              hintText: 'User Id'),
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }

  passwordField() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextFormField(
          scrollPadding: EdgeInsets.only(bottom: 40),
          controller: _passwordtTxtEditingController,
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.blueAccent,
              ),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  )),
              border: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderRadius: BorderRadius.all(Radius.circular(90.0)),
                borderSide: BorderSide.none,
                //borderSide: const BorderSide(),
              ),
              hintStyle: TextStyle(
                  color: Colors.blueAccent, fontFamily: "WorkSansLight"),
              filled: true,
              fillColor: Color.fromARGB(255, 221, 232, 254),
              hintText: 'Password'),
          textInputAction: TextInputAction.done,
        ),
      ),
    );
  }

  loginBtn() {
    return ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Colors.red)))),
        onPressed: () async {
          // studentLogin();
        },
        child: Text(
          "Student Login",
          style: TextStyle(fontSize: 14),
        ));
  }

  empLoginBtn() {
    return ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Colors.red)))),
        onPressed: () async {
          // empLogin();
        },
        child: Text(
          "Not student?",
          style: TextStyle(fontSize: 14),
        ));
  }
}
