// ignore_for_file: deprecated_member_use, prefer_const_constructors, unnecessary_string_interpolations

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:esh7enly/Services/features/CategryApi.dart';
import 'package:esh7enly/Services/features/banner.dart';
import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/core/widgets/customtext.dart';
import 'package:esh7enly/core/widgets/header.dart';
import 'package:esh7enly/db/servicedb.dart';
import 'package:esh7enly/models/skelton.dart';
import 'package:esh7enly/views/Provider/providerview.dart';
import 'package:esh7enly/views/HomeScreen/results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../db/categoriesdb.dart';
import '../../core/widgets/customebuttunwithicon.dart';
import '../Provider/MobileCategory.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<home> {
  final CategoryApi _categoryApi = CategoryApi();
  bool search = false;
  TextEditingController controller = TextEditingController();
  bool tab = false;
  List categories = [];
  final storage = const FlutterSecureStorage();
  String? username="";
  TextEditingController searchcontroller = TextEditingController();
  List searchitems = [];
  bool issearching = false;
  List items = [];
  int  mobindex=0;int billsindex=0;
  BannerApi poster = BannerApi();
  CarouselController control = CarouselController();
  List<Widget> list = [
    Image.asset(
      'assets/Artboard.png',
    ),
    Image.asset(
      'assets/flex.jpeg',
    ),
    Image.asset('assets/img2.jpeg'),
    Image.asset(
      'assets/img3.jpeg',
    )
  ];
  filttercategories() {
    if (searchcontroller.text.isNotEmpty) {
      var filteredservices = [];
      RegExp exp = RegExp("^[a-zA-Z0-9]*");
      exp.allMatches(searchcontroller.text).forEach((match) {
        if (match.group(0) != "") {
          for (var serv in categories) {
            if (serv.name_en.contains(searchcontroller.text)) {
              filteredservices.add(serv);
            }
          }
        }
      });
      setState(() {
        searchitems = filteredservices;
      });
    }
  }

  getusername() async {

    await storage.read(key: 'name').then((value) {
      setState(() {
        username = value!;
      });
    });
  }

  List providers = [];

  Future refrescategories() async {
    //this.lists = await ProviderDatabase.instance.readAllNotes();
      await ServiceDatabase.instance.readAllservices().then((v) {
         setState(() {
        //  print('len ${value.length}');
       providers = v.toList();
      });
    });
    await categoryDatabase.instance.readAllNotes().then((value) {
      setState(() {
        //  print('len ${value.length}');

        categories = value.toList();
        int j=0;
        for(var i in categories)
          {

            if(i.id==29)
              {
                billsindex=j;

              }
            if(i.id==28)
              {
                mobindex=j;
              }
            j=j+1;
          }
      });
    });
    //  print(lists.length);
  }

  @override
  void initState() {
    getusername();
    _categoryApi.getallcategoriess();
    refrescategories();
    poster.getimages().then((value) {
      setState(() {
        for (var obj in value) {
          items.add("https://e-esh7nly.org/storage/${obj.banner}");
        }
      });
    });
    searchcontroller.addListener(() {
      filttercategories();
    });

    super.initState();
  }

  void onchangedtext(String value) {
    setState(() {
      search = true;
    });

    if (value.isEmpty) {
      setState(() {
        search = false;
      });
    }
  }

  double defaultPadding = 16.0;
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
          child: Column(
            children: [
              header(
                heightcon:  screenheight*.22,
              ),
               SizedBox(
                height: screenwidth/18,
              ),
               LocalizeAndTranslate.getLanguageCode() == 'en'
                  ? Text(" ${ LocalizeAndTranslate.translate("welcomhome")} $username ",
                      style:  TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ReadexPro',
                          fontSize: 17.sp,
                          color: CustomColors.MainColor))
                  : Text(" ${ LocalizeAndTranslate.translate("welcomhome")} $username ",
                      style:  TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ReadexPro',
                          fontSize: 17.sp,
                          color: CustomColors.MainColor)),
              SizedBox(
                height: screenwidth/18,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
               Container(
                        padding: EdgeInsets.zero,
                        margin: const EdgeInsets.only(right: 10, left: 5),
                        child: Card(
                            color: Colors.transparent,
                            surfaceTintColor:Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.grey,
                                    width: 1),
                                borderRadius: BorderRadius.circular(
                                  5.0,
                                ),),
                            child: SizedBox(
                                width: screenwidth*.57,
                                height: screenwidth*.1,
                                child: ListTile(
                                  onTap: () {},
                                  title: TextField(
                                    controller: searchcontroller,
                                    onTap: () {
                                      controller.selection =
                                          TextSelection.collapsed(
                                              offset: controller.text.length);
                                    },
                                    onChanged: onchangedtext,

                                    decoration: InputDecoration(
                                        hintText: LocalizeAndTranslate.getLanguageCode()=='ar'?'بحث':'Search',
                                        contentPadding:
                                        const EdgeInsets.only(right: 4, top: 0, bottom: 20, left: 4),
                                        border: InputBorder.none),
                                  ),
                                )))),
                CustomButtonIcon(
                  onPress: () {
                    setState(() {

                      Get.to(const Results(), arguments: searchcontroller.text);
                    });
                  },
                  url: "assets/icon-10(search).svg",
                  w: 75,
                  h: 40,
                  wicon: 30,
                  hicon: 55,
                  color: CustomColors.MainColor,
                )
                ////comment
              ]),

              SizedBox(
                  height: tab == false ? screenheight*.17 : screenheight*.76,
                  width: screenwidth*.97,
                  child: FutureBuilder(
                      future: refrescategories(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (providers.isEmpty) {
                          return  Padding(
                              padding:
                                  EdgeInsets.only(right: 10, left: 25,top: screenheight/35),
                              child: Row(children: [
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Skeleton(height: screenwidth*.22, width: screenwidth*.25),
                                        SizedBox(height: screenheight/99),
                                        Skeleton(width: screenheight*.12 ),
                                      ]),
                                ),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Skeleton(height: screenwidth*.22, width: screenwidth*.25),
                                        SizedBox(height: screenheight/99),
                                        Skeleton(width: screenheight*.12 ),
                                      ]),
                                ),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Skeleton(height: screenwidth*.22, width: screenwidth*.25),
                                        SizedBox(height: screenheight/99),
                                        Skeleton(width: screenheight*.12 ),
                                      ]),
                                )
                              ]));
                        } else {
                          return gethome(mobindex,billsindex);
                        }
                      })),
              Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Container(
                          color: Color.fromARGB(255, 228, 226, 226),
                          width: 400,
                          height: 120,
                          child: CarouselSlider(

                              carouselController: control,
                              options: CarouselOptions(),
                              items: list
                                  .map((item) => Padding(
                                        padding: EdgeInsets.all(6), //14
                                        child: item,
                                      ))
                                  .toList()))),
                  Positioned(
                    top: 80,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        control.previousPage();
                      },
                      child: SvgPicture.asset("assets/arrow2 .svg",
                          color: CustomColors.MainColor, width: 20, height: 20),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 350,
                    child: GestureDetector(
                      onTap: () {
                        control.nextPage();
                      },
                      child: SvgPicture.asset("assets/arrow .svg",
                          color: CustomColors.MainColor, width: 20, height: 20),
                    ),
                  ),
                ],
              ),
              items.length !=0?Directionality(
                  textDirection: TextDirection.rtl,
                  child: SizedBox(
                      width: 350,
                      height: 230,
                      child: CarouselSlider.builder(
                        itemCount: items.length,
                        options: CarouselOptions(
                          autoPlay: true,
                          autoPlayCurve: Curves.decelerate,
                          aspectRatio: 2.0,
                          enlargeCenterPage: false,
                        ),
                        itemBuilder: (context, index, realIdx) {
                          return Center(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(items[index],
                                      fit: BoxFit.fill,
                                      width: 260,
                                      height: 200)));
                        },
                      ))):SizedBox(height: 0,width: 0,),

              /*Container(
                  width: 500,
                  height: 150,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:  */
            ],
          )),
    ));
  }

  gethome(int mob,int bill) {
    //   print("tab $tab");
    return GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        crossAxisSpacing: 0,
        physics: NeverScrollableScrollPhysics(),

        //  childAspectRatio: 23 / 12,
        childAspectRatio: 24 / 19,
        mainAxisSpacing: 0,
        scrollDirection: Axis.vertical,
        children: List.generate(tab == false ? 3 : categories.length, (index) {
          if (index == 0) {
            // print(  LocalizeAndTranslate.translate(categories[index].name_ar));
            return Column(
              children: [
                CustomButtonIcon(
                  onPress: () {

                    Get.to(
                        MobileCategory(

                        ),
                        arguments:   categories[mobindex]);
                  },
                  url: "assets/icon-08.svg",
                  w: 88,
                  h: 70,
                  wicon: 80,
                  hicon: 80,
                  color: Colors.white,
                  bordercolor: CustomColors.MainColor,
                  coloricon: CustomColors.MainColor,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                   LocalizeAndTranslate.translate("mobile services"),
                  style: TextStyle(
                      fontFamily: 'ReadexPro',
                      color: CustomColors.MainColor,
                      fontSize: 13),
                )
              ],
            );
          }
          if (index == 1) {
            return Column(
              children: [
                CustomButtonIcon(
                  onPress: () {
                    Get.to(
                        MobileCategory(


                        ),
                        arguments:   categories[billsindex]);
                  },
                  url: "assets/icon-09.svg",
                  w:90,
                  h: 70,
                  wicon: 70,
                  hicon: 67,
                  color: Colors.white,
                  bordercolor: CustomColors.MainColor,
                  coloricon: CustomColors.MainColor,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                   LocalizeAndTranslate.translate("fatoras"),
                  style: TextStyle(
                      fontFamily: 'ReadexPro',
                      color: CustomColors.MainColor,
                      fontSize: 13),
                )
              ],
            );
          }
          if (index == 2 && tab == false) {
            return Column(children: [
              CustomButtonIcon(
                onPress: () {
                  setState(() {
                    tab = true;
                  });
                },
                url: "assets/icon-07.svg",
                w: 88,
                h: 75,
                wicon: 80,
                hicon: 63,
                color: Colors.white,
                coloricon: CustomColors.MainColor,
                bordercolor: CustomColors.MainColor,
              ),

              Text(
                 LocalizeAndTranslate.translate("others ser"),
                style: const TextStyle(
                    fontFamily: 'ReadexPro',
                    color: CustomColors.MainColor,
                    fontSize: 13),
              )
            ]);
          }
          if (tab == true) {
            if (index == mob) {
              index = 0;
            }
            if (index == bill) {
              index = 1;
            }
            return

                //10 10 10 5

                GestureDetector(
              onTap: () {
                Get.to(
                    providerview(
                    ),
                    arguments:categories[index]);
              },
              child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            top: 0, bottom: 0, right: 15, left: 15),
                        child: Card(
                            color: Colors.transparent,
                            surfaceTintColor:Colors.white,
                            elevation: 0,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: CustomColors.MainColor),
                                borderRadius: BorderRadius.circular(7.0)),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                    providerview(


                                    ),
                                    arguments:  categories[index]);
                              },
                              child: Center(
                                  child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, right: 15, left: 15),
                                child: Image.network(
                                  "https://e-esh7nly.org/storage/${categories[index].logo}",
                                  width: 70,
                                  height: 50,
                                ),
                              )),
                            ))),
                    SizedBox(
                      height: 0,
                    ),
                    Center(
                        child: customtext(
                      text:  LocalizeAndTranslate.getLanguageCode() == 'ar'
                          ? categories[index].name_ar
                          : categories[index].name_en.length >= 18
                              ? categories[index]
                                  .name_en
                                  .toString()
                                  .substring(0, 15)
                              : '${categories[index].name_en}',
                      maxLine: 1,
                      fontSize: 15,
                      color: CustomColors.MainColor,
                      alignment: Alignment.center,
                    ))
                  ]),
            );
          }
          /* SizedBox(
            height: 0,
            width: 0,
          ); */
          return Text("");
        }));
  }


}
