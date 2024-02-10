
// ignore_for_file: deprecated_member_use, prefer_const_constructors, sized_box_for_whitespace

import 'package:esh7enly/Services/features/points.dart';
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/core/widgets/customtext.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  PointApi obj = PointApi();
  String? points = "0";
  @override
  void initState() {
    getpoints();
     _controller = VideoPlayerController.asset('assets/animation_lnr9tf6n.mp4');
    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();
    // Use the controller to loop the video.
    _controller.setLooping(true);
    setState(() {
      _controller.play();
    });

    super.initState();
  }

  getpoints() {
    obj.getpoints().then((value) {
      if (value == false) {
        DailogAlert.openAlert( LocalizeAndTranslate.translate("unauth"),  LocalizeAndTranslate.translate( "failedmessage"), context);
      }
      setState(() {
        points = value;
      });
    });
  }

  @override
  void dispose() {
// Ensure disposing of the VideoPlayerController to free up resources.
    _controller.pause();
    _controller.dispose();

    super.dispose();
  }

//ists[index].name_ar.toString()
  @override
  Widget build(BuildContext context) {
    var screenWidth =MediaQuery.of(context).size.width;
    var screenHeight =MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body:  Directionality(
            textDirection:
                // ignore: unrelated_type_equality_checks
                 LocalizeAndTranslate.getLanguageCode() == 'en'
                    ? TextDirection.ltr
                    : TextDirection.rtl,child: SingleChildScrollView(
        child:Column(
          children: [
            Container(
              // height 100
                height: 90,width: 400,
                decoration: const BoxDecoration(
                    color: CustomColors.MainColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40))),
                child: Directionality(
                  textDirection:  LocalizeAndTranslate.getLanguageCode() == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: Padding(
                    //top 50
                      padding: EdgeInsets.only(right: 50, left: 50, top: 45),child:
                   Text(
                         LocalizeAndTranslate.translate("gift"),
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'ReadexPro',
                          color: Colors.white,
                        ),
                      )))),
                 
                
            Padding(
              padding: EdgeInsets.only(top: 50, right: 20, left: 15),
              child: Container(
                  width: 380,
                  height: 190,
                  child: Card(
                    color: Colors.transparent,
                    surfaceTintColor:Colors.white,
                    elevation: 0,

                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 1, right: 23, left: 23),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(
                        7,
                      ),
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 40,
                      ),
                      customtext(
                        maxLine: 2,
                        color: CustomColors.MainColor,
                        fontSize: 22,
                        fontfamily: 'ReadexPro',
                        text:  LocalizeAndTranslate.getLanguageCode() == 'en'
                    ?  'you have  $points  Point':' لديك $points نقطه ',
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () async {
                          EasyLoading.show(
                              status:  LocalizeAndTranslate.getLanguageCode() == 'ar'
                                  ? 'جاري التحميل '
                                  : 'loading...',
                              maskType: EasyLoadingMaskType.black);
                          await obj.replacepoints().then((value) {
                            EasyLoading.dismiss();
                        
                            openAlert(value['message'],
                                value['status'] == false ?  LocalizeAndTranslate.translate("failedmessage") :  LocalizeAndTranslate.translate("suceessmessage"),screenHeight);
                          });
                        },
                        child: Container(
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 47),
                          decoration: BoxDecoration(
                            color: CustomColors.MainColor,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Center(
                            child: Text(
                               LocalizeAndTranslate.getLanguageCode() == 'en'
                    ? 'Replace Points':"استبدل النقاط",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'ReadexPro',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ]),
                  )),
            ),
            Container(
              //color: Colors.white,
              alignment: Alignment.center,
              child: SizedBox(
                height: 330,
                width: 330,
                child: FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    );
                  },
                ),
              ),
            )
          ],
        ))));
  }

  void openAlert(String mess, String status,double heigth) {
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor:Color(0xfFFfffff),
      elevation: 4,
      //this right here
      child: Container(
        height:heigth*.18,//18

        width: double.infinity,
        child: Container(
          margin: EdgeInsets.only(top: 16),
          //   decoration: boxDecorationStylealert,
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 10),
         // height: 80,
          child:ListView(
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
              //Spacer(),
              SizedBox(height:4),
              Center(
                child: Expanded(
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
                        LocalizeAndTranslate.getLanguageCode()=='en'?'OK':'موافق',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}

