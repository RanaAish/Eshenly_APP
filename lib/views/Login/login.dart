// ignore_for_file: unused_import, camel_case_types, prefer_typing_uninitialized_variables, deprecated_member_use, prefer_const_constructors, prefer_const_declarations, unused_local_variable

import 'package:esh7enly/core/widgets/CustomTextField.dart';
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:esh7enly/views/Login/changepassword.dart';

import 'package:esh7enly/views/Login/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:unique_identifier/unique_identifier.dart';
import '../../Services/features/AuthApi.dart';
import '../../core/utils/colors.dart';
import '../../core/widgets/header.dart';
import '../../models/language.dart';
import '../HomeScreen/controllhome.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool hide = true;
  TextEditingController password = TextEditingController();
  late var phonecontroller = TextEditingController();
  bool? remeberme = false;
  var textlang = "English";
  bool passwordsecure = true;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();
  var token;
  getremeberme() async {
    await storage.read(key: 'remeberme').then((value) {
      setState(() {
        if (value != null) {
          remeberme = value.trim() == "true" ? true : false;
        }
      });
    });
  }

  @override
  void initState() {
    getremeberme();
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth=MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Directionality(
          textDirection:
              // ignore: unrelated_type_equality_checks
               LocalizeAndTranslate.getLanguageCode() == 'en'
                  ? TextDirection.ltr
                  : TextDirection.rtl,
          child:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                header(
                  heightcon: screenheight*.24,
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Text(
                   LocalizeAndTranslate.translate('welcome'),
                  style: TextStyle(
                      color: CustomColors.MainColor,
                      fontSize: 24,
                      fontFamily: 'ReadexPro'),
                )),
                SizedBox(
                  height: 8,
                ),
              Form(
                key: _globalKey,
                child: Padding(
                  padding:
                  EdgeInsets.only(top: screenheight/35, right: screenwidth/17, left: screenwidth/17,),
                  child:Column(children: [
                CustomTextField(
                      hint:  LocalizeAndTranslate.translate('enter phone'),

                      type: TextInputType.number,
                      OnTab: () {},
                      controller: phonecontroller,
                    ),
                    SizedBox(
                      height: screenheight/30,
                    ),
                 CustomTextField(
                      hint:  LocalizeAndTranslate.translate("enter pass"),
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
                    ),
                    SizedBox(
                      height: screenheight/30,
                    ),
                Row(
                  children: [
                     Checkbox(
                        activeColor: remeberme! ? Colors.blue : Colors.white,
                        checkColor: CustomColors.MainColor,
                        value: remeberme,
                        onChanged: (bool? value) {
                          setState(() {
                            remeberme = value!;

                            if (remeberme == true) {
                              storage.write(
                                  key: 'remeberme',
                                  value: remeberme.toString());
                            } else {
                              storage.delete(key: 'remeberme');
                              storage.delete(key: 'auth');
                            }
                          });
                        },
                      ),

                    Text(
                       LocalizeAndTranslate.translate("rember"),
                      style: TextStyle(fontSize: 14.sp, fontFamily: 'ReadexPro'),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(otp(check: 2));
                      },
                      child: Text(
                         LocalizeAndTranslate.translate("whats rember pass"),
                        style: TextStyle(
                            color: CustomColors.MainColor,
                            fontSize: 15.sp,
                            fontFamily: 'ReadexPro'),
                      ),
                    )
                  ],
                ),
                    SizedBox(
                      height: screenheight/30,
                    ),
                GestureDetector(
                  onTap: () async {
                    if (_globalKey.currentState!.validate()) {
                      //EasyLoading.showProgress(0.3, status: 'loading...');
                      EasyLoading.show(
                          status:  LocalizeAndTranslate.getLanguageCode() == 'ar'
                              ? 'جاري التحميل '
                              : 'loading...',
                          maskType: EasyLoadingMaskType.black);
                      _globalKey.currentState!.save();
                      AuthApi object = AuthApi();
                      final storage = const FlutterSecureStorage();
                      String? identifier = await UniqueIdentifier.serial;

                      token = 'oooo';
                      if (phonecontroller.text.length != 11){
                        DailogAlert.openbackAlert(
                             LocalizeAndTranslate.translate("msgmob"),
                             LocalizeAndTranslate.translate("failedmessage"),
                            context);
                        EasyLoading.dismiss();
                      } else {
                        await object.Login(phonecontroller.text, identifier!,
                                password.text, '123')
                            .then((value) {
                          print("55 $value");
                         //   if (value != null) {
                          if (value['status'] == true) {
                            //Get.to(home());
                            Get.to(Controllhomeview());
                            EasyLoading.dismiss();
                          } else {
                            DailogAlert.openbackAlert(value['message'],
                                 LocalizeAndTranslate.translate("failedmessage"), context);
                            EasyLoading.dismiss();

                          }
                        //}
                         /*   else
                              {
                                EasyLoading.dismiss();
                                DailogAlert.openbackAlert("Try Again",
                                    LocalizeAndTranslate.translate("failedmessage"), context);
                              }
*/
                            });
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
                         LocalizeAndTranslate.translate("login"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'ReadexPro',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                    SizedBox(
                      height: screenheight/50,
                    ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                         LocalizeAndTranslate.translate("have no account"),
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.w300,
                            fontFamily: 'ReadexPro',
                            fontSize: 18.sp),
                      ),
                      Spacer(),
                      GestureDetector(
                        child: Text( LocalizeAndTranslate.translate("login now"),
                            style: TextStyle(
                              color: CustomColors.MainColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ReadexPro',
                              fontSize: 18.sp,
                            )),
                        onTap: () async {
                          Get.to(otp(check: 1,));
                        },
                      )
                    ]),
                    SizedBox(
                      height: screenheight/70,
                    ),
                GestureDetector(
                    onTap: () async {
                      if (textlang == "English") {
                         LocalizeAndTranslate.setLanguageCode(
                          languge.languageslist()[1].languagecode,
                        ); //  restart: true
                         //LocalizeAndTranslate.isDirectionRTL(context);
                        setState(() {
                          textlang = "العربيه";
                        });
                      } else {
                         LocalizeAndTranslate.setLanguageCode(
                           languge.languageslist()[0].languagecode,
                        ); //  restart: true
                        // LocalizeAndTranslate.isDirectionRTL(context);
                        setState(() {
                          textlang = "English";
                        });
                      }
                    },
                    child: Stack(
                      children: [
                        Center(
                            child: SvgPicture.asset("assets/lang.svg",
                                color: CustomColors.MainColor,
                                width: screenwidth*.1,
                                height: screenwidth*.1)),
                        Positioned(
                          top: screenheight/99,
                          left:  (screenwidth*.1)+screenwidth*.23,
                          child: Center(
                              child: Text(textlang,
                                  style: TextStyle(
                                      fontSize: 17.sp, fontFamily: 'ReadexPro'))),
                        )
                      ],
                    ))
              ],
            ),
          )),],)
        )));
  }

  void init() {
    storage.containsKey(key: 'auth').then((value) async {
      if (value == true) {
        var mobile = await storage.read(key: 'mobile');


        var pass = await storage.read(key: 'pass');

        setState(() {
          phonecontroller.text = mobile!;
          password.text = pass!;
        });
      }
    });
  }
}
