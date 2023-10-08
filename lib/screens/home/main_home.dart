import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/screens/classes/classes.dart';
import 'package:classroom_toppers/screens/course_details/my_courses.dart';
import 'package:classroom_toppers/screens/test/test.dart';
import 'package:classroom_toppers/utils/app_color.dart';
import 'package:upgrader/upgrader.dart';

import '../../model/course_type_model/course_type_data.dart';
import '../../utils/my_application.dart';
import '../../utils/sharedpref.dart';
import '../../utils/theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/custom_drawer.dart';
import '../pdfs/books.dart';
import 'home.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final GlobalKey<HomeState> contentScreenKey = GlobalKey<HomeState>();

  int? selectedPage = int.tryParse(Get.arguments.toString());

  late String userId;
  late String userName;
  late String nameChar;
  late String userMobNo;
  late String design;

  // var _pages = [];
  List<CourseTypeData> dropDownList = [];

  late List<Widget> _pages;

  String? _selectedOption = Get.arguments.toString(); // Default selected value

  @override
  void initState() {
    _initializePages();

    getUserData();

    super.initState();
  }

//navigate tomy course
  goToMyCourse() {
    setState(() {
      selectedPage = 1;
    });
  }

//navigate tomy test
  goToTest() {
    print("object");
    setState(() {
      selectedPage = 3;
    });
  }

  void _initializePages() {
    _pages = [
      Home(
        key: contentScreenKey,
        switchToMyCourse: goToMyCourse,
      ),
      MyCourses(
        switchToTest: goToTest,
      ),
      const Classes(),
      const Test(),
      // const Pdfs(),
      Books()
    ];
  }

  getUserData() async {
    await app.appController.getCourseType();

    var id = await SharedPref().getUserId();

    var name = await SharedPref().getUserName();

    var mobNo = await SharedPref().getUserMob();

    // _selectedOption = await SharedPref().getCourseType();

    print(">>name>>>$name>>>mobile>>$mobNo");

    setState(() {
      userId = id.toString();
      userName = name.toString();
      userMobNo = mobNo.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          // selectedOption: _selectedOption.toString(),
          // onOptionChanged: _updateSelectedOption,
          // contentScreenKey: contentScreenKey,
          ),
      drawer: const CustomDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        // activeColor: appColor.white,
        // style: TabStyle.flip,
        // curveSize: 0,
        // initialActiveIndex: selectedPage,
        // height: 60,
        // cornerRadius: 30,
        // cornerRadius: 50,
        // activeColor: appColor.white,
        elevation: 0.5,
        currentIndex: selectedPage!,
        type: BottomNavigationBarType.fixed,

        // shadowColor: Colors.amber,
        // backgroundColor: const Color.fromARGB(255, 97, 154, 252),
        backgroundColor: appColor.white,
        selectedItemColor: appColor.black,
        unselectedItemColor: appColor.grey,
        unselectedLabelStyle: AppTheme.btmUnselected,
        selectedLabelStyle: AppTheme.btmSelected,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',

            // fontFamily: GoogleFonts.rubik().fontFamily
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.chrome_reader_mode_rounded),
            label: 'My Courses',

            // fontFamily: GoogleFonts.rubik().fontFamily
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Live Class',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.paste_rounded),
            label: 'Test',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.picture_as_pdf_rounded), label: 'E-Book')
          // TabItem(icon: Icons.person_2_rounded, title: 'User'),
        ],
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
      body: UpgradeAlert(
          upgrader: Upgrader(
              onUpdate: () {
                SharedPref().clearSharedPref();
                return true;
              },
              canDismissDialog: false,
              showIgnore: false,
              showLater: false),
          child: RefreshIndicator(
              onRefresh: () async {
                Future.delayed(
                  Duration(seconds: 2),
                  () => app.appController.onInit(),
                );
              },
              child: _pages[selectedPage!])),
    );
  }
}
