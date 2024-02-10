
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


import 'dart:math';

class LocalNotificationApi {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            playSound: true,
            priority: Priority.high,
            //sound: RawResourceAndroidNotificationSound('yourmp3files'),
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future shownotification(
      {int id = 0, required RemoteMessage message}) async {
    print(message.data['id']);
    print(message.messageId);
    var idnum = Random();
    return notificationsPlugin.show(
    idnum.nextInt(100),message.data['title'], message.data['message'], await _notificationDetails());
  }




}