// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, deprecated_member_use, unnecessary_string_interpolations

import 'package:esh7enly/Services/features/Notification.dart';
import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/models/inquiryobject.dart';
import 'package:esh7enly/views/Service/Fatora_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:esh7enly/views/Login/login.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class DailogAlert {
  static openAlert(String mess, String status, BuildContext context) {
    var screenHeight =MediaQuery.of(context).size.height;
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor:Color(0xfFFfffff),
      elevation: 4,
      //this right here
      child: Container(

          height: screenHeight*.19,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.only(top: 16),
          //   decoration: boxDecorationStylealert,
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 10),

          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text(status,
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height:4),
             // Spacer(),
              Center(
                child: Text(
                  mess,
                ),
              ),
              //Spacer(),
              SizedBox(height:4),
              Center(
                child:  Padding(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 0),
                    child: MaterialButton(
                      onPressed: () async {
                        Get.off(login());
                      },
                      color: CustomColors.MainColor,
                      // ignore: sort_child_properties_last
                      child: Text(
                        '${ LocalizeAndTranslate.translate("ok")}',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  static openbackAlert(String mess, String status, BuildContext context) {
    var screenHeight =MediaQuery.of(context).size.height;
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor:Color(0xfFFfffff),
      elevation: 4,
      //this right here
      child: Container(
        height: screenHeight*.18,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.only(top: 16),
          //   decoration: boxDecorationStylealert,
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text(status,
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              ),
             //Spacer(),
              SizedBox(height:4),
              Center(
                child: Text(
                  mess,
                ),
              ),
              //Spacer(),
              SizedBox(height:4),
              Center(
                child: Padding(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 0),
                    child: MaterialButton(
                      onPressed: () async {
                        Get.back();
                      },
                      color: CustomColors.MainColor,
                      // ignore: sort_child_properties_last
                      child: Text(
                        '${ LocalizeAndTranslate.translate("ok")}',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  static openback2Alert(String mess, String status, BuildContext context) {
    var screenHeight =MediaQuery.of(context).size.height;
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor:Color(0xfFFfffff),
      elevation: 4,
      //this right here
      child: Container(
          height: screenHeight*.18,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.only(top: 16),
          //   decoration: boxDecorationStylealert,
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 10),

          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text(status,
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              ),
             // Spacer(),
              SizedBox(height:4),
              Center(
                child: Text(
                  mess,
                ),
              ),
             // Spacer(),
              SizedBox(height:4),
              Center(
                child:  Padding(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 0),
                    child: MaterialButton(
                      onPressed: () async {
                        Get.back();
                        Get.back();
                      },
                      color: CustomColors.MainColor,
                      // ignore: sort_child_properties_last
                      child: Text(
                        '${ LocalizeAndTranslate.translate("ok")}',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  static opennotifyAlert(String status, String mess, BuildContext context,
      int serviceid, var num, Data paymentformat, int type) {
    var screenHeight =MediaQuery.of(context).size.height;
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor:Color(0xfFFfffff),
      elevation: 4,
      //this right here
      child: Container(
        height: screenHeight*.19,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.only(top: 16),
          //   decoration: boxDecorationStylealert,
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 10),

          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text(status,
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              ),
             // Spacer(),
              SizedBox(height:4),
              Center(
                child: Text(
                  mess,
                ),
              ),
             // Spacer(),
              SizedBox(height:4),
              Center(
                  child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 0),
                      child: MaterialButton(
                        onPressed: () async {
                          DateTime t = DateTime.now();
                          NotificationApi()
                              .addnotify(serviceid, num!, context, t.day)
                              .then((value) {
                            if (value['status'] == true) {
                              DailogAlert.openfatoraAlert(
                                   LocalizeAndTranslate.translate("suceessmessage"),
                                  value['message'],
                                  context,
                                  paymentformat,
                                  type);
                            } else {
                              /*DailogAlert.openbackAlert(
                                   LocalizeAndTranslate.translate("failedmessage"),
                                  value['message'],
                                  context); */
                              DailogAlert.openfatoraAlert(
                                   LocalizeAndTranslate.translate("failedmessage"),
                                  value['message'],
                                  context,
                                  paymentformat,
                                  type);
                            }
                          });
                        },
                        color: CustomColors.MainColor,
                        // ignore: sort_child_properties_last
                        child: Text(
                          '${ LocalizeAndTranslate.translate("ok")}',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 0),
                      child: MaterialButton(
                        onPressed: () async {
                          Get.off(fatora_details(
                            bluknumber: 0,
                            isbluck: false,
                            paymentobject: paymentformat,
                            servicetype: type,
                          ));
                        },
                        color: CustomColors.MainColor,
                        // ignore: sort_child_properties_last
                        child: Text(
                          '${ LocalizeAndTranslate.translate("cancel")}',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  static openfatoraAlert(String mess, String status, BuildContext context,
      Data payment, int type) {
    var screenHeight =MediaQuery.of(context).size.height;
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor:Color(0xfFFfffff),
      elevation: 4,
      //this right here
      child: Container(
        height: screenHeight*.18,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.only(top: 16),
          //   decoration: boxDecorationStylealert,
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 10),

          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text(status,
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              ),
             // Spacer(),
              SizedBox(height:4),
              Center(
                child: Text(
                  mess,
                ),
              ),
            // Spacer(),
              SizedBox(height:4),
              Center(
                child:  Padding(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 0),
                    child: MaterialButton(
                      onPressed: () async {
                        Get.off(fatora_details(
                          bluknumber: 0,
                          isbluck: false,
                          paymentobject: payment,
                          servicetype: type,
                        ));
                      },
                      color: CustomColors.MainColor,
                      // ignore: sort_child_properties_last
                      child: Text(
                         LocalizeAndTranslate.translate("ok"),
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
