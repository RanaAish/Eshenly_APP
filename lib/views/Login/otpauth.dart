// ignore_for_file: unused_import, camel_case_types, deprecated_member_use, prefer_const_constructors, prefer_const_declarations, unused_local_variable, unnecessary_new

import 'package:esh7enly/Services/features/CategryApi.dart';
import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/views/Login/otp.dart';
import 'package:esh7enly/views/Login/passowordforg.dart';
import 'package:esh7enly/views/Login/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../Services/features/AuthApi.dart';
import '../../core/widgets/customtext.dart';
//
import 'package:sms_autofill/sms_autofill.dart';

import '../../core/widgets/header.dart';
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class otpauth extends StatefulWidget {
  final check;
  const otpauth({Key? key,this.check}) : super(key: key);

  @override
  State<otpauth> createState() => _otpauthState();
}

class _otpauthState extends State<otpauth> {
  String _code = "";
  var mob = Get.arguments;
  @override
  void initState() {
    super.initState();
  }

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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            header(
              heightcon: 220,
            ),
            const SizedBox(
              height: 90,
            ),
            customtext(
              maxLine: 2,
              color: CustomColors.MainColor,
              fontSize: 25,
              fontfamily: 'ReadexPro',
              text:  LocalizeAndTranslate.translate("confirmation"),
            ),
            const SizedBox(
              height: 29,
            ),
            customtext(
              maxLine: 2,
              color: CustomColors.MainColor,
              fontSize: 19,
              fontfamily: 'ReadexPro',
              text:  LocalizeAndTranslate.translate("enter otp1"),
            ),
            const SizedBox(
              height: 10,
            ),
            customtext(
              maxLine: 1,
              text:  LocalizeAndTranslate.translate('enter otp2'),
              fontfamily: 'ReadexPro',
              color: CustomColors.MainColor,
              fontSize: 19,
            ),
            SizedBox(height: 35),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 105),
                child: PinFieldAutoFill(
                  decoration: UnderlineDecoration(
                      textStyle: const TextStyle(
                          fontSize: 20, color: CustomColors.MainColor),
                      colorBuilder: FixedColorBuilder(CustomColors.MainColor)),
                  currentCode: _code,
                  codeLength: 6,
                  onCodeSubmitted: (code) {},
                  onCodeChanged: (code) {
                    if (code!.length == 6) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        _code = code;
                      });
                    }
                  },
                )),
            SizedBox(height: 60),
            GestureDetector(
              onTap: () {
        validatefunc();
              },
              child: Container(
                height: 45,
                margin: const EdgeInsets.symmetric(horizontal: 47),
                decoration: BoxDecoration(
                  color: CustomColors.MainColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                     LocalizeAndTranslate.translate("confirmation2"),
                    style:  TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'ReadexPro',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ])),
    ));
  }
  validatefunc()
  {
    if(widget.check==1)
      {
        AuthApi object = new AuthApi();
        final storage = const FlutterSecureStorage();
        object.Verifyotp(_code).then((value) {
          if (value["status"] == true) {
            Get.to(register());
          } else {
            DailogAlert.openbackAlert(
                value['message'],  LocalizeAndTranslate.translate("failedmessage"), context);

          }
        });
      }
     if(widget.check==2)
       {
         final storage = const FlutterSecureStorage();
         storage.read(key: 'otpforgetpass').then((value) {
           if (_code == value) {
             Get.to(passwordforg(), arguments: mob);
           } else {
             DailogAlert.openbackAlert(
                  LocalizeAndTranslate.translate("Invaild Code"),
                  LocalizeAndTranslate.translate("failedmessage"),
                 context);

           }
         });
       }

  }
}
