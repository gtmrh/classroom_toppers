// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

//
const String APP = "app";
const String APP_NAME = "Mission";
const String CONTACTS = "+918538917713";
const String MAIL = "mission50iaspatna@gmail.com";

//colors
const btnColor = Colors.blue;
const borderColor = Color.fromARGB(31, 26, 25, 25);
const textHintColor = Color.fromARGB(31, 26, 25, 25);

const textColor = Colors.black;

const pink = Color(0xFFFACCCC);
const grey = Color(0xFFF2F2F7);

//font
const textFont = "Roboto";

//apis
const String BASE_URL = "http://classroomtoppers.com/";


const String UserLogin = 'api/user-login';
const String UserSignup = 'api/user-registration';
const String CoursesType = 'api/course-type-list/0';
const String Courses = 'api/course-list';
const String MyCourse = "api/assign-course-list";
const String MyCourseVideo = "api/course-video-list";
const String Videos = 'api/video-list';
const LiveVideo = 'api/live-class-list';
const Slider = 'api/banner-list';
const News = "api/news-list/"; //pass 0 for all data and id for details
const StudyMaterial =
    "api/material-list/0"; //pass 0 for all data and id for details
const BookList = 'api/book-list/0'; //pass 0 for all data and id for details
const Category = 'api/category-list';
const SubCat = 'api/sub-category-list';
const AllTest = 'api/all-test-series/0';
const TestQuest = 'api/test-series-question/';
const CreateChat = 'api/create-chat';
const ChatList = 'api/chat-list';
const SendOtp = "api/send-otp";
const ChangePass = "api/change-password";
const ChatReplyList = 'api/chat-reply-list';
const SubmitTest = 'api/test-submit';
const CoursePurchase = 'api/course-purchase';
const VerifyPayment = 'api/verify_payment';
const CheckTestSts = 'api/test-stats?test_id=';
const TestSol = 'api/test-submit-list';
const LiveUserCount = 'api/live-user-count';

//fontsize
const double TextFont14 = 14;
const double TextFont16 = 16;
const double TextFont18 = 18;
const double TextFont20 = 20;
const double TextFont22 = 22;
const double TextFont24 = 24;
const double TextFont26 = 26;
const double TextFont28 = 28;
const double TextFont30 = 30;

//Routes
const INTRO_SCREEN = '/intro_screen';
const LOGIN_SCREEN = '/login';
const TYPE_SCREEN = '/coursetype';
const HOME_SCREEN = '/home';
const CONTACT_SCREEN = '/contactus';

const Thanks_Screen = '/thankspage';
const Search_Screen = '/search';
const My_Course_Details_Screen = '/my_course_details';
const Course_Details_Screen = '/course_details';

const VIDEO_SCREEN = '/video';
const LIVE_VIDEO_SCREEN = '/live_video';
const PDF_VIEW_SCREEN = '/pdf_view';
const ORDER_SUCCESS_SCREEN = '/order_success';
const All_Cat_Screen = '/allcategory';
const Quiz_SCREEN = '/quiz';
const Solution_SCREEN = '/solution';

const SCORE_SCREEN = '/score';
const SCORE_SCREEN_CHECK = '/score_check';

const ABOUTUS_SCREEN = '/aboutus';
const CONTACTUS_SCREEN = '/contactus';
const NEWS_SCREEN = '/news';

const CAT = 'Category';
const BRAND = 'Brand';
const Product = 'Product';
const TEST = 'test';
const EXAM = 'exam';
const OnlineUser = 'online';
const OfflineUser = 'offline';

//constants Strings
const title1 = "Welcome to $APP_NAME";
const optionNo = ["a", "b", "c", "d", "e", "null"];
const title2 = "Various Courses";
const title3 = "Live Classes & Tests";
const title4 = "Easy Study";
const startTxt = "Let's Start Learning";
const registerTxt = "Signup with MISSION";

const loginTxt = "Already! have an account? Login";
const signupTxt = "Don't have an account? Sign up";
const forgetPasTxt = "Forget Password?";

const NotEnrolled =
    "You haven't enrolled in any courses yet. \n Enroll in following courses.";

const NotVideo = "Free classes not found. \n Enroll in following courses.";

const NotLiveVideo = "Live classes not found. \n Enroll in following courses.";

const termPrefix = 'By continuing, you agree to our \n';

const List<String> adrsHeader = ['Home', 'Working', 'Friend'];

const subtitle1 =
    "An online platform, to prepare for all the civil service examinations";
const subtitle2 = "Prepare for various exams like UPSC, BPSC etc.";
const subtitle3 = "Take live classes and appear in tests.";
const subtitle4 = "Prepare from anywhere without any hassle";

const ALREADY_SIGNIN = "Already have an account?";

const OTP_MSG = 'Otp sent on your mobile';

const Increment = 'increment';
const Decrement = 'decrement';
const PENDING = 'pending';
const COD = 'cod';
const Rupee = '\u{20B9}';
const Address =
    'Aparajita Building, Kidwaipuri, Near Income Tax Chauraha, Patna, 800001';

const Phone1 = '+91-885319955';
const Phone2 = '+91-8538917713';
const Email = 'contact@missionias.net';
const ShareTxt =
    'Check out one the best app for the preperation of UPSC, BPSC and many more competitive exams https://play.google.com/store/apps/details?id=co.msnias';

const AboutUs =
    'Mission is established by well known experts of IAS coaching field with a view to establish a bench-mark institution to achieve excellence in the toughest competitive exam in the country, i.e. Civil Services Exam which is popularly known as the IAS/PCS Examination. The institute is preparing candidates for Civil Services Examination at all the three levels – Preliminary Test, Main Examination and Personality Test. The main goal of this institute is to provide best and in-depth knowledge to civil services aspirants through which they can meet out challenges of changing pattern of questions and syllabus. . Our curriculum is enriched with the best of useful hints, ideas and methods that make it easy for the aspirants to crack the IAS/PCS exam with confidence.';

String PARAM_STATUS_CODE = "status_code";
String PARAM_MESSAGE = "message";
String PARAM_API_KEY = "api_key";

int CODE_SUCCESS = 200;
int CODE_NO_INTERNET = 100;
int CODE_ERROR = 102;
int CODE_RESPONSE_NULL = 103;

bool isKeyboardOpened() {
  return MediaQuery.of(Get.context!).viewInsets.bottom != 0;
}

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

void dismissKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

void showSnackbar(String title, String msg) {
  Get.snackbar(title, msg, backgroundColor: Colors.black.withOpacity(0.3));
}

void dismissSnakbar() {
  ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
}
