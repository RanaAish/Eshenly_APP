// ignore_for_file: unnecessary_import, camel_case_types, deprecated_member_use, prefer_const_constructors

import 'package:esh7enly/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../controlls/Homviewmodel.dart';
import '../../views/HomeScreen/controllhome.dart';
import 'package:bottom_indicator_bar_svg/bottom_indicator_bar_svg.dart';

class bottomnavigationbar extends StatelessWidget {
  bottomnavigationbar({Key? key}) : super(key: key);
  final List<BottomIndicatorNavigationBarItem> items = [
    BottomIndicatorNavigationBarItem(icon: Icons.home, label: Text('Home')),
    BottomIndicatorNavigationBarItem(icon: Icons.search, label: 'Search'),
    BottomIndicatorNavigationBarItem(icon: '', label: 'Svg'),
    BottomIndicatorNavigationBarItem(
      icon: 'assets/inactiveIcon.svg',
      activeIcon: 'assets/activeIcon.svg',
      label: 'Account',
    ),
  ]; 
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
        init: HomeViewModel(),
        builder: (controler) => Directionality(
            textDirection:
                // ignore: unrelated_type_equality_checks
                 LocalizeAndTranslate.getLanguageCode() == 'en'
                    ? TextDirection.ltr
                    : TextDirection.rtl,
            child:Container(    
            height:    LocalizeAndTranslate.getLanguageCode()=='en'?55:63,                                        
  decoration: BoxDecoration(                                                   
    borderRadius: BorderRadius.only(                                           
      topRight: Radius.circular(30), topLeft: Radius.circular(30)),            
    boxShadow: const [                                                               
      BoxShadow(color: Colors.transparent, spreadRadius: 0, blurRadius: 0),       
    ],                                                                         
  ),                                                                           
  child: ClipRRect(                                                            
    borderRadius: BorderRadius.only(                                           
    topLeft: Radius.circular(30.0),                                            
    topRight: Radius.circular(30.0),                                           
    ),                                                                         
    child:ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0), ),
        child:BottomNavigationBar(
          elevation: 0.0,
          currentIndex: controler.navigatovalue,
          type: BottomNavigationBarType.fixed,
          backgroundColor:CustomColors.SecondryColor,   
            selectedItemColor: Colors.white,
                    selectedLabelStyle: TextStyle(color: Colors.white),
                     unselectedLabelStyle: TextStyle(color: CustomColors.SecondryColor),
                     showUnselectedLabels: false,
                      onTap: (selectedvalue) {
                      controler.changeselectedvalue(selectedvalue);
                      Get.offAll(Controllhomeview());
                    },
                   // type: BottomNavigationBarType.fixed,
                    // ignore: prefer_const_literals_to_create_immutables                                      
         items:  <BottomNavigationBarItem>[                                        
         BottomNavigationBarItem(                            
          icon: Image.asset('assets/gift .png',width: 30,height: 20,),label: LocalizeAndTranslate.translate("gift")),
        BottomNavigationBarItem(                                               
          icon: Image.asset('assets/icon-03.png',width: 30,height: 20,), label: LocalizeAndTranslate.translate("support")),
            BottomNavigationBarItem(                                               
          icon: Image.asset('assets/icon-05.png',width: 30,height: 20), label:   LocalizeAndTranslate.translate("home screen")) ,
            BottomNavigationBarItem(                                               
          icon: Image.asset('assets/icon-06.png',width: 30,height: 20), label:  LocalizeAndTranslate.translate("balance"))  ,
          BottomNavigationBarItem(                                               
          icon: Image.asset('assets/icon-04.png',width: 30,height: 20), label:  LocalizeAndTranslate.translate("profile"))  ,
      ],                                                                       
    ),
                  ))
              
  )));
  }
}
