//
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:classroom_toppers/model/all_test_model/all_test_model.dart';
import 'package:classroom_toppers/model/assigned_course_model/assigned_course_model.dart';
import 'package:classroom_toppers/model/assigned_video_model/assigned_video_model.dart';
import 'package:classroom_toppers/model/banner_model/banner_model.dart';
import 'package:classroom_toppers/model/book_list_model/book_list_model.dart';
import 'package:classroom_toppers/model/cat_model/cat_model.dart';
import 'package:classroom_toppers/model/course_model/course_model.dart';
import 'package:classroom_toppers/model/course_model/courses_data.dart';
import 'package:classroom_toppers/model/live_user_count_model.dart';
import 'package:classroom_toppers/model/news_model/news_model.dart';
import 'package:classroom_toppers/model/study_material_model/study_material_model.dart';
import 'package:classroom_toppers/model/sub_cat_model/sub_cat_model.dart';
import 'package:classroom_toppers/model/verify_payment_model/verify_payment_model.dart';
import 'package:classroom_toppers/model/video_model/video_model.dart';

import '../../model/change_pass_model.dart';
import '../../model/chat_create_model/chat_create_model.dart';
import '../../model/chat_list_model/chat_list_model.dart';
import '../../model/check_test_sts_model/check_test_sts_model.dart';
import '../../model/course_purchs_model/course_purchs_model.dart';
import '../../model/course_type_model/course_type_model.dart';
import '../../model/login_model/login_model.dart';
import '../../model/signup_model/signup_model.dart';
import '../../model/test_quest_model/test_quest_model.dart';
import '../../model/test_result_model/test_result_model.dart';
import '../../model/test_sol_model/test_sol_model.dart';
import '../../utils/my_application.dart';
import '../../utils/sharedpref.dart';
import '../../utils/strings.dart';
import '../api/api_utils.dart';

const title = "ApiRepo";

class ApiRepo {
  Future<LoginModel?> login(String mobile, String password) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();

    LoginModel? loginResModel;
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showSnackbar("Internet Connection", "Lost");
    }

    var param = jsonEncode(
        {"mobile": mobile, "password": password, "fcm_token": fcmToken});

    print("login_param>>>$param");

    String url = BASE_URL + UserLogin;

    try {
      final response = await apiUtils.post(url: url, data: param);

      print(">>response$response");

      loginResModel = LoginModel.fromMap(response.data);

      return loginResModel;
    } catch (e) {
      Fluttertoast.showToast(msg: "check mobile no. and password");
    }
    return loginResModel;
  }

  Future<SignupModel?> userReg(String name, String email, String mobile,
      String password, String city) async {
    SignupModel? signupResModel;
    final connectivityResult = await (Connectivity().checkConnectivity());
    final fcmToken = await FirebaseMessaging.instance.getToken();

    var param = jsonEncode({
      "name": name,
      "email": email,
      "mobile": mobile,
      "password": password,
      "city": password,
      "fcm_token": fcmToken
    });
    print("login_param>>>$param");

    String url = BASE_URL + UserSignup;

    try {
      final response = await apiUtils.post(url: url, data: param);
      print(">>response$response");

      if (response.toString().contains("The mobile has already been taken")) {
        Fluttertoast.showToast(msg: "The mobile has already been taken");
      } else {
        signupResModel = SignupModel.fromMap(response.data);
      }

      return signupResModel;
    } catch (e) {
      Fluttertoast.showToast(msg: "check entries");
    }
    return signupResModel;
  }

  Future<StudyMaterialModel?> getStudyMat() async {
    StudyMaterialModel? studyMaterialModel;

    var token = await SharedPref().getToken();
    String url = BASE_URL + StudyMaterial;

    try {
      final response = await apiUtils.get(
        url: url,
        // options: Options(
        //     receiveTimeout: 6 * 1000,
        //     // connectTimeout
        //     headers: {
        //       'Content-Type': 'application/json',
        //       'Accept': 'application/json',
        //       'Authorization': 'Bearer $token',
        //     }
        //     )
      );

      print(">>response$response");

      studyMaterialModel = StudyMaterialModel.fromMap(response.data);

      return studyMaterialModel;
    } catch (e) {
      print(e);
    }
    return studyMaterialModel;
  }

  Future<BookListModel?> getBooks() async {
    BookListModel? bookListModel;

    var token = await SharedPref().getToken();
    String url = BASE_URL + BookList;

    try {
      final response = await apiUtils.get(
        url: url,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      bookListModel = BookListModel.fromMap(response.data);

      return bookListModel;
    } catch (e) {
      print(e);
    }
    return bookListModel;
  }

  Future<NewsModel?> getNews() async {
    NewsModel? newsModel;

    String url = BASE_URL + News;

    try {
      final response = await apiUtils.get(
        url: url,
      );

      print(">>response$response");

      newsModel = NewsModel.fromMap(response.data);

      return newsModel;
    } catch (e) {
      print(e);
    }
    return newsModel;
  }

  Future<AllTestModel?> getTests() async {
    AllTestModel? testModel;

    var token = await SharedPref().getToken();
    String url = BASE_URL + AllTest;

    try {
      final response = await apiUtils.get(
        url: url,
        // options: Options(receiveTimeout: 60 * 1000, headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      testModel = AllTestModel.fromMap(response.data);

      return testModel;
    } catch (e) {
      print(e);
    }
    return testModel;
  }

  Future<TestQuestModel?> getTestQues({required String id}) async {
    TestQuestModel? testQuestModel;

    var token = await SharedPref().getToken();
    String url = BASE_URL + TestQuest + id;

    try {
      final response = await apiUtils.get(
        url: url,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      testQuestModel = TestQuestModel.fromMap(response.data);

      return testQuestModel;
    } catch (e) {
      print(e);
    }
    return testQuestModel;
  }

  Future<CatModel?> getCategory() async {
    CatModel? catModel;

    var token = await SharedPref().getToken();
    String url = BASE_URL + Category;

    try {
      final response = await apiUtils.get(
        url: url,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      catModel = CatModel.fromMap(response.data);

      return catModel;
    } catch (e) {
      print(e);
    }
    return catModel;
  }

  Future<SubCatModel?> getSubCategory() async {
    SubCatModel? subCatModel;

    var token = await SharedPref().getToken();
    String url = BASE_URL + SubCat;

    try {
      final response = await apiUtils.get(
        url: url,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      subCatModel = SubCatModel.fromMap(response.data);

      return subCatModel;
    } catch (e) {
      print(e);
    }
    return subCatModel;
  }

  Future<CourseTypeModel?> getCourseType() async {
    CourseTypeModel? courseTypeModel;

    var token = await SharedPref().getToken();
    String url = BASE_URL + CoursesType;

    try {
      final response = await apiUtils.get(
        url: url,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      courseTypeModel = CourseTypeModel.fromMap(response.data);

      return courseTypeModel;
    } catch (e) {
      print(e);
    }
    return courseTypeModel;
  }

  Future<CourseModel?> getAllCourses() async {
    CourseModel? catModel;

    var token = await SharedPref().getToken();
    String url = BASE_URL + Courses;

    try {
      final response = await apiUtils.get(
        url: url,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      catModel = CourseModel.fromMap(response.data);

      return catModel;
    } catch (e) {
      print(e);
    }
    return catModel;
  }

  Future<VideoModel?> getAllVideos() async {
    VideoModel? videoModel;

    var token = await SharedPref().getToken();
    String url = BASE_URL + Videos;

    try {
      final response = await apiUtils.get(
        url: url,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      videoModel = VideoModel.fromMap(response.data);

      return videoModel;
    } catch (e) {
      print(e);
    }
    return videoModel;
  }

  Future<VideoModel?> getLiveVideos() async {
    VideoModel? videoModel;

    var token = await SharedPref().getToken();
    String url = BASE_URL + LiveVideo;

    try {
      final response = await apiUtils.get(
        url: url,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      videoModel = VideoModel.fromMap(response.data);

      return videoModel;
    } catch (e) {
      print(e);
    }
    return videoModel;
  }

  Future<VideoModel?> getLiveVideosByCourse() async {
    VideoModel? videoModel;

    var token = await SharedPref().getToken();
    String url = BASE_URL + LiveVideo;

    try {
      final response = await apiUtils.get(
        url: url,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      videoModel = VideoModel.fromMap(response.data);

      return videoModel;
    } catch (e) {
      print(e);
    }
    return videoModel;
  }

  Future<AssignedCourseModel?> getMyCourses() async {
    AssignedCourseModel? assignedCourseModel;

    var token = await SharedPref().getToken();
    var id = await SharedPref().getUserId();
    String url = BASE_URL + MyCourse;

    try {
      final response = await apiUtils.get(
        url: url,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      assignedCourseModel = AssignedCourseModel.fromMap(response.data);

      return assignedCourseModel;
    } catch (e) {
      print(e);
    }
    return assignedCourseModel;
  }

  Future<AssignedVideoModel?> getCourseVideo(String id) async {
    AssignedVideoModel? assignedVideoModel;

    var token = await SharedPref().getToken();
    // var id = await SharedPref().getUserId();
    String url = BASE_URL + MyCourseVideo;

    var param = jsonEncode({
      "course_id": id,
    });

    try {
      final response = await apiUtils.post(
        url: url,
        data: param,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      assignedVideoModel = AssignedVideoModel.fromMap(response.data);

      return assignedVideoModel;
    } catch (e) {
      print(e);
    }
    return assignedVideoModel;
  }

  Future<CoursePurchsModel?> assignCourse(String courseId) async {
    CoursePurchsModel? coursePurchsModel;

    var userId = await SharedPref().getUserId();
    // var id = await SharedPref().getUserId();
    String url = BASE_URL + CoursePurchase;

    var param = jsonEncode({
      "user_id" : userId.toString(),
      "course_id": courseId,
    });

    try {
      final response = await apiUtils.post(
        url: url,
        data: param,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      coursePurchsModel = CoursePurchsModel.fromMap(response.data);

      return coursePurchsModel;
    } catch (e) {
      print(e);
    }
    return coursePurchsModel;
  }

  Future<VerifyPaymentModel?> verifyPyment(
    String payment_id,
    String payment_status,
  ) async {
    VerifyPaymentModel? verifyPaymentModel;

    var token = await SharedPref().getToken();
    // var id = await SharedPref().getUserId();
    String url = BASE_URL + VerifyPayment;

    var param = jsonEncode({
      "payment_id": payment_id,
      "payment_status": payment_status,
    });

    try {
      final response = await apiUtils.post(
        url: url,
        data: param,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      verifyPaymentModel = VerifyPaymentModel.fromMap(response.data);

      return verifyPaymentModel;
    } catch (e) {
      print(e);
    }
    return verifyPaymentModel;
  }

  Future<ChatCreateModel?> createChat(String videoId, String msg) async {
    ChatCreateModel? chatCreateModel;

    var token = await SharedPref().getToken();
    String url = BASE_URL + CreateChat;

    var param = jsonEncode({"video_id": videoId, "message": msg});

    try {
      final response = await apiUtils.post(
        url: url,
        data: param,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      chatCreateModel = ChatCreateModel.fromMap(response.data);

      return chatCreateModel;
    } catch (e) {
      print(e);
    }
    return chatCreateModel;
  }

  Future<LiveUserCountModel?> liveUserCount(String videoId, String type) async {
    LiveUserCountModel? liveUserCountModel;

    String url = BASE_URL + LiveUserCount;

    var param = jsonEncode({"video_id": videoId, "type": type});

    try {
      final response = await apiUtils.post(
        url: url,
        data: param,
      );

      print(">>response$response");

      liveUserCountModel = LiveUserCountModel.fromMap(response.data);

      return liveUserCountModel;
    } catch (e) {
      print(e);
    }
    return liveUserCountModel;
  }

  Future<ChatListModel?> getChatList(
    String videoId,
  ) async {
    ChatListModel? chatListModel;

    var chatId = '0'; // to get all the chat list

    String url = BASE_URL + ChatList;

    var param = jsonEncode({
      "video_id": videoId,
    });

    try {
      final response = await apiUtils.post(
        url: url,
        data: param,
      );

      print(">>response$response");

      chatListModel = ChatListModel.fromMap(response.data);

      return chatListModel;
    } catch (e) {
      print(e);
    }
    return chatListModel;
  }

  Future<ChatListModel?> getOtp(
    String emailId,
  ) async {
    ChatListModel? chatListModel;

    var token = await SharedPref().getToken();
    String url = BASE_URL + SendOtp;

    var param = jsonEncode({
      "email": 'imrh4u@gmail.com',
    });

    try {
      final response = await apiUtils.post(
        url: url,
        data: param,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      chatListModel = ChatListModel.fromMap(response.data);

      return chatListModel;
    } catch (e) {
      print(e);
    }
    return chatListModel;
  }

  Future<ChangePassModel?> changePass(
      String emailId, String otp, String pass) async {
    ChangePassModel? changePassModel;

    var token = await SharedPref().getToken();
    String url = BASE_URL + ChangePass;

    var param = jsonEncode({
      "email": emailId,
      // "email": "manishsingh.singh1000@gmail.com",
      "password": pass, "password_confirmation": pass
    });

    try {
      final response = await apiUtils.post(
        url: url,
        data: param,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      changePassModel = ChangePassModel.fromMap(response.data);

      return changePassModel;
    } catch (e) {
      print(e);
    }
    return changePassModel;
  }

  Future<TestResultModel?> submitTest(String testId, String attemtTime,
      List<String> quesId, List<String> ans, List<String> crctAnds) async {
    TestResultModel? testResultModel;

    var token = await SharedPref().getToken();
    String url = BASE_URL + SubmitTest;

    var param = jsonEncode({
      "test_id": testId,
      "attempt_time": attemtTime,
      "question_id":
          quesId.toString().replaceAll("[", "").replaceAll("]", "").trim(),
      "answer": ans.toString().replaceAll("[", "").replaceAll("]", "").trim(),
      "correct_answer":
          crctAnds.toString().replaceAll("[", "").replaceAll("]", "").trim(),
    });

    try {
      final response = await apiUtils.post(
        url: url,
        data: param,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      testResultModel = TestResultModel.fromMap(response.data);

      return testResultModel;
    } catch (e) {
      print(e);
    }
    return testResultModel;
  }

  Future<CheckTestStsModel?> checkTestSts(String testId) async {
    CheckTestStsModel? checkTestStsModel;

    var token = await SharedPref().getToken();
    String url = BASE_URL + CheckTestSts + testId;

    try {
      final response = await apiUtils.post(
        url: url,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      checkTestStsModel = CheckTestStsModel.fromMap(response.data);

      return checkTestStsModel;
    } catch (e) {
      print(e);
    }
    return checkTestStsModel;
  }

  Future<TestSolModel?> getTestSol(String testId) async {
    TestSolModel? testSolModel;

    var token = await SharedPref().getToken();

    String url = BASE_URL + TestSol;

    var param = jsonEncode({
      "test_id": testId,
    });

    try {
      final response = await apiUtils.post(url: url, data: param);

      print(">>response$response");

      testSolModel = TestSolModel.fromMap(response.data);

      return testSolModel;
    } catch (e) {
      print(e);
    }
    return testSolModel;
  }

  Future<TestQuestModel?> getTestQuestions(String id) async {
    TestQuestModel? testQuestModel;

    var token = await SharedPref().getToken();
    String url = BASE_URL + TestQuest + id;

    try {
      final response = await apiUtils.get(
        url: url,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      testQuestModel = TestQuestModel.fromMap(response.data);

      return testQuestModel;
    } catch (e) {
      print(e);
    }
    return testQuestModel;
  }

  Future<BannerModel?> getSlider() async {
    BannerModel? sliderModel;

    var token = await SharedPref().getToken();
    String url = BASE_URL + Slider;

    try {
      final response = await apiUtils.get(
        url: url,
        // options: Options(headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // })
      );

      print(">>response$response");

      sliderModel = BannerModel.fromMap(response.data);

      return sliderModel;
    } catch (e) {
      print(e);
    }
    return sliderModel;
  }

  Future<List<CoursesData>> getItemSugg(String query) async {
    List<CoursesData> data = [];

    try {
      data = app.appController.coursesList.where((element) {
        final nameLower = element.name?.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower!.contains(queryLower);
      }).toList();

      print(">>>data>>>$data");

      return data;
    } catch (e) {}
    return data;
  }
}
