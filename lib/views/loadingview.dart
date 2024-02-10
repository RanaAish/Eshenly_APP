// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:esh7enly/Services/features/BankApi.dart';
import 'package:esh7enly/views/onbroadingscreens/onbroadingpage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../core/utils/colors.dart';
import 'Login/login.dart';
import 'HomeScreen/controllhome.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool checkauth = false;


  static const storage = FlutterSecureStorage();
  //final CategoryApi _categoryApi = CategoryApi();
  BankApi bank = BankApi();
  String? balance = "";

  @override
  void initState() {
    
    Future.delayed(const Duration(seconds: 3), () {
      //Get.offAll(login());
      storage.containsKey(key: 'onbreoading').then((value) {
        setState(() {
          checkauth = value;
          // print(value);
          //print(value.runtimeType);
        });
        bank.getbalance().then((value) {
          setState(() {
            balance = value;
            checkIfLogged();

           
          });
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth =MediaQuery.of(context).size.width;
    var screenHeight =MediaQuery.of(context).size.height;
    print(screenHeight);
    return Scaffold(
      backgroundColor: CustomColors.MainColor,
      body: SingleChildScrollView(
        child: Center(
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
               SizedBox(
                height:screenHeight*.33,
              ),
              Image.asset(
                "assets/logo.png",
                width: 350,
                height: 350,
              ),
              Text(
                // ignore: deprecated_member_use
                 LocalizeAndTranslate.translate("caption"),
                style: const TextStyle(
                    color: Colors.white, fontSize: 16, fontFamily: 'ReadexPro'),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                // ignore: deprecated_member_use
                 LocalizeAndTranslate.translate("caption2"),
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'ReadexPro',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ])),
      ),
    );
  }

  dynamic checkIfLogged()  {

    if (checkauth == false) {
      Get.offAll(const onbroadingpage());
    } else {
      storage.containsKey(key: 'auth').then((value) {
        if (value == true) {
          if (balance == null) {
            Get.offAll(const login());
          } else {
            Get.offAll(Controllhomeview());
          }
        } else {
          Get.offAll(const login());
        }
      });
    }
  }
}


