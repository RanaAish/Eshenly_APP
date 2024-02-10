// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types, prefer_collection_literals, unused_field, deprecated_member_use, prefer_const_constructors, avoid_unnecessary_containers, use_build_context_synchronously, sort_child_properties_last, prefer_if_null_operators
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:esh7enly/Services/features/Notification.dart';
import 'package:esh7enly/Services/features/ServiceApi.dart';
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:esh7enly/models/inquiryobject.dart';
import 'package:esh7enly/models/parameters.dart';
import 'package:esh7enly/views/Service/Fatora_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'dart:async';
//import 'package:flutter/services.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:unique_identifier/unique_identifier.dart';
import '../../core/utils/colors.dart';
import '../../core/widgets/CustomTextField.dart';
import '../../db/imagesdb.dart';
import '../../db/servicedb.dart';
import '../../models/Image.dart';
import '../../models/TotalAmounts.dart';
import '../../models/payment.dart';
import '../../models/services.dart';
import 'detailsinquiry.dart';

//import 'package:flutter/foundation.dart';

class detailsservice extends StatefulWidget {
  final serviceid,
      image,
      providername,
      servicename,
      servicetype,
      acceptampount,
      pricevalue,
      pricetype;
  final Services service;

  const detailsservice(
      {Key? key,
      this.image,
      this.pricetype,
      this.pricevalue,
      this.serviceid,
      required this.service,
      this.servicename,
      this.servicetype,
      this.acceptampount,
      this.providername})
      : super(key: key);

  @override
  State<detailsservice> createState() => _detailsserviceState();
}

class _detailsserviceState extends State<detailsservice> {
  //radiobuttun
  String? amountselect;
  late var quantitycontroller = TextEditingController();

  // dropdown
  var _category;
  var categories = ['o'];
  bool shouldBreak = false;
  serviceApi service = serviceApi();
  List<Map> output = [];
  Map amountfromtypes = Map();
  late List<parameters> lists = [];
  late List<parameters> listsfordetailsinquiry = [];
  late List<Imageparameters> listofimages = [];
  DateTime datetime = DateTime.now();
  late var amountcontroller = TextEditingController();
  late var onecontroller = TextEditingController();
  late var twocontroller = TextEditingController();
  late var threecontroller = TextEditingController();
  late var fourcontroller = TextEditingController();
  String? namedropdown;
  var valuetyped;

  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  Contact? _contact;
  String? selectedNumber;
  var myControllers = [];

  createControllers(int len) {
    for (var i = 0; i < len; i++) {
      myControllers.add(TextEditingController());
    }
  }

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

  Future readallimages() async {
    await ImageDatabase.instance.readAllimages().then((value) {
      setState(() {
        listofimages = value
            .where((element) => element.service_id == widget.serviceid)
            .toList();
      });
    });
  }

  Future readparameters() async {
    //print(widget.serviceid);
    //this.lists = await ProviderDatabase.instance.readAllNotes();
    await ServiceDatabase.instance.readAllparameters().then((value) {
      setState(() {
        listsfordetailsinquiry = value
            .where((element) =>
        element.service_id == widget.serviceid &&
            (element.display == 1 || element.display == 3))
            .toList();
        if (widget.servicetype == 1) {
          lists = value
              .where((element) =>
          element.service_id == widget.serviceid &&
              (element.display == 1 || element.display == 3))
              .toList();
        }
        if (widget.servicetype == 2) {
          lists = value
              .where((element) =>
          element.service_id == widget.serviceid &&
              (element.display == 1 || element.display == 2))
              .toList();
        }
      });
      for (var object in lists) {
        if (object.type == 5) {
          addtypevalues(object);
        }
      }
    });
  }

  @override
  void initState() {
    readparameters();
    readallimages();

    super.initState();
  }

  addtypevalues(parameters item) {
    List list =
    item.type_values.replaceAll('[', '').replaceAll(']', '').split('},');
    for (var obj in list) {
      String text = obj + "}";

      String result = text
          .replaceAll("{", "{\"")
          .replaceAll("}", "\"}")
          .replaceAll(":", "\":\"")
          .replaceAll(",", "\",\"");

      if (result.contains('}"}') == true) {
        result = result.replaceAll('}"}', "}");
      }
      final data = jsonDecode(result);
      setState(() {
        if ( LocalizeAndTranslate.getLanguageCode() == 'ar') {
          categories.add(data[" name_ar"]);
        } else {
          categories.add(data[" name_en"]);
        }
      });
    }
  }

  var valuetypes;

  getvaluefromdatatypes(String name, parameters item) {
    List list =
    item.type_values.replaceAll('[', '').replaceAll(']', '').split('},');

    for (var obj in list) {
      String text = obj + "}";
      String result = text
          .replaceAll("{", "{\"")
          .replaceAll("}", "\"}")
          .replaceAll(":", "\":\"")
          .replaceAll(",", "\",\"");

      if (result.contains('}"}') == true) {
        result = result.replaceAll('}"}', "}");
      }
      final data = jsonDecode(result);
      setState(() {
        if (name.trim() == data[" name_ar"].trim()) {
          namedropdown = data[" name_ar"];
          valuetypes = (data['value'].trim());
        }
        //  categories.add(data[" name_ar"]);
      });
    }
    return valuetypes;
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Directionality(
              textDirection:
              // ignore: unrelated_type_equality_checks
               LocalizeAndTranslate.getLanguageCode() == 'en'
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              child: Column(children: [
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
                            padding:
                            EdgeInsets.only(right: 30, left: 30, top: 30),
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
                                      })),
                              Expanded(

                                  child: Text('    ${widget.servicename}',
                                      softWrap: false,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'ReadexPro',
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                      ))),
                            ])))),
                SizedBox(
                  height: 120,
                ),
                SizedBox(
                    width: 440,
                    //height: 340, // default   185  // one text field:255
                    child: Padding(
                        padding:
                        EdgeInsets.only(top: 9, right: 20, left: 25),
                        child: Center(
                            child: Card(
                                color: Colors.transparent,
                                surfaceTintColor: Colors.white,
                                elevation: 0,
                                clipBehavior: Clip.antiAlias,
                                margin: const EdgeInsets.only(
                                    top: 0, bottom: 1, right: 0, left: 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(1.0)),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 20,
                                        right: 20,
                                        left: 20,
                                        bottom: 7),
                                    child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 0,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  right: 0, left: 0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(widget.servicename,
                                                        style: const TextStyle(
                                                            color: CustomColors
                                                                .MainColor,
                                                            fontSize: 15)),
                                                    Container(
                                                      width: 68,
                                                      height: 46,
                                                      color: Colors.white,
                                                      child: widget
                                                          .image.isEmpty
                                                          ? Image.asset(
                                                          'assets/logo.png')
                                                          : CachedNetworkImage(
                                                        imageUrl:
                                                        "https://e-esh7nly.org/storage/${widget
                                                            .image}",
                                                        placeholder:
                                                            (context,
                                                            url) =>
                                                            Center(
                                                              child: Image
                                                                  .asset(
                                                                  'assets/logo.png'),
                                                            ),
                                                        errorWidget: (context,
                                                            url,
                                                            error) =>
                                                            Image.asset(
                                                                'assets/logo.png'),
                                                      ),
                                                    ),
                                                  ])),
                                          //  "${widget.providername}(${widget.servicename})",
                                          Text(
                                            "${widget.servicename}",
                                            style: TextStyle(
                                                color: CustomColors.MainColor,
                                                fontSize: 15),
                                          ),

                                          listofimages.isNotEmpty
                                              ? Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10),
                                              ),
                                              child: CarouselSlider(
                                                options: CarouselOptions(),
                                                items: listofimages
                                                    .map(
                                                        (item) =>
                                                        Container(
                                                          child: Center(
                                                              child: Image
                                                                  .network(
                                                                  "https://e-esh7nly.org/storage/${item
                                                                      .path}",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width:
                                                                  70)), //300
                                                        ))
                                                    .toList(),
                                              ))
                                              : SizedBox(height: 0),
                                          SizedBox(
                                            height: 29,
                                          ),
                                          electricids.contains(widget.serviceid)
                                              ? const Text(" electric ")
                                              : SizedBox(
                                            //    250 type ==4 160 280
                                              height: double.parse( //78
                                                  (60 * (lists.length))
                                                      .toString()),
                                              child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection:
                                                  Axis.vertical,
                                                  physics:
                                                  NeverScrollableScrollPhysics(),
                                                  itemCount: lists.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                      int index) {
                                                    createControllers(
                                                        lists.length);
                                                    print(lists[index].name_en);
                                                    return SizedBox(
                                                        child: lists[index]
                                                            .type ==
                                                            1
                                                            ? layoutone(
                                                            context,
                                                            lists[
                                                            index],
                                                            index)
                                                            : lists[index]
                                                            .type ==
                                                            2
                                                            ? layouttwo(
                                                            context,
                                                            lists[
                                                            index],
                                                            index)
                                                            : lists[index]
                                                            .type ==
                                                            3
                                                            ? layoutthree(
                                                            context,
                                                            lists[
                                                            index],
                                                            index)
                                                            : lists[index]
                                                            .type ==
                                                            4
                                                            ? layoutfour(
                                                            context,
                                                            lists[index],
                                                            index)
                                                            : lists[index]
                                                            .type == 5
                                                            ? layoutfive(
                                                            context,
                                                            lists[index], index)
                                                            : layoutsix(context,
                                                            lists[index],
                                                            index));
                                                  })),
                                          widget.acceptampount == 1
                                              ? layoutamount(context)
                                              : SizedBox(
                                            height: 0,
                                          ),
                                          const SizedBox(
                                            height: 9,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              EasyLoading.show(
                                                  status:  LocalizeAndTranslate
                                                      .getLanguageCode() ==
                                                      'ar'
                                                      ? 'جاري التحميل '
                                                      : 'loading...',
                                                  maskType: EasyLoadingMaskType
                                                      .black);
                                              await onpressbuttun(screenheight);
                                            },
                                            child: Container(
                                              height: 39,
                                              margin:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 0),
                                              decoration: BoxDecoration(
                                                color: CustomColors.MainColor,
                                                borderRadius:
                                                BorderRadius.circular(1),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  widget.servicetype == 2
                                                      ?  LocalizeAndTranslate
                                                      .getLanguageCode() ==
                                                      'en'
                                                      ? "INQUIRY"
                                                      : "استعلام"
                                                      :  LocalizeAndTranslate
                                                      .getLanguageCode() ==
                                                      'en'
                                                      ? "PAY"
                                                      : 'دفع',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                        ]))))))
              ]),
            )));
  }

  Widget layoutone(BuildContext context, parameters item, int index) {
    return
      Padding(
          padding: EdgeInsets.only(
              top: 5, bottom: 5
          ),
          child: SizedBox(
            height: 40,
            child: CustomTextField(
                hint:  LocalizeAndTranslate.getLanguageCode() == 'ar'
                    ? item.name_ar
                    : item.name_en,
                suffic: item.is_client_number == 1
                    ? IconButton(
                    icon: Icon(Icons.account_box),
                    onPressed: () async {
                      //final status = Permission.contacts.request();
                      //launchContacts();

                      _askPermissions('/contactsList', index);
                    })
                    : null,
                changed: (var value) async {
                  if (value.isEmpty) {
                    valuetyped = null;
                  } else {
                    valuetyped = value;
                  }
                },
                OnTab: () {
                  //convert text to enghish numbers
                },
                type: TextInputType.number,
                dense: false,
                controller: myControllers[index],
                Padding: EdgeInsets.only(
                    right: 16, top: 0, bottom: 0, left: 16)),
          )


      );
  }

  Future<void> _askPermissions(String routeName, int index) async {
    //

    PermissionStatus permissionStatus = await _getContactPermission();

    if (permissionStatus == PermissionStatus.granted) {
      Contact? contact = await _contactPicker.selectContact();
      if (contact != null) {
        setState(() async {
          _contact = contact;
          List<String>? phoneNumbers = contact.phoneNumbers;
          selectedNumber = phoneNumbers?[0] ?? '';

          myControllers[index].text = selectedNumber ?? '';
        });
      }
    }

  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Widget layouttwo(BuildContext context, parameters item, int index) {
    return

      Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: SizedBox(
          height: 40,
          child: CustomTextField(
              hint:  LocalizeAndTranslate.getLanguageCode() == 'ar'
                  ? item.name_ar
                  : item.name_en,
              OnTab: () {},
              dense: false,
              controller: myControllers[index],
              Padding: EdgeInsets.only(
                  right: 16, top: 0, bottom: 0, left: 16)),
        ),
      );
  }

  Widget layoutthree(BuildContext context, parameters item, int index) {
    print(index);
    return
      Padding(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: SizedBox(
            height: 40,
            child: CustomTextField(
                hint:  LocalizeAndTranslate.getLanguageCode() == 'ar'
                    ? item.name_ar
                    : item.name_en,
                OnTab: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: datetime,
                      firstDate: DateTime(1800),
                      lastDate: DateTime(2500));
                  if (newDate == null) return;
                  myControllers[index].text =
                  "${newDate.year}-${newDate.month}-${newDate.day}";
                },
                dense: false,
                controller: myControllers[index],
                Padding: EdgeInsets.only(
                    right: 16, top: 0, bottom: 0, left: 16)),

          ));
  }

  Widget layoutfour(BuildContext context, parameters item, int index) {
    late var datecontroller = TextEditingController();
    return
      Padding(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: SizedBox(
            height: 70,
            child: CustomTextField(
                hint:  LocalizeAndTranslate.getLanguageCode() == 'ar'
                    ? item.name_ar
                    : item.name_en,
                OnTab: () async {},
                dense: false,
                lines: 4,
                controller: myControllers[index],
                Padding: EdgeInsets.only(
                    right: 16, top: 0, bottom: 0, left: 16)),
          )
      );
  }

  Widget layoutfive(BuildContext context, parameters item, int index) {
    return
      Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: SizedBox(
          height: 40,
          child: createdropdown(item),
        ),
      );
  }


  void launchContacts() async {
    // const platform = const MethodChannel('flutter_contacts/launch_contacts');
    final MethodChannel channel =
    const MethodChannel('flutter_contacts/launch_contacts')
      ..setMethodCallHandler((MethodCall call) async {});

    try {
      await channel.invokeMethod('launch');
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print("Failed to launch contacts: ${e.message}");
    }
    setState(() {});
  }

  Widget layoutsix(BuildContext context, parameters item, int index) {
    return Padding(
        padding: EdgeInsets.only(right: 15),
        child: SizedBox(
          //    250 type ==4 160 280
            height: 50,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile(
                    title: Text(categories[index]),
                    value: categories[index],
                    groupValue: amountselect,
                    onChanged: (value) {
                      setState(() {
                        amountselect = value.toString();
                      });
                    },
                  );
                })));
  }

  Widget layoutamount(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
            padding: EdgeInsets.only(top: 5),
            child: SizedBox(
              height: 40,
              child: CustomTextField(
                  hint:  LocalizeAndTranslate.getLanguageCode() == 'ar'
                      ? 'القيمه'
                      : "Amount",
                  OnTab: () {},
                  dense: false,
                  controller: amountcontroller,
                  Padding: EdgeInsets.only(
                      right: 16, top: 0, bottom: 0, left: 16)),
            )),
      ],
    );
  }

  getamount() {
    var amount = "";
    if (electricids.contains(widget.serviceid)) {} else {
      if (widget.acceptampount == 1) {
        amount = amountcontroller.text;
      } else if (widget.pricetype == 2) {
        amount = widget.pricevalue;
      }
    }
    return amount;
  }

  onpressbuttun(double h) async {
    amountfromtypes.clear();
    output.clear();
    var amount = getamount();
    shouldBreak = false;

    String? identifier = await UniqueIdentifier.serial;
    if (getboolenvalue()) {
      if (widget.servicetype == 1) // pay
          {
        // output.add(amountfromtypes);
        print(amountfromtypes);
        totalamounts object = totalamounts.pareameters(
            imei: identifier,
            serviceid: widget.serviceid,
            pricevalue: amount,
            parameters: output);
        // output.add(amountmap);

        service.getamounts(object, context).then((value) {
          if (value["data"]["status"] == true) {
            EasyLoading.dismiss();

            openAlert(value['data']["amount"].toString(),
                value['data']["total_amount"].toString(), h);
          } else {
            EasyLoading.dismiss();
            DailogAlert.openbackAlert("${value['message']}",
                 LocalizeAndTranslate.translate("failedmessage"), context);
          }
        });
      } else {
        //output.add(amountfromtypes);
        print(output);
        service
            .inquire(identifier, widget.serviceid, amount, output, context)
            .then((value) {
          print(value);
          if (value["status"] == true) {
            //gettoscreen

            Data inquiryformat = Data.fromJson((value['data']));
            EasyLoading.dismiss();
            Get.to(Detailsinquiry(
              parameters: listsfordetailsinquiry,
              providername: widget.providername,
              responcemodel: inquiryformat,
              service: widget.service,
              arraytosend: output,
            ));
          } else {
            EasyLoading.dismiss();
            DailogAlert.openbackAlert("${value['message']}",
                 LocalizeAndTranslate.translate("failedmessage"), context);
          }
        });
      }
    }
  }

  getboolenvalue() {
    int i = 0;
    for (var item in lists) {
      print(i);
      if (item.type == 1) {
        if (item.required == 1 && valuetyped == null) {
          DailogAlert.openbackAlert( LocalizeAndTranslate.translate('empty'),
               LocalizeAndTranslate.translate("failedmessage"), context);

          shouldBreak = true;
        } else if (valuetyped
            .trim()
            .length < item.min_length! ||
            valuetyped
                .trim()
                .length > item.max_length!) {
          if (item.min_length == item.max_length) {
            //    DailogAlert.openbackAlert("الحقل فارغ!", "فشل", context);
          } else {
            //    DailogAlert.openbackAlert( "الحقل فارغ!", "فشل", context);
          }
          shouldBreak = true;
        }
        amountfromtypes['key'] = item.internal_id;
        amountfromtypes['value'] = myControllers[i];
        output.add({'key': item.internal_id, 'value': myControllers[i].text});
      } else if (item.type == 2) {
        if (item.required == 1 && myControllers[i].text.isEmpty) {
          DailogAlert.openbackAlert( LocalizeAndTranslate.translate('empty'),
               LocalizeAndTranslate.translate("failedmessage"), context);
          shouldBreak = true;
        }
        amountfromtypes['key'] = item.internal_id;
        amountfromtypes['value'] = myControllers[i].text;

        output.add({'key': item.internal_id, 'value': myControllers[i].text});
      } else if (item.type == 3) {
        if (item.required == 1 && myControllers[i].text.isEmpty) {
          DailogAlert.openbackAlert( LocalizeAndTranslate.translate('empty'),
               LocalizeAndTranslate.translate("failedmessage"), context);
          shouldBreak = true;
        }
        amountfromtypes['key'] = item.internal_id;
        amountfromtypes['value'] = myControllers[i].text;
        output.add({'key': item.internal_id, 'value': myControllers[i].text});
      } else if (item.type == 4) {
        if (item.required == 1 && myControllers[i].text.isEmpty) {
          DailogAlert.openbackAlert( LocalizeAndTranslate.translate('empty'),
               LocalizeAndTranslate.translate("failedmessage"), context);
          shouldBreak = true;
        }
        amountfromtypes['key'] = item.internal_id;
        amountfromtypes['value'] = myControllers[i].text;
        output.add({'key': item.internal_id, 'value': myControllers[i].text});
      } else if (item.type == 5) {
        if (item.required == 1) {
          if (_category.isEmpty) {
            DailogAlert.openbackAlert( LocalizeAndTranslate.translate('empty'),
                 LocalizeAndTranslate.translate("failedmessage"), context);
            shouldBreak = true;
          } else {
            amountfromtypes['key'] = item.internal_id.toString();
            amountfromtypes['value'] =
                getvaluefromdatatypes(_category, item).toString();
            output.add({
              'key': item.internal_id,
              'value': getvaluefromdatatypes(_category, item).toString()
            });
          }
        }
        //
      } else if (item.type == 6) {
        if (item.required == 1) {
          if (amountselect!.isEmpty) {
            DailogAlert.openbackAlert( LocalizeAndTranslate.translate('empty'),
                 LocalizeAndTranslate.translate("failedmessage"), context);
            shouldBreak = true;
          } else {
            amountfromtypes['key'] = item.internal_id;
            amountfromtypes['value'] =
                getvaluefromdatatypes(amountselect!, item);

            output.add({
              'key': item.internal_id,
              'value': getvaluefromdatatypes(amountselect!, item)
            });
          }
        }
      }
      if (shouldBreak) {
        EasyLoading.dismiss();
        return false;
      }
      i = i + 1;
    }

    return true;
  }

  createdropdown(parameters item) {
    categories.remove('o');
    return DropdownButtonFormField(
      value: _category,
      onChanged: (newValue) {
        setState(() {
          _category = newValue;
        });
      },
      validator: (value) {
        if (value == null || value == '') {
          return '  فارغ ';
        }
        return null;
      },
      isDense: true,
      items: categories.map((String category) {
        return DropdownMenuItem(
          value: category,
          child: Center(child: Text(category)),
        );
      }).toList(),
      isExpanded: true,
      hint: Center(child: Text(item.name_ar!)),
      decoration: InputDecoration(
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0),
        hintText: item.name_ar,
        hintStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: Color(0xFF00BAB5)),
        filled: true,
        contentPadding:
        const EdgeInsets.only(right: 16, top: 0, bottom: 0, left: 16),
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey)),
      ),
    );
  }


  void openAlert(String amount, String totalamount, double h) {
    var dialog = Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)),
        backgroundColor: Color(0xfFFfffff),
        elevation: 4,
        //this right here
        child: Container(

          height: h * .22,
          width: double.infinity,
          child: Center(
            child:
            Container(


              padding: EdgeInsets.symmetric(horizontal: 24),

              child: ListView(
                shrinkWrap: true,
                children: [

                  Center(
                    child: Text( LocalizeAndTranslate.translate("confirm"),
                        style:
                        TextStyle(fontSize: 20, color: CustomColors.MainColor)),
                  ),

                  Center(
                    child: Text(
                      "${ LocalizeAndTranslate.translate("amunt")}: ${amount
                          .toString()} EGp",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: CustomColors.MainColor),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                        "${ LocalizeAndTranslate.translate("totalamount")}: ${totalamount
                            .toString()} EGp ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: CustomColors.MainColor)),
                  ),
                  SizedBox(height: 5),
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
                            child: Text(
                               LocalizeAndTranslate.translate("cancel"),
                              style: TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: MaterialButton(
                            onPressed: () async {
                              EasyLoading.show(
                                  status:  LocalizeAndTranslate.getLanguageCode() == 'ar'
                                      ? 'جاري التحميل '
                                      : 'loading...',
                                  maskType: EasyLoadingMaskType.black);
                              String? identifier = await UniqueIdentifier
                                  .serial;
                              paymentmodel objectmodel = paymentmodel
                                  .pareameters(
                                  amount: amount,
                                  imei: identifier,
                                  total: totalamount,
                                  serviceid: widget.serviceid,
                                  parameters: output);

                              service.payment(objectmodel, context).then((
                                  value) {
                                if (value['status'] == true) {
                                  Data paymentformat = Data.fromJson(
                                      value['data']);
                                  print('yyy${paymentformat.clientNumber}');
                                  NotificationApi()
                                      .checkinvoice(
                                      widget.service.id,
                                      paymentformat.clientNumber
                                          .toString(), // int.parse
                                      context)
                                      .then((value3) {
                                    print(value3);
                                    if (value3['status'] == true) {
                                      EasyLoading.dismiss();
                                      DailogAlert.opennotifyAlert(
                                           LocalizeAndTranslate.getLanguageCode() == 'en'
                                              ? "Alert" : "تنبيه",
                                           LocalizeAndTranslate.getLanguageCode() == 'en'
                                              ? "Are you want add this service to reminder"
                                              : "هل تريد اضافه الخدمه لتذكيرك في وقتها ؟",
                                          context,
                                          widget.service.id!,
                                          paymentformat.clientNumber,
                                          paymentformat,
                                          widget.service.type!);
                                    } else {
                                      EasyLoading.dismiss();
                                      Get.off(fatora_details(
                                        bluknumber: 0,
                                        isbluck: false,
                                        paymentobject: paymentformat,
                                        servicetype: widget.servicetype,
                                      ));
                                    }
                                  });
                                } else {
                                  EasyLoading.dismiss();
                                  DailogAlert.openbackAlert(
                                      "${value['message']}",
                                       LocalizeAndTranslate.translate("failedmessage"),
                                      context);
                                }
                              });
                            },
                            color: CustomColors.MainColor,
                            child: Text(
                               LocalizeAndTranslate.translate("ok"),
                              style: TextStyle(
                                  fontSize: 12, color: Colors.white),
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
            ),
          ),)
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
