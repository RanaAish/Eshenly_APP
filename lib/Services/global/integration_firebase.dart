// ignore_for_file: unused_local_variable, unused_element

import 'package:esh7enly/Services/global/LocalNotification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class FirebaseApi {
  final firebasemessiging = FirebaseMessaging.instance;
Future<void> initialnotification() async {
    await firebasemessiging.requestPermission();
    await firebasemessiging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final fcmtoken = await firebasemessiging.getToken();
    initialpushnotification();
  }





  void handlemessage(RemoteMessage? message) {

    if (message == null) return;
    LocalNotificationApi().shownotification(message: message);
    //Get.to fawatery فواتيري
    //Get.to(AccountSetting());
  }

  Future initialpushnotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handlemessage);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      handlemessage(message);
    });
  
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationApi().shownotification(message: message);
      //print('Got a message whilst in the foreground!');
     // print(message.notification);

    });
  }
}
/*Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background messa-: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
} */
//"d5iMIlDCSWaSDkMgeqk-YG:APA91bHVXcXfGzvziYBreYcMX8VK1riDBtM6nbkiV2jvTVFORPbaV1QcX9eJMJHEH7l-Do0aGMeejLALv1hgfY0N5yK60yaF4ZlGbUQR5W79RP-4gweRJyyxQ91n0_9HWdaPpg3CcsE7"
/*Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('ii');
  print('Notification Title: ${message.data['title']}');

  if (message.messageId != "") {
    // print("Have received a background message! Will have to grab the message from here somehow if the user didn't interact with the system tray message link");
  }
}
FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);*/
/* 

class Defaultconfigfirebas {
  static FirebaseOptions get getoptions {
    return const FirebaseOptions(
      apiKey: 'AIzaSyCGDYZBaofP0GXxU9zOuWd-SZGONrKMWH4',
      appId: '1:521329644225:android:ee2bfe8ea3924bc0c63a40',
      messagingSenderId: '521329644225',
      projectId: 'clinic-34939',
      androidClientId:
          "521329644225-33rion86vkqno5qbffdle0p8mo4nmnap.apps.googleusercontent.com",
    );
  }
}
 FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        token = value;
      
      });
    }); */
