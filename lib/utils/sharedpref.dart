// ignore_for_file: prefer_final_fields

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  String _userToken = "UserToken";

  String _id = "Id";

  String _userName = "UserName";

  String _userMob = "UserMob";

  String _userEmail = "UserEmail";

  String _userImg = "UserImg";

  String _userPassword = "UserPas";
  String _userId = "UserId";
  String _userRef = "UserRef";

  String firstStep = "FirstTime";

  String _collegeId = "CollegeId";

  String _clgLogo = "CollegeLogo";

  String aff_no = "aff_no";
  String ins_name = "ins_name";
  String short_name = "short_name";
  String pri_name = "pri_name";
  String dri_name = "dri_name";
  String full_address = "full_address";
  String ins_code = "ins_code";

  String course_id = "courseId";

  String UserType = 'userType';

  String CourseType = 'courseType';

  late SharedPreferences _sharedPreferences;

  getStepsDone() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? logged = _prefs.getString(firstStep);
    return logged;
  }

  setStepsDone(String firstTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(firstStep, firstTime);
  }

  // getLogged() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   bool? logged = _prefs.getBool(firstStep);
  //   return logged;
  // }

  // setLogged(bool firstTime) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool(firstStep, firstTime);
  // }

  getCourseType() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? courseType = _prefs.getString(CourseType);
    return courseType;
  }

  setCourseType(String courseType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(CourseType, courseType);
  }

  getRefId() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? userRef = _prefs.getString(_userRef);
    return userRef;
  }

  setRefId(String userRef) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userRef, userRef);
  }

  getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? userToken = _prefs.getString(_userToken);
    return userToken;
  }

  setToken(String userToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userToken, userToken);
  }

  getId() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? id = _prefs.getString(_id);
    return id;
  }

  setId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(id, id);
  }

  getUserType() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? userType = _prefs.getString(UserType);
    return userType;
  }

  setUserType(String userType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userType, UserType);
  }

  Future<String?> getUserId() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? userId = _prefs.getString(_userId);
    print("SharedPref>>UserId>>" + userId.toString());
    return userId;
  }

  setUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userId, userId);
  }

  Future<String?> getUserName() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? userName = _prefs.getString(_userName);
    return userName;
  }

  setUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userName, userName);
  }

  Future<String?> getUserMob() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? userMob = _prefs.getString(_userMob);
    return userMob;
  }

  setUserMob(String userMob) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userMob, userMob);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? userEmail = _prefs.getString(_userEmail);
    return userEmail;
  }

  setUserEmail(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userEmail, userEmail);
  }

  getUserImg() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? userImg = _prefs.getString(_userImg);
    return userImg;
  }

  setUserImg(String userImg) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userImg, userImg);
  }

  getUserPassword() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? userPassword = _prefs.getString(_userPassword);
    return userPassword;
  }

  setUserPassword(String userPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userPassword, userPassword);
  }

  clearSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  Future<void> clearLog(String keyToKeep) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getKeys().toList();

    for (String key in allKeys) {
      if (key != keyToKeep) {
        await prefs.remove(key);
      }
    }
  }
}
