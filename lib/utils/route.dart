import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:classroom_toppers/screens/course_details/course_details.dart';
import 'package:classroom_toppers/screens/course_details/paid_courses.dart';
import 'package:classroom_toppers/screens/course_details/play_video.dart';
import 'package:classroom_toppers/screens/drawer/aboutus.dart';
import 'package:classroom_toppers/screens/drawer/contact_us.dart';
import 'package:classroom_toppers/screens/pdfs/pdf_viewer_page.dart';
import 'package:classroom_toppers/screens/splash/splashscreen.dart';
import 'package:classroom_toppers/utils/strings.dart';

import '../core/binding/app_binding.dart';
import '../screens/course_details/play_live_video.dart';
import '../screens/course_type/course_type.dart';
import '../screens/home/main_home.dart';
import '../screens/intro/intro.dart';
import '../screens/login/login.dart';
import '../screens/test/quiz_ques.dart';
import '../screens/test/quiz_solution.dart';
import '../screens/test/test_result.dart';
import '../screens/test/test_result_check.dart';

class MyRoutes {
  static var routes = [
    GetPage(name: "/", page: () => const Splashscreen(), binding: AppBinding()),
    GetPage(
        name: INTRO_SCREEN,
        page: () => const IntroScreen(),
        binding: AppBinding()),
    GetPage(
        name: LOGIN_SCREEN, page: () => const Login(), binding: AppBinding()),
    GetPage(name: TYPE_SCREEN, page: () => CourseType(), binding: AppBinding()),
    GetPage(
        name: HOME_SCREEN,
        page: () => const MainHome(),
        binding: AppBinding(),
        arguments: {"page"}),
    GetPage(
        name: My_Course_Details_Screen,
        page: () => const CourseDetails(),
        binding: AppBinding(),
        arguments: const ["id"]),
    GetPage(
        name: Course_Details_Screen,
        page: () => const PaidCourses(),
        binding: AppBinding(),
        arguments: "id"),
    GetPage(
        name: VIDEO_SCREEN,
        page: () => PlayVideo(),
        binding: AppBinding(),
        arguments: const ["url"]),
    GetPage(
        name: LIVE_VIDEO_SCREEN,
        page: () => PlayLiveVideo(),
        binding: AppBinding(),
        arguments: const ["videoid", "url"]),
    GetPage(
        name: PDF_VIEW_SCREEN,
        page: () => const PdfViewerPage(),
        binding: AppBinding(),
        arguments: const ["url"]),
    GetPage(
        name: Quiz_SCREEN,
        page: () => QuizPage(),
        binding: AppBinding(),
        arguments: const [
          "name",
          "noOfQuestion",
          "time",
          "id",
          "isAdvanceMode"
        ]),
    GetPage(
        name: Solution_SCREEN,
        page: () => QuizSolPage(),
        binding: AppBinding(),
        arguments: const [
          "name",
          "noOfQuestion",
          "time",
          "id",
          "isAdvanceMode"
        ]),
    GetPage(
        name: SCORE_SCREEN,
        page: () => TestResult(),
        binding: AppBinding(),
        arguments: const ["type"]),
    GetPage(
        name: SCORE_SCREEN_CHECK,
        page: () => TestResultCheck(),
        binding: AppBinding(),
        arguments: const ["type"]),
    GetPage(
      name: ABOUTUS_SCREEN,
      page: () => AboutUsScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: CONTACTUS_SCREEN,
      page: () => ContactUsScreen(),
      binding: AppBinding(),
    )
  ];
}
