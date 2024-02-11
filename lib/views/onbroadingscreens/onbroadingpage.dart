// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/views/onbroadingscreens/lastpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class onbroadingpage extends StatefulWidget {
  const onbroadingpage({super.key});

  @override
  State<onbroadingpage> createState() => _onbroadingpageState();
}

class _onbroadingpageState extends State<onbroadingpage> {
  int currentIndex = 0;
  late PageController _controller;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List contents = ['assets/broading3.jpeg','assets/broading2.jpeg','assets/broading1.jpeg'];
  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth=MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(child:Column(children: [
       SizedBox(
                  height: screenheight*.92,child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return
                 Image.asset(contents[i]
                );
              })),

                GestureDetector(
            onTap: () async {
              if (currentIndex == contents.length - 1) {
                  Get.to(LastPage());
                    
                  
            }
             _controller.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.decelerate,
                );
            },
            child: Container(
              height: screenheight/16,
              margin: EdgeInsets.symmetric(horizontal: screenheight*.1),
              decoration: BoxDecoration(
                color: CustomColors.MainColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child:  Text(
                  'التالي',
                  style:
                  TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: 'ReadexPro',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
    ])));
  }
}
