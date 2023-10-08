import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../utils/app_color.dart';
import '../../utils/sharedpref.dart';
import '../../utils/strings.dart';
import '../../utils/theme.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
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
    return Scaffold(
      backgroundColor: appColor.white,
      body: _view(),
    );
  }

  Widget _view() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: appColor.greyBg,
                    radius: 50,
                    child: Icon(
                      Icons.person,
                      color: appColor.white,
                      size: 80,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Wrap(spacing: 10, children: [
                    Text(
                      name.toString(),
                      style: AppTheme.t18Med,
                    ),
                    Icon(
                      FontAwesomeIcons.solidEdit,
                      color: appColor.greyLight,
                      size: 20,
                    )
                  ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // spacing: 2, alignment: WrapAlignment.center,
                      children: [
                        Icon(
                          Icons.phone_iphone_rounded,
                          color: appColor.greyLight,
                          size: 15,
                        ),
                        Text(
                          mobileNo.toString(),
                          style: AppTheme.t16N,
                        ),
                      ]),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    InkWell(
                      // onTap: () => Get.toNamed(USER_ADDRESS_SCREEN),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                shape: BoxShape.rectangle,
                                color: appColor.locBg),
                            child: Icon(
                              Icons.download,
                              color: appColor.locIcon,
                              size: 25,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "My Downloads",
                            style: AppTheme.t16N,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              shape: BoxShape.rectangle,
                              color: appColor.vochBg),
                          child: Icon(
                            Icons.card_giftcard,
                            color: appColor.vochIcon,
                            size: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "My Courses",
                          style: AppTheme.t16N,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              shape: BoxShape.rectangle,
                              color: appColor.walletBg),
                          child: Icon(
                            Icons.wallet_rounded,
                            color: appColor.walletIcon,
                            size: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Videos",
                          style: AppTheme.t16N,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              shape: BoxShape.rectangle,
                              color: appColor.notifBg),
                          child: Icon(
                            Icons.notifications,
                            color: appColor.notifIcon,
                            size: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Notification",
                          style: AppTheme.t16N,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              shape: BoxShape.rectangle,
                              color: appColor.settingBg),
                          child: Icon(
                            Icons.settings,
                            color: appColor.settingIcon,
                            size: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Settings",
                          style: AppTheme.t16N,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        SharedPref().clearSharedPref();
                        Fluttertoast.showToast(msg: "Logged Out");
                        Get.toNamed(LOGIN_SCREEN);
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                shape: BoxShape.rectangle,
                                color: appColor.logBg),
                            child: Icon(
                              Icons.logout,
                              color: appColor.logIcon,
                              size: 25,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Log out",
                            style: AppTheme.t16N,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
