import 'dart:typed_data';

import 'package:flutter_alarm/receivedNotification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:rxdart/rxdart.dart';
import 'main.dart';

String currentTimezone = 'Unknown';

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

initializeNotifications(
    FlutterLocalNotificationsPlugin localNotificationsPlugin) async {
  var initializeAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  var initSettings = InitializationSettings(android: initializeAndroid);
  await localNotificationsPlugin.initialize(initSettings,
      onSelectNotification: onSelectNotification);

  currentTimezone = await FlutterNativeTimezone.getLocalTimezone();
}

Future singleNotification(
    FlutterLocalNotificationsPlugin localNotificationsPlugin,
    tz.TZDateTime datetime,
    String message,
    String subtext,
    int hashcode,
    String docId,
    {String sound}) async {
  var androidChannel = AndroidNotificationDetails(
    'channel-id',
    'channel-name',
    'channel-description',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    additionalFlags: Int32List.fromList(<int>[4]),
  );

  var platformChannel = NotificationDetails(android: androidChannel);
  localNotificationsPlugin.zonedSchedule(
      hashcode, message, subtext, datetime, platformChannel,
      payload: docId,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
}
