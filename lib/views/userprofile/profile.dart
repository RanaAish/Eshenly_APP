
// ignore_for_file: deprecated_member_use

import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/views/Login/login.dart';
import 'package:esh7enly/views/userprofile/ReturnPolicy.dart';
import 'package:esh7enly/views/userprofile/termsconditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Accountsetting.dart';
import '../Service/showtransactions.dart';

// ignore: camel_case_types
class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

// ignore: camel_case_types
class _profileState extends State<profile> {
  final storage = const FlutterSecureStorage();
  String? username;
  String? phone;

  void cleanUp() async {
    await storage.delete(key: 'token');
   // await storage.delete(key: 'mobile');
    await storage.delete(key: 'name');
    await storage.delete(key: 'key');
  }

  getphone() async {
    await storage.read(key: 'mobile').then((value) {
      setState(() {
        phone = value!;
      });
    });
  }

  getusername() async {
    await storage.read(key: 'name').then((value) {
      setState(() {
        username = value!;
      });
    });
  }

  @override
  void initState() {
  
    getusername();
    getphone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List texts = [
    
      "    ${ LocalizeAndTranslate.translate("account")}",
    
      "    ${ LocalizeAndTranslate.translate("payment")}",
    
      "    ${ LocalizeAndTranslate.translate("share")}",

      "    ${ LocalizeAndTranslate.translate("privacy")}",
     
      "    ${ LocalizeAndTranslate.translate("contact")}",

      "    ${ LocalizeAndTranslate.translate("term1")}",
      
      "    ${ LocalizeAndTranslate.translate("term2")}",
      
      "    ${ LocalizeAndTranslate.translate("logout")}"
    ];

    List icons = [
      Icons.settings,
      Icons.payment,
      Icons.share,
      Icons.privacy_tip,
      Icons.call,
      Icons.privacy_tip,
      Icons.call,
      Icons.logout
    ];
    List imgs=[  "assets/refund.PNG",
      "assets/refund.PNG"];

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 245, 245),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
            child: Directionality(
                textDirection:
              
                     LocalizeAndTranslate.getLanguageCode() == 'en'
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 130,
                          decoration: const BoxDecoration(
                              color: CustomColors.MainColor,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(40),
                                  bottomLeft: Radius.circular(40))),
                          child: Padding(
                      padding: const EdgeInsets.only(right: 30, left: 30),
                      child:  Stack(children: <Widget>[
                            Positioned(
                                top: 50,
                               
                                child: Text(
                                  "$username",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'ReadexPro',
                                    color: Colors.white,
                                  ),
                                )),
                            Positioned(
                                top: 88,
                             
                                child: Text(
                                  "$phone",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'ReadexPro',
                                    color: Colors.white,
                                  ),
                                )),
                          ]))),
                      Scrollbar(
                        child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: 400,
                              height: 800,
                              child: ListView.builder(
                                //  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 8,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                        onTap: () async {
                                          if (texts[index] ==
                                              "    Transaction") {
                                            Get.to(const showtransactions());
                                          }
                                          if (texts[index] ==
                                         
                                              "    ${ LocalizeAndTranslate.translate("account")}") {
                                            Get.to(const AccountSetting());
                                          }
                                          if (texts[index] ==
                                              "    ${ LocalizeAndTranslate.translate("logout")}") {
                                            cleanUp();
                                            Get.offAll(const login());
                                          }
                                          if (texts[index] ==
                                              "    ${ LocalizeAndTranslate.translate("share")}") {
                                            Share.share(
                                                'https://play.google.com/store/apps/details?id=com.esh7enly.esh7enlyuser');
                                          }
                                          if (texts[index] ==
                                              "    ${ LocalizeAndTranslate.translate("contact")}") {
                                            launch("tel://19276");
                                          }
                                          if (texts[index] ==
                                              "    ${ LocalizeAndTranslate.translate("payment")}") {
                                            Get.to(const showtransactions());
                                          }
                                            if (texts[index] == 
                                              "    ${ LocalizeAndTranslate.translate("privacy")}") {
                                                final Uri url = Uri.parse("https://e-esh7nly.com/about-us/");
                                               await (launchUrl(url));
                                          }
    if (texts[index] ==
        "    ${ LocalizeAndTranslate.translate("term1")}") {
      Get.to(terms());
    }
    if (texts[index] ==
    "    ${ LocalizeAndTranslate.translate("term2")}")
    {Get.to(ReturnPolicy());}
                                        },
                                        child: Container(
                                            height: 50,
                                            width: 300,
                                            margin: EdgeInsets.only(
                                                left: 20,
                                               top: 8,//10 instead of 13
                                                right: 30,
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      CustomColors.MainColor),
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 19, right: 20),
                                              child: Row(
                                                children: [
                                                 index==6?
                                              Image.asset(
                                                imgs[0],
                                                width: 25,
                                                height: 25,
                                                color:
                                                CustomColors.MainColor,
                                              )
                                                     : Icon(
                                                    icons[index],
                                                    color:
                                                        CustomColors.MainColor,
                                                  ),
                                                  Text(
                                                    texts[index],
                                                    style: const TextStyle(
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
                    ]))));
  }
}
