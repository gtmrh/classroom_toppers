import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:classroom_toppers/utils/route.dart';
import 'package:classroom_toppers/utils/theme.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //firebase initialize
  initFirebase();

  runApp(const MyApp());

}

initFirebase() async {
  await Firebase.initializeApp();

  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('Permission granted: ${settings.authorizationStatus}');

  final fcmToken = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  print("FCMToken $fcmToken");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
    ));
    // Get.lazyPut(() => AppController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Classroom Toppers',
      getPages: MyRoutes.routes,
      initialRoute: "/",
      theme: AppTheme.lightTheme,
    );
  }
}
