// ignore_for_file: camel_case_types, prefer_const_constructors, deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../utils/colors.dart';

class header extends StatelessWidget {
  double heightcon;
  header({Key? key, required this.heightcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth=MediaQuery.of(context).size.width;
    return Container(
        height: heightcon,
        decoration: const BoxDecoration(
            color: CustomColors.MainColor,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40))),
        child: Stack(children: <Widget>[
          Center(
            child: Image.asset(
              "assets/logo.png",
              width: heightcon*.90,
              height: heightcon*.90,
            ),
          ),
          Positioned(
              top: heightcon*.72,
             // left:   screenwidth *.1,
              right: screenwidth*.1,
              child: Center(
                  child: Text(
                 LocalizeAndTranslate.translate("caption"),
                style: TextStyle(
                    color: Colors.white, fontSize: 15.sp, fontFamily: 'ReadexPro'),
              ))),
          Positioned(
              top:  heightcon*.85,
              left:   screenwidth *.14,
              right: screenwidth*.1,
              child: Center(
                  child: Text(
                 LocalizeAndTranslate.translate("caption2"),
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'ReadexPro',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold),
              )))
        ]));
  }
}
