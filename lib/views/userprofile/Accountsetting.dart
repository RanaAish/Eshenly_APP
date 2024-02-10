// ignore_for_file: deprecated_member_use, unused_local_variable, prefer_const_constructors, unnecessary_string_interpolations, file_names

import 'package:esh7enly/views/userprofile/changeuserdata.dart';
import 'package:esh7enly/views/loadingview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:localize_and_translate/localize_and_translate.dart';

import '../../controlls/Homviewmodel.dart';
import '../../core/utils/colors.dart';
import '../Login/changepassword.dart';

import '../../../models/language.dart';
import 'package:esh7enly/Services/features/Notification.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  int _radioSelected =  LocalizeAndTranslate.getLanguageCode() == 'ar' ? 1 : 2;
  String? lang;
  List output = [];
  _showAlertDialog(BuildContext context) {
    HomeViewModel obj = HomeViewModel();
    return showDialog(

      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:Color(0xfFFfffff),
          elevation: 4,
          title: Text('Choose app language'),
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              ListTile(
                title: Text('العربيه'),
                leading: Radio(
                  value: 1,
                  groupValue: _radioSelected,
                  onChanged: (value) {
                    setState(() {
                      _radioSelected = value!;
                      lang = "ar";
                       LocalizeAndTranslate.setLanguageCode(
                        languge.languageslist()[1].languagecode,
                      );
                      // restart: true);

                      Get.offAll(Loading());
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('English'),
                leading: Radio(
                  value: 2,
                  groupValue: _radioSelected,
                  onChanged: (value) {
                    setState(() {
                      _radioSelected = value!;
                      lang = "en";
                       LocalizeAndTranslate.setLanguageCode(
                        languge.languageslist()[0].languagecode,
                      );
                      //restart: true);

                      Get.offAll(Loading());
                    });
                  },
                ),
              ),
            ],
          )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List texts = [
      "    ${ LocalizeAndTranslate.translate("changepassword")}",
      "    ${ LocalizeAndTranslate.translate("changeusername")}",
      "    ${ LocalizeAndTranslate.translate("change lang")}",
      "    ${ LocalizeAndTranslate.translate("bills")}",
    ];

    List icons = [
      "assets/Change Password.svg",
      'assets/icon-04.svg',
      "assets/change language.svg",
      "assets/billsicon.PNG"
    ];

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 245, 245),
        body: SingleChildScrollView(
            child: Directionality(
                textDirection:
                    // ignore: unrelated_type_equality_checks
                     LocalizeAndTranslate.getLanguageCode() == 'en'
                        ? TextDirection.ltr
                        : TextDirection.rtl,
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
                          child:  Padding(
                              padding:
                              EdgeInsets.only(right: 30, left: 30, top: 30),
                              child: Row(children: <Widget>[
                                  SizedBox(
                                  width: 30,
                                  child: GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 26,
                                      ))),
                                SizedBox(
                                  width: 30,
                                  child: SvgPicture.asset(
                                    "assets/account setting .svg",
                                    color: Colors.white,
                                    width: 23,
                                    height: 23,
                                  ),
                                ),
                                Text(
                                  '${ LocalizeAndTranslate.translate("account")}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'ReadexPro',
                                  ),
                                ),]))),


                      Scrollbar(
                        child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: 400,
                              height: 380,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: 4,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                        onTap: () {
                                          if (texts[index] ==
                                              "    ${ LocalizeAndTranslate.translate("changepassword")}") {
                                            Get.to(changepassword());
                                          }
                                          if (texts[index] ==
                                              "    ${ LocalizeAndTranslate.translate("change lang")}") {
                                            _showAlertDialog(context);
                                          }
                                          if (texts[index] ==
                                              "    ${ LocalizeAndTranslate.translate("changeusername")}") {
                                            Get.to(changeuserdata());
                                          }
                                          if (texts[index] ==
                                              "    ${ LocalizeAndTranslate.translate("bills")}") {
                                            EasyLoading.show(
                                                status:  LocalizeAndTranslate
                                                            .getLanguageCode() ==
                                                        'ar'
                                                    ? 'جاري التحميل '
                                                    : 'loading...',
                                                maskType:
                                                    EasyLoadingMaskType.black);
                                            NotificationApi()
                                                .scdulelist(context)
                                                .then((value) {
                                              if (value.length != 0) {
                                                EasyLoading.dismiss();

                                                setState(() {
                                                  output = value;
                                                  print(output.length);
                                                });
                                              }
                                            });
                                          }
                                        },
                                        child: Container(
                                            height: 50,
                                            width: 300,
                                            margin:  EdgeInsets.only(
                                                left: 40,
                                                top: 10,
                                                right: 40,
                                                bottom: index==4?0:35),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      CustomColors.MainColor),
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 19, right: 20),
                                              child: Row(
                                                children: [
                                                  index==3?Image.asset( icons[index],
                                                    color:
                                                    CustomColors.MainColor,
                                                    width: 25,
                                                    height: 25,):SvgPicture.asset(
                                                    icons[index],
                                                    color:
                                                        CustomColors.MainColor,
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                  Text(
                                                    texts[index],
                                                    style: TextStyle(
                                                        fontFamily: 'ReadexPro',
                                                        color: CustomColors
                                                            .MainColor),
                                                  )
                                                ],
                                              ),
                                            )));
                                  }),
                            )),
                      ),
                      output.length == 0
                          ? SizedBox(
                              width: 0,
                              height: 0,
                            )
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: output.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    height: 50,
                                    width: 300,
                                    margin:  EdgeInsets.only(
                                        left: 40,
                                        top: index==0?0:5,
                                        right: 40,
                                        bottom: 5),
                                    decoration: BoxDecoration(
                                      
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 19, right: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                             LocalizeAndTranslate.getLanguageCode() == 'en'
                                                ? output[index].nameen
                                                : output[index].namear,
                                            style: TextStyle(
                                                fontFamily: 'ReadexPro',
                                                color: CustomColors.MainColor),
                                          ),
                                          Text(
                                            output[index].scduledate.toString(),
                                            style: TextStyle(
                                                fontFamily: 'ReadexPro',
                                                color: CustomColors.MainColor),
                                          )
                                        ],
                                      ),
                                    ));
                              })
                    ]))));
  }
}
