// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_import, camel_case_types, deprecated_member_use, use_build_context_synchronously

import 'package:esh7enly/core/widgets/CustomTextField.dart';
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:esh7enly/models/provider.dart';
import 'package:esh7enly/models/totalamount.dart';
import 'package:esh7enly/views/Service/Fatora_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/core/widgets/customtext.dart';
import 'package:esh7enly/Services/features/ServiceApi.dart';
import 'package:esh7enly/models/services.dart';
import 'package:esh7enly/views/Service/details_service.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:unique_identifier/unique_identifier.dart';
import '../../db/servicedb.dart';
import '../../models/TotalAmounts.dart';
import '../../models/inquiryobject.dart';
import '../../models/payment.dart';

class serviceview extends StatefulWidget {
  const serviceview({Key? key}) : super(key: key);

  @override
  State<serviceview> createState() => _serviceviewState();
}

class _serviceviewState extends State<serviceview> {
  late List<Services> lists = [];
  final _provider = Get.arguments;

  final serviceApi _serviceapi = serviceApi();
  List electricids = [
    3683,
    3702,
    3703,
    3704,
    3705,
    3706,
    3707,
    3708,
    3709,
    3697,
    3851,
    4062.4064,
    4065
  ];

  Future refreshproviders() async {
    //this.lists = await ProviderDatabase.instance.readAllNotes();
    await ServiceDatabase.instance.readAllservices().then((value) {
      setState(() {
        lists = value
            .where((element) => element.provider_id == _provider.id)
            .toList();
      });
    });
    //  print(lists.length);
  }

  @override
  void initState() {
    refreshproviders();
    super.initState();
  }

//ists[index].name_ar.toString()
  @override
  Widget build(BuildContext context) {
    var screenHeight =MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
            // height: 1200,
         // scrollDirection: Axis.vertical,
             child: Directionality(
                textDirection:  LocalizeAndTranslate.getLanguageCode() == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 100,
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
                                  padding: EdgeInsets.only(
                                      right: 30, left: 30, top: 30),
                                  child: Row(children: <Widget>[
                                    SizedBox(
                                        width: 30,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                            size: 26,
                                          ),
                                          onPressed: () {
                                            Get.back();
                                          },
                                        )),
                                        /*  snapshot.data.name.length >= 11
                                  ? '${snapshot.data.name.substring(0, 10)} ${snapshot.data.father} ${snapshot.data.family}'
                                  : '${snapshot.data.name} ${snapshot.data.father} ${snapshot.data.family}',
                              style: const TextStyle(fontSize: 18),*/
                                     Expanded(
                                          child:Text(  //288
                                           LocalizeAndTranslate.getLanguageCode() == 'ar'
                                              ? '  ${_provider.name_ar}'
                                              :  '  ${_provider.name_en}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'ReadexPro',
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),),
                                  ])))),
                     FutureBuilder(
                              future: refreshproviders(),
                              builder: (context, AsyncSnapshot snapshot) {
                                return  ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount: lists.length,
                                                 shrinkWrap: true,
                                               physics:
                        ScrollPhysics(),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return SizedBox(
                                                      width: 80,
                                                      height: 108,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10,
                                                                left: 10,
                                                                top: 8,
                                                                bottom: 0),
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            EasyLoading.show(
                                                                status:  LocalizeAndTranslate
                                                                            .getLanguageCode() ==
                                                                        'ar'
                                                                    ? 'جاري التحميل '
                                                                    : 'loading...',
                                                                maskType:
                                                                    EasyLoadingMaskType
                                                                        .black);

                                                            if (lists[index]
                                                                    .type ==
                                                                3) {
                                                              String?
                                                                  identifier =
                                                                  await UniqueIdentifier
                                                                      .serial;
                                                              totalamounts object = totalamounts(
                                                                  imei:
                                                                      identifier,
                                                                  serviceid:
                                                                      lists[index]
                                                                          .id,
                                                                  pricevalue: lists[
                                                                          index]
                                                                      .price_value);
                                                              _serviceapi
                                                                  .getamounts(
                                                                      object,
                                                                      context)
                                                                  .then(
                                                                      (value) {
                                                                if (value["data"]
                                                                        [
                                                                        "status"] ==
                                                                    true) {
                                                                  EasyLoading
                                                                      .dismiss();
                                                                  openAlert(
                                                                      value['data']
                                                                              [
                                                                              "amount"]
                                                                          .toString(),
                                                                      value['data']
                                                                              [
                                                                              "total_amount"]
                                                                          .toString(),
                                                                      lists[index]
                                                                          .id!,
                                                                      lists[index]
                                                                          .type!,screenHeight);
                                                                } else {
                                                                  EasyLoading
                                                                      .dismiss();
                                                                  DailogAlert.openbackAlert(
                                                                      value[
                                                                          'message'],
                                                                       LocalizeAndTranslate
                                                                          .translate(
                                                                              "failedmessage"),
                                                                      context);
                                                                }
                                                              });
                                                            } else {
                                                              EasyLoading
                                                                  .dismiss();

                                                              if (electricids.contains(
                                                                      lists[index]
                                                                          .id) !=
                                                                  true) {
                                                                Get.to(detailsservice(
                                                                    service: lists[
                                                                        index],
                                                                    pricetype: lists[
                                                                            index]
                                                                        .price_type,
                                                                    pricevalue:
                                                                        lists[index]
                                                                            .price_value,
                                                                    acceptampount:
                                                                        lists[index]
                                                                            .accept_amount_input,
                                                                    providername: LocalizeAndTranslate.getLanguageCode()=='ar'?
                                                                        _provider
                                                                            .name_ar: _provider.name_en,
                                                                    servicetype:
                                                                        lists[index]
                                                                            .type,
                                                                    servicename: LocalizeAndTranslate.getLanguageCode()=='ar'?
                                                                        lists[index]
                                                                            .name_ar:lists[index].name_en,
                                                                    serviceid:
                                                                        lists[index]
                                                                            .id,
                                                                    image: lists[
                                                                            index]
                                                                        .icon));
                                                              }
                                                            }
                                                          },
                                                          child: Card(
                                                              color: Colors.transparent,
                                                              surfaceTintColor:Colors.white,
                                                              elevation: 0,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              shape: RoundedRectangleBorder(
                                                                  side: BorderSide(
                                                                      color: CustomColors
                                                                          .MainColor),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0)),
                                                              child: Center(
                                                                  child:
                                                                      Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 14,
                                                                        bottom:
                                                                            10,
                                                                        left:
                                                                            8),
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            70,
                                                                        height:
                                                                            35,
                                                                        child: lists[index].icon!.isEmpty
                                                                            ? Image.asset('assets/logo.png')
                                                                            : CachedNetworkImage(
                                                                                imageUrl: "https://e-esh7nly.org/storage/${lists[index].icon}",
                                                                                placeholder: (context, url) => Center(
                                                                                  child: Image.asset('assets/logo.png'),
                                                                                ),
                                                                                errorWidget: (context, url, error) => Image.asset('assets/logo.png'),
                                                                              ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            6,
                                                                      ),
                                                                      Expanded(
                                                                          child:
                                                                              customtext(
                                                                        text:  LocalizeAndTranslate.getLanguageCode() ==
                                                                                'ar'
                                                                            ? lists[index].name_ar!
                                                                            : lists[index].name_en!,
                                                                        maxLine:
                                                                            1,
                                                                        fontSize:
                                                                            17,
                                                                        color: CustomColors
                                                                            .MainColor,
                                                                        fontweight:
                                                                            FontWeight.bold,
                                                                      ))
                                                                    ]),
                                                              ))),
                                                        ),
                                                      ));
                                                });
                              })]))));
                   
  }

  void openAlert(String amount, String totalamount, int id, int type,double h) {
    late var quantitycontroller = TextEditingController(text: "1");
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor:Color(0xfFFfffff),
      elevation: 4,
      //this right here
      child: Container(

        height: h*.32,

        width: double.infinity,
        child:Center(child:  Container(
         // margin: EdgeInsets.only(top: 10),


          //   decoration: boxDecorationStylealert,

          padding: EdgeInsets.symmetric(horizontal: 24),

          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text("${ LocalizeAndTranslate.translate("confirm")}!",
                    style: TextStyle(
                      fontSize: 19,
                    )),
              ),
             SizedBox(height: 3,),
              Text(
                "${ LocalizeAndTranslate.translate("amunt")}: ${amount.toString()}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              Text(
                  "${ LocalizeAndTranslate.translate("totalamount")}: ${totalamount.toString()}",
                  style: TextStyle(fontWeight: FontWeight.bold)),

              Divider(
                color: Color(0xFF898787),
              ),

              Center(
                child: Text( LocalizeAndTranslate.translate("Quan")),
              ),

              CustomTextField(
                  OnTab: () {},
                  dense: true,
                  controller: quantitycontroller,
                  Padding:
                  EdgeInsets.only(right: 15, top: 5, bottom: 5, left: 10)),

              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: CustomColors.MainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                           LocalizeAndTranslate.translate("cancel"),
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: MaterialButton(
                        onPressed: () async {
                          // ignore: non_constant_identifier_names
                          bool ISBLUK = false;
                          String? identifier = await UniqueIdentifier.serial;

                          paymentmodel objectmodel = paymentmodel(
                              amount: amount,
                              imei: identifier,
                              total: totalamount,
                              serviceid: id);
                          _serviceapi
                              .payment(objectmodel, context)
                              .then((value) {
                            print(value);
                            // ==true
                            if (value['status'] == true) {
                              /*DailogAlert.openbackAlert(
                                  "تم نجاح العمليه",
                                   LocalizeAndTranslate.translate("suceessmessage"),
                                  context);

                              Navigator.pop(context); */
                              //value['data]
                              Data paymentformat = Data.fromJson(value['data']);
                              if (int.parse(quantitycontroller.text) > 1) {
                                ISBLUK = true;

                                //Get.to(fatora_details());
                                //totalamount , paymentobject,serivcetype
                              } else {
                                //paymentobject,serivcetype
                                Get.off(fatora_details(
                                  paymentobject: paymentformat,
                                  servicetype: type,
                                  isbluck: ISBLUK,
                                  bluknumber:
                                  int.parse(quantitycontroller.text),
                                ));
                              }
                            } else {
                              Navigator.pop(context);
                              DailogAlert.openbackAlert(
                                  value['message'],
                                   LocalizeAndTranslate.translate("failedmessage"),
                                  context);


                            }
                          });
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
                  )
                ],
              ),
            ],
          ),
        ),)
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
