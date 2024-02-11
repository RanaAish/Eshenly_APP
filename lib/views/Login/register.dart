// ignore_for_file: unused_import, camel_case_types, prefer_const_constructors, deprecated_member_use, prefer_const_declarations, use_build_context_synchronously
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:esh7enly/views/Login/otpauth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:unique_identifier/unique_identifier.dart';
import '../../Services/features/AuthApi.dart';
import '../../core/utils/colors.dart';
import '../../core/widgets/CustomTextField.dart';
import '../../core/widgets/customebuttun.dart';
import '../../core/widgets/customtext.dart';
import 'package:esh7enly/views/Login/login.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../core/widgets/header.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  late var namecontroller = TextEditingController();
  late var firstnamecontroller = TextEditingController();
  late var lastnamecontroller = TextEditingController();
  late var emailcontroller = TextEditingController();
  late var passwordcontroller = TextEditingController();
  late var confirmpasswordcontroller = TextEditingController();
  bool passwordsecure = true;
  bool passwordsecureconfirm = true;
  bool remeberme = false;
  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth=MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
            child: Directionality(
      textDirection:
          // ignore: unrelated_type_equality_checks
           LocalizeAndTranslate.getLanguageCode() == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      child:   Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            header(
              heightcon: screenheight*.24,
            ),
            SizedBox(
              height: screenheight/30,
            ),
            Center(
                child: Text(
               LocalizeAndTranslate.translate("register"),
              style: TextStyle(
                color: CustomColors.MainColor,
                fontSize: 24,
                fontFamily: 'ReadexPro',
              ),
            )),
                Padding(
                  padding:
                  EdgeInsets.only(top: screenheight/35, right: screenwidth/17, left: screenwidth/17,),
                  child:Form(
                    key: _globalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
            SizedBox(
                  child:Row(
                    
                    children: [
                      SizedBox(
                        width:screenheight*.18,
                        child: CustomTextField(
                          hint:  LocalizeAndTranslate.translate("firstname"),
                          w:screenwidth*.3,
                          OnTab: () {},
                          controller: firstnamecontroller,
                        ),
                      ),
                      SizedBox(
                        width: screenwidth/50,
                      ),

                      SizedBox(
                        width: screenheight*.18,
                        child: CustomTextField(
                          hint:  LocalizeAndTranslate.translate("lastname"),
                          w: screenwidth*.3,
                          OnTab: () {},
                          controller: lastnamecontroller,
                        ),
                      )
                    ],
                  ),),
SizedBox(height: screenheight/60,),
           CustomTextField(
                  hint:  LocalizeAndTranslate.translate("password"),

                  OnTab: () {},
                  controller: passwordcontroller,
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
                ),
                        SizedBox(height: screenheight/80),
            Text(
                   LocalizeAndTranslate.translate("passwordcodition"),
                  style: TextStyle(color: CustomColors.MainColor, fontSize: 15),
                ),
                        SizedBox(height: screenheight/60),
            CustomTextField(
                  hint:  LocalizeAndTranslate.translate("confirm pass"),

                  OnTab: () {},
                  controller: confirmpasswordcontroller,
                  obsesure: passwordsecureconfirm,
                  suffic: IconButton(
                    onPressed: () {
                      setState(() {
                        passwordsecureconfirm = !passwordsecureconfirm;
                      });
                    },
                    icon: passwordsecureconfirm
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
                ),
                        SizedBox(height: screenheight/60),
           CustomTextField(
                  hint:  LocalizeAndTranslate.translate("em"),

                  OnTab: () {},
                  controller: emailcontroller,
                ),
          SizedBox(
              height: screenheight/90,
            ),
            Row(
              children: [
                 Checkbox(
                    activeColor: remeberme ? Colors.blue : Colors.white,
                    checkColor: CustomColors.MainColor,
                    value: remeberme,
                    onChanged: (bool? value) {
                      setState(() {
                        remeberme = value!;
                      });
                    },
                  ),
                SizedBox(height: screenheight/60),
                Text(
                   LocalizeAndTranslate.translate("confirm"),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'ReadexPro',
                  ),
                ),
              ],
            ),
           SizedBox(
              height:screenheight/90,
            ),
            GestureDetector(
                onTap: () async {
                  print(firstnamecontroller.text +lastnamecontroller.text);
                  final storage = const FlutterSecureStorage();

                  var mobile = await storage.read(key: 'mobile');

                  if (_globalKey.currentState!.validate()) {
                    _globalKey.currentState!.save();
                    EasyLoading.show(
                        status:  LocalizeAndTranslate.getLanguageCode() == 'ar'
                            ? 'جاري التحميل '
                            : 'loading...',
                        maskType: EasyLoadingMaskType.black);
                    if (passwordcontroller.text.trim() ==
                        confirmpasswordcontroller.text.trim()) {
                      if (remeberme == true) {
                        AuthApi object = AuthApi();
                        String? identifier = await UniqueIdentifier.serial;

                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[%!@#\$&*~]).{8,}$');

                        if (!regex.hasMatch(passwordcontroller.text)) {
                          EasyLoading.dismiss();
                          DailogAlert.openbackAlert('Enter valid password',
                               LocalizeAndTranslate.translate("Warning"), context);
                        } else {
                          object
                              .register(
                                  mobile!,
                                  identifier!,
                                  passwordcontroller.text,
                                 firstnamecontroller.text +' '+lastnamecontroller.text,
                                  emailcontroller.text)
                              .then((value) {
                            if (value["status"] == true) {
                              EasyLoading.dismiss();
                              DailogAlert.openAlert(
                                  value['message'],
                                   LocalizeAndTranslate.translate("suceessmessage"),
                                  context);
                              // Get.to(login());
                            } else {
                              EasyLoading.dismiss();
                              DailogAlert.openbackAlert(
                                  value['message'],
                                   LocalizeAndTranslate.translate("failedmessage"),
                                  context);
                            }
                          });
                        }
                        //mobile!
                      } else {
                        EasyLoading.dismiss();
                        DailogAlert.openbackAlert(
                            'please , Agree on conditions',
                             LocalizeAndTranslate.translate("failedmessage"),
                            context);
                      }
                    } else {
                      EasyLoading.dismiss();
                      DailogAlert.openbackAlert('password don\'t match',
                           LocalizeAndTranslate.translate("failedmessage"), context);
                    }
                  }
                },
                child: Container(
                  height: screenheight/18,
                  margin: const EdgeInsets.symmetric(horizontal: 29),
                  decoration: BoxDecoration(
                    color: CustomColors.MainColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                     LocalizeAndTranslate.translate('login now'),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ReadexPro',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )),
                )),
           SizedBox(
              height: screenheight/90,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                     LocalizeAndTranslate.translate("have account"),
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontFamily: 'ReadexPro',
                        fontWeight: FontWeight.w300,
                        fontSize: 18),
                  ),
                SizedBox(
                    width: screenheight/90,
                  ),
                  GestureDetector(
                      onTap: () async {
                        Get.to(login());
                      },
                      child: Text( LocalizeAndTranslate.translate("signin"),
                          style: TextStyle(
                            color: CustomColors.MainColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ReadexPro',
                            fontSize: 18,
                          )))
                ]),
          ],
        ),
    ))]))));
  }
}
