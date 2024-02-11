// ignore_for_file: unused_import, unnecessary_import, camel_case_types, unnecessary_new, deprecated_member_use, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
//import 'package:url_launcher_android/url_launcher_android.dart';
import 'package:esh7enly/Services/features/BankApi.dart';
import '../../Services/features/ServiceApi.dart';
import '../../core/utils/colors.dart';
import '../Service/details_transaction.dart';
import 'addbalance.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

class balance extends StatefulWidget {
  const balance({Key? key}) : super(key: key);

  @override
  State<balance> createState() => _balanceState();
}

class _balanceState extends State<balance> {
  serviceApi service = new serviceApi();
  BankApi bank = new BankApi();
  String? balance = "";

  

  @override
  void initState() {

    if (mounted) {
    getbal();}
    super.initState();
  }

  getbal() {
    bank.getbalance().then((value) {
      setState(() {
        balance = value.toString();
      
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth=MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
            textDirection:
                // ignore: unrelated_type_equality_checks
                 LocalizeAndTranslate.getLanguageCode() == 'en'
                    ? TextDirection.ltr
                    : TextDirection.rtl,
            child: SingleChildScrollView(
                child: Form(
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
                      child:Padding(
                        padding:EdgeInsets.only(
                          right: 30, left: 30, top: 48,bottom: 20),
                        child: Row(children: <Widget>[
                          SvgPicture.asset(
                            "assets/icon-06.svg",
                            width: 30,
                            height: 25,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5,),
                          Column(

                            children: [

                            SizedBox(width: 90,child: Text(
                               LocalizeAndTranslate.translate("balance"),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'ReadexPro',
                              ),
                            ),),
                            SizedBox(height: 5,),
                            balance == "null"
                                ? Text(
                              '    EGP',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'ReadexPro',
                              ),
                            )
                                : Text(
                              ' ${balance.toString()} EGP',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'ReadexPro',
                              ),
                            )

                          ],),


                        Spacer(),
                        GestureDetector(
                                    onTap: () {
                                      Get.to(Addbalance());
                                    },
                                    child: Icon(
                                      Icons.add_box,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),


                        ]),
                      )),
                  SizedBox(
                    height: screenheight*.8,
                    child: PagewiseListView(
                        pageSize: 10,
                        padding: const EdgeInsets.all(5.0),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, dynamic entry, index) {
                          print(entry.status);
                                                    if (entry == null) {
                            return const Center(
                              child: Text(
                                'لا يوجد ايداعات',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            );
                          } else {
                            DateTime time = DateTime.parse(entry.created_at);
                            List months = <String>[
                           
                               LocalizeAndTranslate.getLanguageCode() == "en"
                                  ? 'Jan'
                                  : "يناير",
                               LocalizeAndTranslate.getLanguageCode() == "en"
                                  ? 'Feb'
                                  : "فبراير",
                               LocalizeAndTranslate.getLanguageCode() == "en"
                                  ? 'Mar'
                                  : "مارس",
                               LocalizeAndTranslate.getLanguageCode() == "en"
                                  ? 'Apr'
                                  : "ابريل",
                               LocalizeAndTranslate.getLanguageCode() == "en"
                                  ? 'May'
                                  : "مايو",
                               LocalizeAndTranslate.getLanguageCode() == "en"
                                  ? 'Jun'
                                  : "يوينو",
                               LocalizeAndTranslate.getLanguageCode() == "en"
                                  ? 'Jul'
                                  : "يوليو",
                               LocalizeAndTranslate.getLanguageCode() == "en"
                                  ? 'Aug'
                                  : "اغسطس",
                               LocalizeAndTranslate.getLanguageCode() == "en"
                                  ? 'Sep'
                                  : "سبنمبر",
                               LocalizeAndTranslate.getLanguageCode() == "en"
                                  ? 'Oct'
                                  : "اكتوبر",
                               LocalizeAndTranslate.getLanguageCode() == "en"
                                  ? 'Nov'
                                  : "نوفمبر",
                               LocalizeAndTranslate.getLanguageCode() == "en"
                                  ? 'Dec'
                                  : "ديسمبر",
                            ];
                        
                            return SizedBox(
                                width: 500,
                                height: 130,
                                child: Card(
                                    color: CustomColors.greycolor,
                                    elevation: 0,
                                    clipBehavior: Clip.antiAlias,
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 1,
                                        right: 10, //23 edit
                                        left: 10),//23 edit
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 6,
                                            height: 130,
                                            color: entry.status == 'SUCCESSFUL'
                                                ? Colors.green :entry.status =="CANCELLED"?Colors.orange:Colors
                                                .red,

                                          ),
                                          SizedBox(width: 15),
                                          Container(
                                              width: 60,//70 // edit
                                              height: 94,
                                              color: Colors.white,
                                              child: Center(
                                                child: Column(children: [
                                                  SizedBox(height: 20),
                                                  Text(
                                                    time.day.toString(),
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(months[time.month - 1],
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17))
                                                ]),
                                              )
                                              // child:Text('${snapshot.data[index].created_at}')
                                              ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 15,
                                                  right:  LocalizeAndTranslate
                                                              .getLanguageCode() ==
                                                          'ar'
                                                      ? 10
                                                      : 19,
                                                  left: 12,
                                                  bottom: 7),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                width:  LocalizeAndTranslate
                                                                            .getLanguageCode() ==
                                                                        'ar'
                                                                    ? 150
                                                                    : 133,
                                                                child: Text(
                                                                    entry.type == "card" ?  LocalizeAndTranslate.translate('card') : LocalizeAndTranslate.translate('wallet') ,
                                                                    style: TextStyle(
                                                                        color: entry.status ==
                                                                                'SUCCESSFUL'
                                                                            ? Colors
                                                                                .green
                                                                            : entry.status =="CANCELLED"?Colors.orange:Colors
                                                                                .red,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                     LocalizeAndTranslate.getLanguageCode() ==
                                                                            'ar'
                                                                        ? 3
                                                                        : 8,
                                                              ),
                                                              Text(
                                                                  " ${entry.id}:معرف الايداع ",
                                                                  style: const TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          130,
                                                                          129,
                                                                          129),
                                                                      fontSize:
                                                                          14)),
                                                              SizedBox(
                                                                height:
                                                                     LocalizeAndTranslate.getLanguageCode() ==
                                                                            'ar'
                                                                        ? 2
                                                                        : 4,
                                                              ),
                                                              Text(
                                                                  "${entry.amount}",
                                                                  style: const TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          130,
                                                                          129,
                                                                          129),
                                                                      fontSize:
                                                                          14)),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 14,
                                                          ),
                                                          Center(
                                                            child: SizedBox(
                                                              width:  LocalizeAndTranslate
                                                                          .getLanguageCode() ==
                                                                      'ar'
                                                                  ? 63
                                                                  : 70,
                                                              height: 24,
                                                              
                                                              child: Text(
                                                                  entry.status ==
                                                                          'PENDING'
                                                                      ?  LocalizeAndTranslate.translate(
                                                                          "pending")
                                                                      : entry.status ==
                                                                              'SUCCESSFUL'
                                                                          ?  LocalizeAndTranslate.translate(
                                                                              "success")
                                                                          : entry.status =="CANCELLED"
                                                                            ?  LocalizeAndTranslate.translate(
                                                                              "canceltrans"):
                                                                          
                                                                           LocalizeAndTranslate.translate(
                                                                              "fail"),
                                                                  style: TextStyle(
                                                                      color: entry
                                                                                  .status ==
                                                                              'SUCCESSFUL'
                                                                          ? 
                                                                          Colors.green:entry.status =="CANCELLED"
                                                                            ? Colors.orange
                                                                          : Colors
                                                                              .red,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ),
                                                          )
                                                        ])
                                                  ]))
                                        ])));
                          }
                        },
                        pageFuture: (pageIndex) {
                          pageIndex = pageIndex! + 1;

                          return bank.getdeposits(context, pageIndex);
                        },
                        loadingBuilder: (context) {
                          return const CircularProgressIndicator(
                              color: CustomColors.MainColor);
                        }),

                  )
                ])))));
  }
}
