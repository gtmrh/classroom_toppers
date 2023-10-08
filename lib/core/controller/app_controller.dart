import 'dart:async';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/model/all_test_model/all_test_data.dart';
import 'package:classroom_toppers/model/assigned_course_model/asgn_course_data.dart';
import 'package:classroom_toppers/model/assigned_video_model/asgn_video_data.dart';
import 'package:classroom_toppers/model/banner_model/banner_data.dart';
import 'package:classroom_toppers/model/book_list_model/book_list_data.dart';
import 'package:classroom_toppers/model/cat_model/cat_data.dart';
import 'package:classroom_toppers/model/chat_list_model/chat_list_data.dart';
import 'package:classroom_toppers/model/course_model/courses_data.dart';
import 'package:classroom_toppers/model/live_user_count_model.dart';
import 'package:classroom_toppers/model/login_model/login_model.dart';
import 'package:classroom_toppers/model/news_model/news_data.dart';
import 'package:classroom_toppers/model/study_material_model/study_matrl_data.dart';
import 'package:classroom_toppers/model/sub_cat_model/sub_cat_data.dart';
import 'package:classroom_toppers/model/test_quest_model/test_quest_model.dart';
import 'package:classroom_toppers/model/video_model/video_data.dart';
import 'package:classroom_toppers/screens/chat/chat_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/change_pass_model.dart';
import '../../model/chat_create_model/chat_create_model.dart';
import '../../model/chat_list_model/chat_list_model.dart';
import '../../model/check_test_sts_model/check_test_sts_model.dart';
import '../../model/course_purchs_model/course_purchs_model.dart';
import '../../model/course_type_model/course_type_data.dart';
import '../../model/signup_model/signup_model.dart';
import '../../model/test_result_model/test_result_model.dart';
import '../../model/test_sol_model/test_sol_data.dart';
import '../../model/verify_payment_model/verify_payment_model.dart';
import '../../utils/log_util.dart';
import '../../utils/sharedpref.dart';
import '../../utils/strings.dart';
import '../repo/api_repository.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

const title = "AppController";

class AppController extends GetxController {
  var isLoadingCourse = true.obs;

  Map<String, int> selectedAnswers = Map();

  Map<String, int> correctAnswers = Map();

  final _catList = <CatData>[].obs;
  List<CatData> get catList => _catList;

  final _studyMatList = <StudyMaterialData>[].obs;
  List<StudyMaterialData> get studyMatList => _studyMatList;

  final _bookList = <BookListData>[].obs;
  List<BookListData> get bookList => _bookList;

  final _newsList = <NewsData>[].obs;
  List<NewsData> get newsList => _newsList;

  final _subCatList = <SubCatData>[].obs;
  List<SubCatData> get subCatList => _subCatList;

  final _coursesType = <CourseTypeData>[].obs;
  List<CourseTypeData> get coursesType => _coursesType;

  final _coursesList = <CoursesData>[].obs;
  List<CoursesData> get coursesList => _coursesList;

  final _coursesIdList = <String>[].obs;
  List<String> get coursesIdList => _coursesIdList;

  final _videosList = <VideoData>[].obs;
  List<VideoData> get videosList => _videosList;

  final _livevideosList = <VideoData>[].obs;
  List<VideoData> get livevideosList => _livevideosList;

  final _myCoursesList = <AsgnCourseData>[].obs;
  List<AsgnCourseData> get myCoursesList => _myCoursesList;

  final _myVideoCoursesList = <AsgnVideoData>[].obs;
  List<AsgnVideoData> get myVideoCoursesList => _myVideoCoursesList;

  final _allTestList = <AllTestData>[].obs;
  List<AllTestData> get allTestList => _allTestList;

  final _asgnIdList = <String>[].obs;
  List<String> get asgnIdList => _asgnIdList;

  final _sliderList = <BannerData>[].obs;
  List<BannerData> get sliderList => _sliderList;

  final _testSolList = <TestSolData>[].obs;
  List<TestSolData> get testSolList => _testSolList;

  final _chatListData = <ChatListData>[].obs;
  List<ChatListData> get chatListData => _chatListData;

  late LoginModel? loginData;
  late TestQuestModel? testQues;
  
  late SignupModel? signupData;
  late TestQuestModel? testQuestModel;
  late ChatCreateModel? chatCreateModel;
  late LiveUserCountModel? liveUserCountModel;
  late TestResultModel testResultModel;
  late CheckTestStsModel checkTestStstModel;

  late ChatListModel? chatListModel;
  late CoursePurchsModel? coursePurchsModel;
  late VerifyPaymentModel? verifyPaymentModel;
  late ChangePassModel? changePassModel;
  RxString name = ''.obs;
  RxString cTypeId = ''.obs;
  late Timer _timer = Timer(Duration.zero, () {});

  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("UserId")) {
      getData();
      getCourseType();
      getSlider();
      getAllCourses();
      getMyCourses();
      getCat();
      getSubCat();
      getAllTests();
      getAllVideos();
      getLiveVideos();
      getBooks();
      getStudyMat();
      getNews();
    }
    Log.loga(title, "onInit:: >>>>>>> ");
    super.onInit();

    getCourseType();
  }

  getData() async {
    var userName = await SharedPref().getUserName();
    name.value = userName.toString();
    var typeId = await SharedPref().getCourseType();
    cTypeId.value = typeId.toString();
    print("cTypeId${cTypeId.value}>>name${name.value}");
  }

  @override
  void dispose() {
    AppController().dispose();
    super.dispose();
  }

  userSignup(String name, String email, String mobile, String password) async {
    // String city = await getCity();
    try {
      final result =
          await ApiRepo().userReg(name, email, mobile, password, "city");
      Log.loga(title, "signup:: result >>>>> ${result!}");
      signupData = result;

      if (result.token!.isNotEmpty) {
        await SharedPref().setUserId(signupData!.data!.id.toString());
        await SharedPref().setUserName(signupData!.data!.name.toString());
        await SharedPref().setUserMob(signupData!.data!.mobile.toString());
        await SharedPref().setUserEmail(signupData!.data!.email.toString());
        await SharedPref().setToken(signupData!.token.toString());

        onInit();

        if (coursesType.isNotEmpty) {
          Get.toNamed(TYPE_SCREEN);
          Fluttertoast.showToast(
              msg: "Welcome ${signupData!.data!.name} to MISSION");
        }

        return signupData;
      } else {
        signupData = null;

        Fluttertoast.showToast(msg: "Something went wrong! try again");
      }
    } catch (e) {
      Log.loga(title, "Signup:: e >>>>> $e");
    }
  }

  userLogin(String mobile, String password) async {
    try {
      final result = await ApiRepo().login(mobile, password);
      Log.loga(title, "login:: result >>>>> ${result!}");

      if (result.token != null) {
        loginData = result;

        await SharedPref().setUserId(loginData!.data!.id.toString());
        await SharedPref().setUserName(loginData!.data!.name.toString());
        await SharedPref().setUserMob(loginData!.data!.mobile.toString());
        await SharedPref().setUserEmail(loginData!.data!.email.toString());
        await SharedPref().setToken(loginData!.token.toString());

        onInit();

        Get.toNamed(TYPE_SCREEN);

        // Get.toNamed(HOME_SCREEN);

        Fluttertoast.showToast(msg: "Welcome ${loginData!.data!.name} to MISSION");

        return loginData;
      } else {
        loginData = null;
        Fluttertoast.showToast(msg: "Check mobile no. and password");
      }
    } catch (e) {
      Log.loga(title, "Login:: e >>>>> $e");
    }
  }

  getStudyMat() async {
    try {
      final result = await ApiRepo().getStudyMat();
      Log.loga(title, "getStudyMat:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        
        _studyMatList.value = result.data!;
        update();
        print(">>getStudyMat>>>${_catList.value}");
      
      } else {

      }
    } catch (e) {
      Log.loga(title, "getStudyMat:: e >>>>> $e");
      
    }
  }

  getBooks() async {
    try {
      final result = await ApiRepo().getBooks();
      Log.loga(title, "getBooks:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        _bookList.value = result.data!;

        update();

        print(">>getBooks>>>${_catList.value}");
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "getBooks:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  getNews() async {
    try {
      final result = await ApiRepo().getNews();
      Log.loga(title, "getNews:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        _newsList.value = result.data!;

        update();

        print(">>getNews>>>${_newsList.value}");
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "getNews:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  getCat() async {
    try {
      final result = await ApiRepo().getCategory();
      Log.loga(title, "getCat:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        _catList.value = result.data!;

        update();

        print(">>catName>>>${result.data![0].name}");

        print(">>catList>>>${_catList.value}");
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "catList:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  getSubCat() async {
    try {
      final result = await ApiRepo().getSubCategory();
      Log.loga(title, "getSubCat:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        _subCatList.value = result.data!;
        update();
        print(">>_subCatList>>>${_catList.value}");
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "_subCatList:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  getCourseType() async {
    isLoadingCourse.value = true;
    try {
      final result = await ApiRepo().getCourseType();
      Log.loga(title, "getCourseType:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        _coursesType.value = result.data!;
        isLoadingCourse.value = false;
        update();
        print(">>getCourseType>>>${_coursesType.value}");
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "getCourseType:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  getAllCourses() async {
    try {
      final result = await ApiRepo().getAllCourses();
      Log.loga(title, "getCourses:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        _coursesList.value = result.data!;
        _coursesIdList.value =
            _coursesList.map((e) => e.id.toString()).toList();
        // where((element) )
        // asgnIdList.map((element) => element != e.id.toString())).toList();
        update();
        print(">>course>>>${_coursesList.value}");
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "getAllCourses:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  getAllVideos() async {
    try {
      final result = await ApiRepo().getAllVideos();
      Log.loga(title, "videos:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        _videosList.value = result.data!;
        update();
        print(">>videos>>>${_coursesList.value}");
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "getAllVideos:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  getLiveVideos() async {
    try {
      final result = await ApiRepo().getLiveVideos();
      Log.loga(title, "getLiveVideos:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        _livevideosList.value = result.data!;
        update();
        print(">>getLiveVideos>>>${_coursesList.value}");
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "getLiveVideos:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  getLiveVideosByCourse() async {
    try {
      final result = await ApiRepo().getLiveVideosByCourse();
      Log.loga(title, "getLiveVideos:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        _livevideosList.value = result.data!;
        update();
        print(">>getLiveVideos>>>${_coursesList.value}");
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "getLiveVideos:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  getMyCourses() async {
    try {
      final result = await ApiRepo().getMyCourses();
      Log.loga(title, "getMyCourses:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        _myCoursesList.value = result.data!
            .where((e) => _coursesIdList.contains(e.courseId.toString()))
            .toList();
        _asgnIdList.value =
            _myCoursesList.map((e) => e.courseId.toString()).toList();
        update();
        print("assigned id>> ${_asgnIdList.value}");

        print(">>mycourse>>>${_coursesList.value}");
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "getProducts:: e >>>>> $e");
    }
  }

  getCourseVideo(String id) async {
    try {
      final result = await ApiRepo().getCourseVideo(id);
      Log.loga(title, "getCat:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        _myVideoCoursesList.value = result.data!;
        update();
        print(">>mycourse>>>${_coursesList.value}");
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "getProducts:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  assignCourse(String courseId, String payment_id) async {
    try {
      final result = await ApiRepo().assignCourse(courseId);
      Log.loga(title, "assignCourse:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        coursePurchsModel = result;
        await verifyPyment(coursePurchsModel!.data!.id.toString(), "paid");
        update();
        print(">>assignCourse>>>${_coursesList.value}");
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "assignCourse:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  verifyPyment(
    String payment_id,
    String payment_status,
  ) async {
    try {
      final result = await ApiRepo().verifyPyment(payment_id, payment_status);
      Log.loga(title, "verifyPyment:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        verifyPaymentModel = result;

        //refresh app data
        onInit();

        Fluttertoast.showToast(msg: "Course Assigned");
        update();
        print(">>verifyPyment>>>${_coursesList.value}");
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "verifyPyment:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  createChat(String videoId, String msg) async {
    try {
      final result = await ApiRepo().createChat(videoId, msg);
      Log.loga(title, "createChat:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        chatCreateModel = result;
        update();
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "createChat:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  liveUserCount(String videoId, String type) async {
    try {
      final result = await ApiRepo().liveUserCount(videoId, type);
      Log.loga(title, "createChat:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        liveUserCountModel = result;
        update();
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "createChat:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  loadMsg(String videoId, String action) {
    if (action.toLowerCase() == 'start') {
      // Start the timer only if it's not already active
      _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
        await getChatList(videoId);
      });
      _timer.tick;
    } else if (action.toLowerCase() != 'start') {
      _timer.cancel();
    }
  }

  getChatList(String videoId) async {
    try {
      final result = await ApiRepo().getChatList(
        videoId,
      );
      Log.loga(title, "createChat:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        //chat list of user by userid
        _chatListData.value = result.data!;
        // .where((e) =>
        //     e.videoId.toString() == videoId &&
        //     e.userId.toString() == userId.toString())
        // .toList();
        update();
      } else {}
    } catch (e) {
      Log.loga(title, "createChat:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  getOtp(String emailId) async {
    try {
      final result = await ApiRepo().getOtp(
        emailId,
      );
      Log.loga(title, "getOtp:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        chatListModel = result;
        update();
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "getOtp:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  changePass(String emailId, String otp, String pass) async {
    try {
      final result = await ApiRepo().changePass(emailId, otp, pass);
      Log.loga(title, "changePass:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        changePassModel = result;
        update();
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Get.back();
      Fluttertoast.showToast(msg: "Email id not available. Try agian later");
      Log.loga(title, "changePass:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  submitTest(String testId, String attemtTime, List<String> quesId,
      List<String> ans, List<String> crctAnds) async {
    try {
      final result =
          await ApiRepo().submitTest(testId, attemtTime, quesId, ans, crctAnds);
      Log.loga(title, "submitTest:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        testResultModel = result;
        update();
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "submitTest:: e >>>>> $e");
    }
  }

  checkTestSts(String testId) async {
    try {
      final result = await ApiRepo().checkTestSts(testId);
      Log.loga(title, "createChat:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        checkTestStstModel = result;
        update();
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "createChat:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  getTestSol(String testId) async {
    try {
      final result = await ApiRepo().getTestSol(testId);
      Log.loga(title, "createChat:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        _testSolList.value = result.data!;

        for (final i in _testSolList.value) {
          selectedAnswers[i.questionId.toString()] =
              optionNo.indexOf(i.answer!.toLowerCase().trim());
        }

        for (final i in _testSolList.value) {
          correctAnswers[i.questionId.toString()] =
              optionNo.indexOf(i.correctAnswer!.toLowerCase().trim());
        }

        print("selectedAnswers>>${selectedAnswers}");
        print("correctAnswers>>${correctAnswers}");

        update();
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "createChat:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  getTestQuestions(String testId) async {
    try {
      final result = await ApiRepo().getTestQuestions(testId);
      Log.loga(title, "getTestQuestions:: result >>>>> ${result!}");

      if (result != null) {
        testQuestModel = result;
        update();
        print(">>getTestQuestions>>>${testQuestModel}");
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "getTestQuestions:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  getAllTests() async {
    try {
      final result = await ApiRepo().getTests();
      Log.loga(title, "getCat:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        _allTestList.value = result.data!;
        update();
        print(">>allTestList>>>${_allTestList.value}");
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "allTestList:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  getTestQues({required String id}) async {
    try {
      final result = await ApiRepo().getTestQues(id: id);
      Log.loga(title, "getCat:: result >>>>> ${result!}");

      if (result.data!.isNotEmpty) {
        testQues = result;
        update();
        print(">>allTestList>>>${_coursesList.value}");
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "allTestList:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  getSlider() async {
    try {
      final result = await ApiRepo().getSlider();
      Log.loga(title, "getCat:: result >>>>> ${result!}");

      if (result.status!.contains("success")) {
        _sliderList.value = result.data!;

        print(">>_sliderList>>>${_sliderList.value}");
        update();
      } else {
        // showSnackbar("Api Error Response", "Something went wrong");
      }
    } catch (e) {
      Log.loga(title, "getProducts:: e >>>>> $e");
      // showSnackbar("Api Error", "error:: $e");
    }
  }

  Future<String> downloadPDF(String url) async {
    var response = await http.get(Uri.parse(url));
    var filePath = await _localPath;
    File file = File('$filePath/myFile.pdf');
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  Future<String> get _localPath async {
    // Directory for storing the PDF file
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

//   Future<String> getCity() async {
// // -----loaction permission
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         Fluttertoast.showToast(msg: "Location permission is required");
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       Fluttertoast.showToast(msg: "Location permission is required");
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best);

//     debugPrint(
//         'location>>>>: ${position.latitude} + ","+ ${position.longitude}');

//     //  var addresses = await Geocoder.google ( '<---------YOUR APIKEY-------->' ).findAddressesFromCoordinates(coordinates);

//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);

//     Placemark placemark = placemarks[0];

//     // String curntLoc = '${placemark.street}, ${placemark.subLocality},'
//     //     '${placemark.locality},  '
//     //     '${placemark.administrativeArea} ${placemark.postalCode}, '
//     //     '${placemark.country}';

//     print("placemarks${placemark.locality}");

//     return placemark.locality.toString();
//   }
}
