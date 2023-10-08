import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/utils/strings.dart';
import 'package:classroom_toppers/widgets/app_logo.dart';

import '../../utils/app_color.dart';
import '../../utils/theme.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appColor.white,
          // elevation: 0.2,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: appColor.black,
              size: 20,
            ),
          ),
          title: Text(
            'News/Events',
            style: AppTheme.ttlStyl,
            textAlign: TextAlign.start,
          ),
          centerTitle: true,
        ),
        backgroundColor: appColor.white,
        body: _view());
  }

  Widget _view() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppLogo().tinyLogo(),

          SizedBox(height: 20),
          Text('About us', style: AppTheme.t24),
          SizedBox(height: 10),
          // About Us text
          Text(
            AboutUs,
            style: AppTheme.ttlStyl14,
          ),
        ],
      ),
    );
  }
}
