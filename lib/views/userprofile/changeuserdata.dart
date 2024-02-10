// ignore_for_file: unused_import, unnecessary_import, camel_case_types, deprecated_member_use, prefer_const_constructors, sized_box_for_whitespace

import 'dart:math';

import 'package:esh7enly/Services/features/AuthApi.dart';
import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/core/widgets/CustomTextField.dart';
import 'package:esh7enly/views/HomeScreen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:esh7enly/views/Login/login.dart';


class changeuserdata extends StatefulWidget {
  const changeuserdata({super.key});

  @override
  State<changeuserdata> createState() => _changeuserdataState();
}

class _changeuserdataState extends State<changeuserdata> {
  TextEditingController newmobile = TextEditingController();
  TextEditingController newname = TextEditingController();
  TextEditingController newemail = TextEditingController();
  late var firstnamecontroller = TextEditingController();
  late var lastnamecontroller = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Directionality(
                textDirection:
                    // ignore: unrelated_type_equality_checks
                     LocalizeAndTranslate.getLanguageCode() == 'en'
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                child: Form(
                    key: _globalKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              height: 100,
                              decoration: const BoxDecoration(
                                  color: CustomColors.MainColor,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(40),
                                      bottomLeft: Radius.circular(40))),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: 30, left: 30, top: 30),
                                child: Row(children: <Widget>[
                                    GestureDetector(
                                    onTap: () {
                              Get.back();
                              },
                                  child:  SizedBox(
                                      width: 30,
                                      child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 26,
                                  ))),
                                  Text(
                                       LocalizeAndTranslate.translate("change user data"),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'ReadexPro',
                                        color: Colors.white,
                                      ),
                                    ),

                              ]))),
                          SizedBox(
                            height: 130.h,
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 25.h, right: 25.w, left: 25.w),
                              child: CustomTextField(
                                hint:  LocalizeAndTranslate.translate("enter mob"),
                                w: 100.w,
                                OnTab: () {},
                                controller: newmobile,
                              )),
                         Padding(
                padding:
                    EdgeInsets.only(top: 28.h, right: 28.w, left: 28.w, bottom: 5.h),
                child: SizedBox(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 158.w,
                        child: CustomTextField(
                          hint:  LocalizeAndTranslate.translate("firstname"),
                          w: 145.w,
                          OnTab: () {},
                          controller: firstnamecontroller,
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 158.w,
                        child: CustomTextField(
                          hint:  LocalizeAndTranslate.translate("lastname"),
                          w: 147.w,
                          OnTab: () {},
                          controller: lastnamecontroller,
                        ),
                      )
                    ],
                  ),
                )),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 25.h, right: 25.w, left: 25.w),
                              child: CustomTextField(
                                hint:  LocalizeAndTranslate.translate("enter email"),
                                w: 100.w,
                                OnTab: () {},
                                controller: newemail,
                              )),
                          SizedBox(
                            height: 45.h,
                          ),
                          GestureDetector(
                            onTap: () async{
                              AuthApi authApi = AuthApi();
                              if (_globalKey.currentState!.validate()) {
                                _globalKey.currentState!.save();
                              await  authApi
                                    .changeprofile(firstnamecontroller.text +' '+lastnamecontroller.text, newmobile.text,
                                        newemail.text, context)
                                    .then((value) {
                                    EasyLoading.show(
                                                      status:  LocalizeAndTranslate
                                                                  .getLanguageCode() ==
                                                              'ar'
                                                          ? 'جاري التحميل '
                                                          : 'loading...',
                                                      maskType:
                                                          EasyLoadingMaskType
                                                              .black);
                                  openAlert(value["message"],value['status']);
                                });
                              }
                            },
                            child: Container(
                              height: 50.h,
                              margin:
                                  EdgeInsets.symmetric(horizontal: 29.w),
                              decoration: BoxDecoration(
                                color: CustomColors.MainColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                   LocalizeAndTranslate.translate("update data"),
                                  style: const TextStyle(
                                      fontFamily: 'ReadexPro',
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ])))));
  }

  void openAlert(String mess,bool status) {
    var screenHeight =MediaQuery.of(context).size.height;
       EasyLoading.dismiss();
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor:Color(0xfFFfffff),
      elevation: 4,
      //this right here
      child: Container(
        height: screenHeight*.18,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.only(top: 16.h),
          //   decoration: boxDecorationStylealert,
          width: 230.w,
          padding: EdgeInsets.symmetric(horizontal: 10.w),

          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text(status==false?"Failed":"SUCCESS",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 5,),
              Center(
                child: Text(
                  mess,
                ),
              ),
              //Spacer(),
              SizedBox(height:4),
              Center(
                child:  Padding(
                    padding:
                        EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h, bottom: 0),
                    child: MaterialButton(
                      onPressed: () async {
                        Get.off(login());
                      },
                      color: CustomColors.MainColor,
                      // ignore: sort_child_properties_last
                      child: Text(
                        "OK",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),

              )
            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
