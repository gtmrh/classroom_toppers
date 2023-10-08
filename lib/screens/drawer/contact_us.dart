import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/utils/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/app_color.dart';
import '../../utils/theme.dart';
import '../../widgets/app_logo.dart';

class ContactUsScreen extends StatelessWidget {
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
            'Contact Us',
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
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Your company logo
          AppLogo().tinyLogo(),

          SizedBox(height: 20),
          // Address
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.location_on),
              Expanded(
                child: Text(
                  maxLines: 5,
                  softWrap: true,
                  textAlign: TextAlign.start,
                  Address,
                  style: AppTheme.ttlStyl12B,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Phone Numbers
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone),
              SizedBox(width: 5),
              InkWell(
                onTap: () => launchUrl(Uri.parse('tel:$Phone1')),
                child: Text(
                  Phone1,
                  style: AppTheme.ttlStyl12,
                ),
              ),
              SizedBox(width: 20),
              Icon(Icons.phone),
              SizedBox(width: 5),
              InkWell(
                onTap: () => launchUrl(Uri.parse('tel:$Phone2')),
                child: Text(
                  Phone2,
                  style: AppTheme.ttlStyl12,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Email Addresses
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email),
              SizedBox(width: 5),
              InkWell(
                onTap: () => launch('mailto:$Email'),
                child: Text(
                  Email,
                  style: AppTheme.ttlStyl12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
