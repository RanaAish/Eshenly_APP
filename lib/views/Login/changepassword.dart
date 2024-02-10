// ignore_for_file: unnecessary_import, unused_import, camel_case_types, deprecated_member_use, prefer_const_constructors, unnecessary_new, unnecessary_brace_in_string_interps

import 'package:esh7enly/Services/features/AuthApi.dart';
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../core/utils/colors.dart';
import '../../core/widgets/CustomTextField.dart';
import '../../core/widgets/header.dart';

class changepassword extends StatefulWidget {
  const changepassword({super.key});

  @override
  State<changepassword> createState() => _changepasswordState();
}

class _changepasswordState extends State<changepassword> {
  bool passwordsecure = true;
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController password3 = TextEditingController();
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
                              child:Padding(
                                padding: EdgeInsets.only(
                                    right: 30, left: 30, top: 28),
                                child: Row(children: <Widget>[
                                  GestureDetector(
                                    child:  SizedBox(
                                  width: 30,
                                  child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 26,
                                    ),),
                                    onTap: () {
                                      Get.back();
                                    },
                                  ),
                              SizedBox(width: 3,),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                         LocalizeAndTranslate.translate("change password"),
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontFamily: 'ReadexPro',
                                          color: Colors.white,
                                        ),
                                      ),
                                  ),

                              ]))),
                          SizedBox(
                            height: 130,
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 25, right: 25, left: 25),
                              child: CustomTextField(
                                hint:  LocalizeAndTranslate.translate("current pass"),
                                w: 100,
                                OnTab: () {},
                                controller: password1,
                                obsesure: passwordsecure,
                                suffic: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordsecure = !passwordsecure;
                                    });
                                  },
                                  icon: passwordsecure
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                              )),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 25, right: 25, left: 25),
                              child: CustomTextField(
                                hint:  LocalizeAndTranslate.translate("new pass"),
                                w: 100,
                                OnTab: () {},
                                controller: password2,
                                obsesure: passwordsecure,
                                suffic: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordsecure = !passwordsecure;
                                    });
                                  },
                                  icon: passwordsecure
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 14, right: 26, left: 26, bottom: 5),
                              child: Text(
                                 LocalizeAndTranslate.translate("passwordcodition"),
                                style: TextStyle(
                                    color: CustomColors.MainColor,
                                    fontSize: 15),
                              )),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 12, right: 25, left: 25),
                              child: CustomTextField(
                                hint:  LocalizeAndTranslate.translate("reply new pass"),
                                w: 100,
                                OnTab: () {},
                                controller: password3,
                                obsesure: passwordsecure,
                                suffic: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordsecure = !passwordsecure;
                                    });
                                  },
                                  icon: passwordsecure
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                              )),
                          SizedBox(
                            height: 35,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_globalKey.currentState!.validate()) {
                                validatefunc();
                              }
                            },
                            child: Container(
                              height: 50,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 29),
                              decoration: BoxDecoration(
                                color: CustomColors.MainColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                   LocalizeAndTranslate.translate("change password"),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'ReadexPro',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ])))));
  }
  validatefunc()
  {
    EasyLoading.show(
        status:  LocalizeAndTranslate.getLanguageCode() == 'ar'
            ? 'جاري التحميل '
            : 'loading...',
        maskType: EasyLoadingMaskType.black);
    _globalKey.currentState!.save();
    AuthApi object = new AuthApi();
    if (password2.text.trim() ==
        password3.text.trim()) {
      RegExp regex = RegExp(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[%!@#\$&*~]).{8,}$');

      if (!regex.hasMatch(password2.text)) {
        EasyLoading.dismiss();
        DailogAlert.openbackAlert('Enter valid password',
             LocalizeAndTranslate.translate("Warning"), context);
      }
      else {
        EasyLoading.dismiss();
        object.changepassword(
            password1.text, password2.text, context)
            .then((value) {
              if(value['status']==false)
                {
                  DailogAlert.openbackAlert(
                      '${value["message"]}',
                       LocalizeAndTranslate.translate(
                          "failedmessage"),
                      context);
                }
              else
                {
                  DailogAlert.openAlert(
                      '${value["message"]}',
                       LocalizeAndTranslate.translate(
                          "suceessmessage"),
                      context);
                }

        });
      }


    } else {
      EasyLoading.dismiss();
      DailogAlert.openbackAlert(
          'password don\'t match',
           LocalizeAndTranslate.translate("failedmessage"),
          context);
    }
  }
}
