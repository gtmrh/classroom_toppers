// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';
import 'package:classroom_toppers/utils/strings.dart';

import '../core/controller/app_controller.dart';

MyApplication app = MyApplication();

class MyApplication {
  static final MyApplication _myApplication = MyApplication._i();
  AppController _appController = Get.find(tag: APP);

  factory MyApplication() {
    return _myApplication;
  }

  MyApplication._i() {}

  AppController get appController {
    return _appController;
  }
}
