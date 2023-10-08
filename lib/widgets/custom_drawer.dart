import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../utils/app_color.dart';
import '../utils/sharedpref.dart';
import '../utils/strings.dart';
import '../utils/theme.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late String name = '';
  late String mobileNo = '';

  @override
  void initState() {
    getData();

    super.initState();
  }

  getData() async {
    var userName = await SharedPref().getUserName();
    var userMobile = await SharedPref().getUserMob();
    setState(() {
      name = userName.toString();
      mobileNo = userMobile.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: appColor.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue, // Set your desired color here
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  child: Text(
                    name.toString()[0],
                    style: AppTheme.userName,
                  ),
                  // Set user avatar image here
                ),
                const SizedBox(height: 8),
                Text(
                  "Hi $name",
                  style: AppTheme.userName,
                ),
                const SizedBox(height: 8),
                Text(mobileNo, style: AppTheme.userMob),
              ],
            ),
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.download,
          //     color: appColor.fieldClr,
          //     size: 25,
          //   ),
          //   title: Text(
          //     "Downloads",
          //     style: AppTheme.t16N,
          //   ),
          //   onTap: () {
          //     // Handle menu item 1 tap
          //   },
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.card_giftcard,
          //     color: appColor.vochIcon,
          //     size: 25,
          //   ),
          //   title: Text(
          //     "My Courses",
          //     style: AppTheme.t16N,
          //   ),
          //   onTap: () {
          //     Get.toNamed(HOME_SCREEN, arguments: '1');
          //   },
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.wallet_rounded,
          //     color: appColor.walletIcon,
          //     size: 25,
          //   ),
          //   title: Text(
          //     "Classes",
          //     style: AppTheme.t16N,
          //   ),
          //   onTap: () {
          //     Get.toNamed(HOME_SCREEN, arguments: '2');
          //   },
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.notifications,
          //     color: appColor.notifIcon,
          //     size: 25,
          //   ),
          //   title: Text(
          //     "Notification",
          //     style: AppTheme.t16N,
          //   ),
          //   onTap: () {
          //     // Handle menu item 2 tap
          //   },
          // ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.newspaper,
              color: appColor.settingIcon,
              size: 25,
            ),
            title: Text(
              "News/Events",
              style: AppTheme.t16N,
            ),
            onTap: () {
              // Handle menu item 2 tap
            },
          ),
          ListTile(
            leading: Icon(
              Icons.report_outlined,
              color: appColor.settingIcon,
              size: 25,
            ),
            title: Text(
              "TnC",
              style: AppTheme.t16N,
            ),
            onTap: () {
              // Handle menu item 2 tap
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.call,
              color: Colors.greenAccent,
              size: 25,
            ),
            title: Text(
              "Contacts",
              style: AppTheme.t16N,
            ),
            onTap: () {
              Get.toNamed(CONTACTUS_SCREEN);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info_rounded,
              color: Colors.black45,
              size: 25,
            ),
            title: Text(
              "About Us",
              style: AppTheme.t16N,
            ),
            onTap: () {
              Get.toNamed(ABOUTUS_SCREEN);
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.share,
              color: Colors.black45,
              size: 25,
            ),
            title: Text(
              "Share",
              style: AppTheme.t16N,
            ),
            onTap: () {
              Share.share(ShareTxt, subject: 'Mission Classes');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: appColor.logIcon,
              size: 25,
            ),
            title: Text(
              "Log out",
              style: AppTheme.t16N,
            ),
            onTap: () {
              Navigator.pop(context);
              // SharedPref().clearSharedPref();
              SharedPref().clearLog(SharedPref()
                  .firstStep); // clearing all data from sharedpref except the intro screen log
              Fluttertoast.showToast(msg: "Logged Out");
              Get.toNamed(LOGIN_SCREEN);
            },
          ),
        ],
      ),
    );
  }
}
