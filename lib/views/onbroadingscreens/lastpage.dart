// ignore_for_file: unused_import, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:esh7enly/core/utils/Appstrings.dart';
import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/views/Login/login.dart';
import 'package:esh7enly/views/Login/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:esh7enly/views/Login/otp.dart';
import 'dart:convert';
import 'package:flutter_svg/svg.dart';

class LastPage extends StatefulWidget {
  LastPage({super.key});

  @override
  State<LastPage> createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> with TickerProviderStateMixin {
  final storage = const FlutterSecureStorage();
  late final AnimationController _controller;


  @override
  void initState() {


    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth=MediaQuery.of(context).size.width;
    return Scaffold(
        body:
        SingleChildScrollView(
          child:
        Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenheight*.12),
            child: Center(
              child: Text(
                'مع اشحنلي',
                style: TextStyle(
                    fontSize: 27.sp,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.MainColor),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1),
            child: Center(
              child: Text('سجل واشحن',
                  style: TextStyle(
                      fontSize: 27.sp,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.MainColor)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1),
            child: Center(
              child: Text('في ثانيه',
                  style: TextStyle(
                      fontSize: 27.sp,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.MainColor)),
            ),
          ),
          SizedBox(
           // height: 300,
            child: Lottie.asset(
              'assets/create_account.json',
              height: screenheight*.32,
              controller: _controller,
              onLoaded: (composition) {
                // Configure the AnimationController with the duration of the
                // Lottie file and start the animation.
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
            ),
          ),

          GestureDetector(
            onTap: () {
              storage.write(key: 'onbreoading', value: 'true');
             Get.offAll(otp(check: 1,));  // Get.off
            },
            child: Container(
              height: screenheight/17,
              margin: const EdgeInsets.symmetric(horizontal: 100),
              decoration: BoxDecoration(
                color: CustomColors.MainColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'انشاء حساب جديد',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontFamily: 'ReadexPro',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              storage.write(key: 'onbreoading', value: 'true');
              Get.offAll(login());  //Get.off
            },
            child: Container(
              height: screenheight/17,
              margin: const EdgeInsets.symmetric(horizontal: 100),
              decoration: BoxDecoration(
                color: CustomColors.MainColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'تخطي لتسجيل الدخول',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontFamily: 'ReadexPro',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: screenwidth, child:  SvgPicture.string(
            AppStrings.wave
  , fit: BoxFit.cover ,height: screenheight*.29,)),
        ])));
  }
}
