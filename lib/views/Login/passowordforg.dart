// ignore_for_file: camel_case_types, prefer_const_constructors, deprecated_member_use, prefer_const_declarations

import 'package:esh7enly/Services/features/AuthApi.dart';
import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/core/widgets/CustomTextField.dart';
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:esh7enly/views/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class passwordforg extends StatefulWidget {
  const passwordforg({super.key});

  @override
  State<passwordforg> createState() => _passwordforgState();
}

class _passwordforgState extends State<passwordforg> {
  bool passwordsecure = true;
  bool passwordsecureconfirm = true;
  TextEditingController password = TextEditingController();
  TextEditingController passwordconfirm = TextEditingController();
  var mobile = Get.arguments;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
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
                              padding:
                                  EdgeInsets.only(right: 30, left: 30, top: 30),
                              child: Row(children: <Widget>[
                                SizedBox(
                                    width: 30,
                                    height: 40,
                                    child: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                          size: 26,
                                        ))),
                                Text(
                                   LocalizeAndTranslate.translate("change password"),
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'ReadexPro',
                                    color: Colors.white,
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
                            hint:  LocalizeAndTranslate.translate("new pass"),
                            w: 100,
                            OnTab: () {},
                            controller: password,
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
                              top: 10, right: 26, left: 26, bottom: 5),
                          child: Text(
                             LocalizeAndTranslate.translate("passwordcodition"),
                            style: TextStyle(
                                color: CustomColors.MainColor,
                                fontSize: 15),
                          )),
                      Padding(
                          padding:
                              EdgeInsets.only(top: 25, right: 25, left: 25),
                          child: CustomTextField(
                            hint:  LocalizeAndTranslate.translate("reply new pass"),
                            w: 100,
                            OnTab: () {},
                            controller: passwordconfirm,
                            obsesure: passwordsecureconfirm,
                            suffic: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordsecureconfirm =
                                      !passwordsecureconfirm;
                                });
                              },
                              icon: passwordsecure
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                            ),
                          )),
                      SizedBox(
                        height: 45,
                      ),
                      GestureDetector(
                        onTap: () {
                         validatefunc(screenHeight);
                        },
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 29),
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
                        )),

                    ])))));
  }
  validatefunc(var h)
  {
    AuthApi authApi = AuthApi();
    final storage = const FlutterSecureStorage();
    if (password.text.trim() ==
        passwordconfirm.text.trim()) {
      RegExp regex = RegExp(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[%!@#\$&*~]).{8,}$');

      if (!regex.hasMatch(password.text)) {
        EasyLoading.dismiss();
        DailogAlert.openbackAlert('Enter valid password',
             LocalizeAndTranslate.translate("Warning"), context);
      } else {
        storage.read(key: 'otpforgetpass').then((value) {
          authApi
              .postnewpassword(
              mobile,
              value!,
              password.text,
              passwordconfirm.text,
              context)
              .then((value1) {
            DailogAlert.openAlert(value1,"Success",context);
            //showAlertDialog(context, value1);
          });
        });
      }
    } else {
      EasyLoading.dismiss();
      DailogAlert.openbackAlert('password don\'t match',
           LocalizeAndTranslate.translate("failedmessage"), context);
    }

    //  Get.to(login());
  }

}
