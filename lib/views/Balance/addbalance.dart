// ignore_for_file: unnecessary_import, prefer_typing_uninitialized_variables, non_constant_identifier_names, unused_local_variable, deprecated_member_use, prefer_const_constructors, sized_box_for_whitespace, unnecessary_brace_in_string_interps
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:unique_identifier/unique_identifier.dart';
import '../../Services/features/BankApi.dart';
import '../../core/utils/colors.dart';
import '../../core/widgets/CustomTextField.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Addbalance extends StatefulWidget {
  const Addbalance({Key? key}) : super(key: key);

  @override
  State<Addbalance> createState() => _AddbalanceState();
}

class _AddbalanceState extends State<Addbalance> {
  late var balancecontroller = TextEditingController();
  late var phonecontroller = TextEditingController();
  final storage = const FlutterSecureStorage();
  var totalamount = "";
  var fees = "";
  BankApi object = BankApi();
  var uidtransaction;
  bool pressbank = false;
  bool presswallet = false;
  bool presscash = false;
  bool tab = true;
  String? message;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var screenWidth =MediaQuery.of(context).size.width;
    var screenHeight =MediaQuery.of(context).size.height;


    return Scaffold(
        backgroundColor: Colors.white,
        body:  SingleChildScrollView(
                child: Directionality(
                    textDirection:
                        // ignore: unrelated_type_equality_checks
                         LocalizeAndTranslate.getLanguageCode() == 'en'
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                    child: Form(
                      key: _globalKey,
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
                                  Text(
                                    '   ${ LocalizeAndTranslate.translate("addbalance")}',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: 'ReadexPro',
                                      color: Colors.white,
                                    ),
                                  ),
                                ]),
                              )),
                          SizedBox(
                            height: 150,
                          ),
                        Get_ui_card(screenHeight,screenWidth)
                        ])))));
  }
  void openAlertwarning (double h) {

    var dialog = Dialog(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child: Container(
        height: h*.21, //20
        width: double.infinity,
        child: Center(
          child:
          Container(
          margin: EdgeInsets.only(top: 6),
          //   decoration: boxDecorationStylealert,
         // width: 230,
          padding: EdgeInsets.symmetric(horizontal: 10),

          child:  ListView(
            shrinkWrap: true,
            //crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: Text(  LocalizeAndTranslate.getLanguageCode()=='ar'?"تحذير":"Warning",
                    style:
                    TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              ),
             SizedBox(height: 3,),
              Center(
                child: Text(
                   LocalizeAndTranslate.translate("waringmsg"
                  ),
                ),
              ),
              SizedBox(height: 2,),
              Center(
                child:  Padding(
                    padding:
                    EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 0),
                    child: MaterialButton(
                      onPressed: () async {
                        if (pressbank == true) {
                          Get.back();
                          EasyLoading.show(
                              status:  LocalizeAndTranslate
                                  .getLanguageCode() ==
                                  'ar'
                                  ? 'جاري التحميل '
                                  : 'loading...',
                              maskType:
                              EasyLoadingMaskType
                                  .black);
                          object
                              .getamount(
                              double.parse(
                                  balancecontroller
                                      .text
                                      .toString()),
                              context,
                              "visa")
                              .then((value) {
                            setState(() {
                              totalamount =
                                  value['amount']
                                      .toString();

                              fees = value['fees']
                                  .toString();
                            });
                            getbodybank(h);
                          });
                        }
                        if (presscash == true) {

                          String? identifier =
                          await UniqueIdentifier
                              .serial;

                          Get.back();
                          EasyLoading.show(
                              status:  LocalizeAndTranslate
                                  .getLanguageCode() ==
                                  'ar'
                                  ? 'جاري التحميل '
                                  : 'loading...',
                              maskType:
                              EasyLoadingMaskType
                                  .black);
                          await object
                              .totalamountvodavonecache(
                              identifier!,
                              balancecontroller.text,
                              phonecontroller.text,
                              context);
                          //    await modelhud.changeisloading(false);
                        }
                      },
                      color: CustomColors.MainColor,
                      // ignore: sort_child_properties_last
                      child: Text(
                        LocalizeAndTranslate.getLanguageCode()=='ar'?'موافق':'Ok',
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
      ));
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
   Widget Get_ui_card( double screenHeight,double screenWidth)
   {
    return   Container(
        width: 380,
        height: presscash?320:260,
        child: Card(
            color: Colors.transparent,
            surfaceTintColor:Colors.white,
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.only(
                top: 10, bottom: 1, right: 23, left: 23),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: CustomColors.MainColor,
                  width: 1),
              borderRadius: BorderRadius.circular(
                1.0,
              ),
            ),
            child: SizedBox(
                height: 1000,
                child: SingleChildScrollView(child:Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 30,
                            right:40,
                            left: 40,
                            bottom: 7),
                        child: CustomTextField(
                          hint:  LocalizeAndTranslate
                              .translate("enter money"),
                          w: 60,
                          type: TextInputType.number,
                          controller: balancecontroller,
                          OnTab: () {},
                        )),
                    Container(
                        height: 36,//48
                        width: screenWidth*0.82,
                        margin: const EdgeInsets.only(
                            top: 18, right: 13, left: 14),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: CustomColors.MainColor,
                          ),
                          borderRadius:
                          BorderRadius.circular(5),
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(
                                right: 0, left: 0),
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {


                                          pressbank = true;

                                          presscash = false;
                                        });
                                      },
                                      child: Container(
                                          width: screenWidth*.38, //133
                                          height: 50,
                                          color: pressbank
                                              ? CustomColors
                                              .MainColor
                                              : Colors.white,
                                          child:  Center
                                            (child:Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/bank-wallet icon -02.svg",
                                              ),
                                              Text(
                                                   LocalizeAndTranslate
                                                      .translate(
                                                      "bank"),
                                                  style:
                                                  TextStyle(
                                                    color:pressbank
                                                        ? Colors.white:Colors.black,
                                                    // overflow: TextOverflow.ellipsis,
                                                    fontFamily:
                                                    'ReadexPro',
                                                    fontSize: 14,
                                                  ))
                                            ],
                                          ),))
                                  ),

                                  SizedBox(width: 0), //26
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          presscash = true;
                                          pressbank = false;
                                        });
                                      },
                                      //Expanded(child:
                                      child: Container(
                                        width: screenWidth*.36, //125
                                        height: 50,
                                        color: presscash
                                            ? CustomColors
                                            .MainColor
                                            : Colors.white,
                                        child:  Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/bank-wallet icon -01.svg",
                                              width: 15,
                                              height: 15,
                                            ),
                                            Expanded(child: Text(
                                               LocalizeAndTranslate
                                                  .translate(
                                                  "vodavonecash"),
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13,
                                                color: presscash
                                                    ? Colors.white:Colors.black,
                                                fontFamily:
                                                'ReadexPro',
                                              ),
                                            ))
                                          ],
                                        ),)
                                  ),

                                ]))),
                    presscash == true
                        ? getbodyvodafonecache()
                        : SizedBox(height: 0, width: 0),

                    SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if(_globalKey.currentState!.validate())
                        {
                          openAlertwarning (screenHeight);
                        }


                      },
                      child: Container(
                        height: 40,
                        margin:
                        const EdgeInsets.symmetric(
                            horizontal: 48),
                        decoration: BoxDecoration(
                          color: CustomColors.MainColor,
                          borderRadius:
                          BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                             LocalizeAndTranslate.translate("pay"),
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'ReadexPro',
                                fontSize: 17,
                                fontWeight:
                                FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                )))));
   }
  void openAlert(String statuss, String mess,double h) {
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor:Color(0xfFFfffff),
      elevation: 4,
      child:  Container(

        height: h*.18,
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
                child: Text(statuss == "success" ? "Success" : "Failed",
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
                        if (statuss == "success") {
                          Get.back();
                          Get.back();
                        } else {
                          Get.back();
                        }
                      },
                      color: CustomColors.MainColor,
                      // ignore: sort_child_properties_last
                      child: Text(
                        "OK",
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



  PaymentSdkConfigurationDetails generateConfig(
      String name, String email, String mobile) {
    var billingDetails = BillingDetails(
        name, email, mobile, "Egypt", "eg", "Egypt", "Egypt", "12345");
    var shippingDetails = ShippingDetails(
        name, email, mobile, "Egypt", "eg", "Egypt", "Egypt", "1245");

    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.AMAN);
    final configuration = PaymentSdkConfigurationDetails(
      //production
        profileId: "135102",
        serverKey: "S6JNKTLWMN-JHMWN69W6T-LGBM26GMDW",
        clientKey: "CKKM7G-T7DK6H-NVQGPV-79P22K",
        cartId: "1",
        cartDescription: "ادفع الان مع اشحنلي",
        merchantName: "اشحنلي",
        screentTitle:  LocalizeAndTranslate.getLanguageCode() == 'en'
            ? "Pay now with esh7enly"
            : "ادفع الان مع اشحنلي",
        amount: double.parse(totalamount),
        showBillingInfo: false,
        forceShippingInfo: false,
        currencyCode: "EGP",
        merchantCountryCode: "EG",
        billingDetails: billingDetails,
        shippingDetails: shippingDetails,
        alternativePaymentMethods: apms,
        locale:  LocalizeAndTranslate.getLanguageCode() == 'en'
            ? PaymentSdkLocale.EN
            : PaymentSdkLocale.AR,
        linkBillingNameWithCardHolderName: true);

    final theme = IOSThemeConfigurations();
    theme.logoImage = "assets/logo.png";
    theme.secondaryColor = "bc3827"; // Color hex value
    theme.buttonColor = "bc3827";

    configuration.iOSThemeConfigurations = theme;
    //configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
    return configuration;
  }

  Future<void> payPressed(
      String name, String email, String mobile, int id,double h) async {
    FlutterPaytabsBridge.startCardPayment(generateConfig(name, email, mobile),
        (event) {
      setState(() {
        Map transactionDetails = new Map();
        Map Result = new Map();
        print(event);
        if (event["status"] == "success") {
          // Handle transaction details here.

          transactionDetails = event["data"];

          if (transactionDetails["isSuccess"]) {
            
            Result.addAll({
               'amount': balancecontroller.text,
              'status': 'SUCCESSFUL',
              'id': id,
              'totalamount': event['data']['cartAmount'],
              "payment_method_type": "paytabs",
              "transaction_type": 'visa',
              "card_id": event['data']['cartID'],
              "cartDescription": event['data']['cartDescription'],
              "isAuthorized": event['data']['isAuthorized'],
              "isOnHold": event['data']['isOnHold'],
              "isPending": event['data']['isPending'],
              "isProcessed": event['data']['isProcessed'],
              "isSuccess": event['data']['isSuccess'],
              "payResponseReturn": event['data']['payResponseReturn'],
              "responseCode": event['data']['paymentResult']['responseCode'],
              "responseMessage": event['data']['paymentResult']
                  ['responseMessage'],
              "responseStatus": event['data']['paymentResult']
                  ['responseStatus'],
              "transactionReference": event['data']['transactionReference'],
              "transactionTime": event['data']['paymentResult']
                  ['transactionTime'],
              "transactionType": event['data']['transactionType'],
            });

            object.payamount(Result, context).then((value) {
              // storage.delete(key: 'uid');
              //storage.delete(key: 'id');
              EasyLoading.dismiss();
              print(Result);
              openAlert(
                "success",
                'تم اضافه الرصيد لحسابك',h
              );
              print('uuu${event['data']['cartAmount']}');
            });
            print("successful transaction");
          } else {
            // transactionDetails.add({'status': 'FAILED'});
             Result.addAll({
                 'amount': balancecontroller.text,
              'status': 'FAILED',
              'id': id,
              'totalamount': event['data']['cartAmount'],
              "payment_method_type": "paytabs",
              "transaction_type": 'visa',
              
              "card_id": event['data']['cartID'],
              "cartDescription": event['data']['cartDescription'],
              "isAuthorized": event['data']['isAuthorized'],
              "isOnHold": event['data']['isOnHold'],
              "isPending": event['data']['isPending'],
              "isProcessed": event['data']['isProcessed'],
              "isSuccess": event['data']['isSuccess'],
              "payResponseReturn": event['data']['payResponseReturn'],
              "responseCode": event['data']['paymentResult']['responseCode'],
              "responseMessage": event['data']['paymentResult']
                  ['responseMessage'],
              "responseStatus": event['data']['paymentResult']
                  ['responseStatus'],
              "transactionReference": event['data']['transactionReference'],
              "transactionTime": event['data']['paymentResult']
                  ['transactionTime'],
              "transactionType": event['data']['transactionType'],
            });

            object.payamount(transactionDetails, context).then((value) {
              // storage.delete(key: 'uid');
              print(transactionDetails);
              EasyLoading.dismiss();
              openAlert(
                "Failed",
                " Sorry failed transaction",h
              );
            });
            print("failed transaction");
          }
        } else if (event["status"] == "error") {
          // Handle error here.
          transactionDetails.addAll({
            'status': 'FAILED',
            'id': id,
            'amount': balancecontroller.text,
            "payment_method_type": "paytabs",
            "transaction_type": 'visa'
          });

          object.payamount(transactionDetails, context).then((value) {
            // storage.delete(key: 'uid');
            EasyLoading.dismiss();
            openAlert(
              "Failed",
              event['message'],h
            );
          });

          print('erroe');
        } else if (event["status"] == "event") {
          // Handle events here.
          // transactionDetails.add({'status': 'FAILED'});
          transactionDetails = ({
            'status': 'CANCELLED',
            'id': id,
            'amount': balancecontroller.text,
            "payment_method_type": "paytabs",
            "transaction_type": 'visa',
            "errorMsg": "canceled",
            "errorCode": "401"
          });

          object.payamount(transactionDetails, context).then((value) {
            // storage.delete(key: 'uid');
            EasyLoading.dismiss();
            openAlert(
              "Failed",
              event['message'],h
            );
            print(transactionDetails);
          });
          print("canceled transaction");
        }
      });
    });
  }

  getbodybank(double screenHeight) {

    EasyLoading.dismiss();
    var dialog = Dialog(

      backgroundColor:Color(0xfFFfffff),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child:  Container(

        height: screenHeight*.32,
        width: double.infinity,
        child:Center(child: Container(


          padding: EdgeInsets.symmetric(horizontal: 10),

          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text( LocalizeAndTranslate.translate("confirm"),
                    style: TextStyle(
                        color: CustomColors.MainColor,
                        fontSize: 19,
                        fontWeight: FontWeight.bold)),
              ),
            // Spacer(),
              SizedBox(height:4),
              Center(
                  child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 15, left: 30),
                      child: Row(
                        children: [
                          Text(
                            "Service cost  :  ",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'ReadexPro',
                                fontWeight: FontWeight.bold),
                          ),
                          Text("${balancecontroller.text} EGP")
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 15, left: 30),
                      child: Row(
                        children: [
                          Text(
                            "Service Fees  :  ",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'ReadexPro',
                                fontWeight: FontWeight.bold),
                          ),
                          Text("${fees} EGP")
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 15, bottom: 12),
                    child: Row(
                      children: [
                        Text(
                          "Total Amount :  ",
                          style: TextStyle(
                              color: CustomColors.MainColor,
                              fontFamily: 'ReadexPro',
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text("${totalamount} EGP")
                      ],
                    ),
                  ),
                ],
              )),
            //  Spacer(),
              SizedBox(height:4),
              Center(
                  child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 0),
                      child: MaterialButton(
                        onPressed: () async {
                          EasyLoading.show(
                              status:  LocalizeAndTranslate.getLanguageCode() == 'ar'
                                  ? 'جاري التحميل '
                                  : 'loading...',
                              maskType: EasyLoadingMaskType.black);
                          object
                              .startsession(
                                  double.parse(totalamount),
                                  double.parse(balancecontroller.text),
                                  context,
                                "visa")
                              .then((value) async {
                            if (value['status'] == true) {
                              print('test');
                              var id = value['data']['id'];
                              storage.write(
                                  key: 'id',
                                  value: value['data']['id'].toString());
                              //goto paytabs
                              Get.back();

                              var name = await storage.read(key: 'name');
                              var mobile = await storage.read(key: 'mobile');
                              var email = await storage.read(key: 'email');

                                await payPressed(name!, email!, mobile!,
                                    value['data']['id'],screenHeight);

                            } else {
                              EasyLoading.dismiss();
                              DailogAlert.openbackAlert(
                                  value['message'], 'Failed', context);
                            }
                          });
                        },
                        color: CustomColors.MainColor,
                        // ignore: sort_child_properties_last
                        child: Text(
                           LocalizeAndTranslate.translate('ok'),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 0),
                      child: MaterialButton(
                        onPressed: () async {
                          Get.back();
                        },
                        color: CustomColors.MainColor,
                        // ignore: sort_child_properties_last
                        child: Text(
                           LocalizeAndTranslate.translate("cancel"),
                          style: TextStyle(fontSize: 16, color: Colors.white),
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
    ));
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  Widget getbodyvodafonecache() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 25,
          right:40,
          left: 40,
          bottom: 0),

        child: CustomTextField(
          bordercolor: CustomColors.MainColor,
          hint:  LocalizeAndTranslate.translate("enter phone"),
          w: 60,
          type: TextInputType.number,
          completetext: () {

          },
          controller: phonecontroller,
          OnTab: () {},
        ));
  }
}

