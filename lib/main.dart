// ignore_for_file: depend_on_referenced_packages

import 'package:esh7enly/core/widgets/font.dart';
import 'package:esh7enly/views/HomeScreen/controllhome.dart';
import 'package:esh7enly/views/Login/register.dart';
import 'package:esh7enly/views/loadingview.dart';
import 'package:esh7enly/views/onbroadingscreens/lastpage.dart';
import 'package:esh7enly/views/onbroadingscreens/onbroadingpage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controlls/Homviewmodel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'Helper/Binding.dart';

import 'package:localize_and_translate/localize_and_translate.dart';

import 'Services/global/LocalNotification.dart';
import 'Services/global/integration_firebase.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.messageId != "") {

    LocalNotificationApi().shownotification(message: message);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  PdfGenerator.init();
  FirebaseApi().initialnotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  LocalNotificationApi().initialize();
  Get.put(HomeViewModel());
  await  LocalizeAndTranslate.init(
    supportedLanguageCodes: <String>['ar', 'en'],
    assetLoader: const AssetLoaderRootBundleJson('assets/lang/'),
    // NOT YET TESTED
  );
  configLoading();
  runApp( LocalizedApp(child: MyApp()));
}

void configLoading() {
  EasyLoading.instance.loadingStyle = EasyLoadingStyle.light;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    RenderErrorBox.backgroundColor = Colors.transparent;
    RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // ignore: prefer_const_literals_to_create_immutables'
        localizationsDelegates:  LocalizeAndTranslate.delegates, // Android + iOS Delegates
        // ignore: deprecated_member_use
        locale:  context.locale, // Active locale
        supportedLocales:  context.supportedLocales,
        builder: (context, child) {
          return ScreenUtilInit(
              //designSize: const Size(393, 804),
            designSize: const Size(360,690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return GetMaterialApp(
                    debugShowCheckedModeBanner: false,
                    initialBinding: Binding(),
                    builder: EasyLoading.init(),
                    home:Loading()); //
              });
        });
  }
}
