// ignore_for_file: unnecessary_import, unused_import, camel_case_types, deprecated_member_use, prefer_const_constructors, prefer_const_declarations

import 'package:esh7enly/core/widgets/customtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../../Services/features/AuthApi.dart';
import '../../core/utils/colors.dart';
import '../../core/widgets/CustomTextField.dart';
import '../../core/widgets/header.dart';
import 'login.dart';
import 'otpauth.dart';
import 'package:esh7enly/core/widgets/daioulge.dart';

class otp extends StatefulWidget {
  final check;
  const otp({Key? key,required this.check}) : super(key: key);

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  late var phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        children: [
                          header(
                            heightcon: 210,
                          ),
                          const SizedBox(
                            height: 130,
                          ),
                          customtext(
                            maxLine: 2,
                            color: CustomColors.MainColor,
                            fontSize: 20, //23
                            fontfamily: 'ReadexPro',
                            text:  LocalizeAndTranslate.translate("otp msg1"),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          customtext(
                            maxLine: 2,
                            color: CustomColors.MainColor,
                            fontSize: 20, //23
                            fontfamily: 'ReadexPro',
                            text:  LocalizeAndTranslate.translate("otp msg2"),
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 30, right: 45, left: 45),
                              child: CustomTextField(
                                hint:  LocalizeAndTranslate.translate('enter phone'),
                                w: 60,
                                OnTab: () {},
                                controller: phonecontroller,
                              )),
                          SizedBox(height: 45),
                          GestureDetector(
                              onTap: () {
                                if (_globalKey.currentState!.validate()) {
                                  _globalKey.currentState!.save();
               validatefunc();
                                }
                              },
                              child: Container(
                                  height: 50,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 43),
                                  decoration: BoxDecoration(
                                    color: CustomColors.MainColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                       LocalizeAndTranslate.translate('send otp'),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'ReadexPro',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ))),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                             LocalizeAndTranslate.translate("reply send otp"),
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ])))));
  }
  validatefunc()
  {
    if(widget.check==1)
      {
        AuthApi object = AuthApi();
        final storage = const FlutterSecureStorage();
        if (phonecontroller.text.length != 11) {
          DailogAlert.openbackAlert(
               LocalizeAndTranslate.translate("msgmob"),
               LocalizeAndTranslate.translate("failedmessage"),
              context);
        } else {
          object.Sendotp(phonecontroller.text)
              .then((value) {
            if (value["status"] == true) {
              EasyLoading.show(
                  status:  LocalizeAndTranslate.getLanguageCode() == 'ar'
                      ? 'جاري التحميل '
                      : 'loading...',
                  maskType: EasyLoadingMaskType.black);
              storage.write(
                  key: 'mobile',
                  value: phonecontroller.text);
                 EasyLoading.dismiss();
              Get.to(const otpauth(check: 1,),arguments: phonecontroller.text);
            } else if (value["data"][
            "middleware_validation_error"]
            ["mobile"][0] ==
                "The mobile has already been taken.") {
              EasyLoading.dismiss();
              DailogAlert.openAlert(
                  'The mobile has already been taken',
                   LocalizeAndTranslate
                      .translate("failedmessage"),
                  context);

              storage.write(
                  key: 'verifyotp', value: "true");


            } else {
              EasyLoading.dismiss();
              DailogAlert.openbackAlert(
                  value['message'],
                   LocalizeAndTranslate
                      .translate("failedmessage"),
                  context);
            }
          });
        }
      }
    if(widget.check==2)
      {
        AuthApi authApi = AuthApi();
        if (phonecontroller.text.length !=11){
          DailogAlert.openbackAlert(
               LocalizeAndTranslate.translate("msgmob"),
               LocalizeAndTranslate.translate("failedmessage"),
              context);
          EasyLoading.dismiss();
        }
        else
        {
          authApi.forgetpassword(phonecontroller.text,context);
          Get.to(otpauth(check: 2,),arguments: phonecontroller.text);
        }

      }

  }
}
