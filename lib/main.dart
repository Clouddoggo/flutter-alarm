import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm/addAlarm.dart';
import 'package:flutter_alarm/alarmRing.dart';
import 'package:flutter_alarm/alarmsList.dart';
import 'package:flutter_alarm/settings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'homepage.dart';

// TODO: add google/facebook auth

FlutterLocalNotificationsPlugin localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

String currentTimezone = 'Unknown';

initializeNotifications() async {
  var initializeAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  var initSettings = InitializationSettings(android: initializeAndroid);
  await localNotificationsPlugin.initialize(initSettings);

  currentTimezone = await FlutterNativeTimezone.getLocalTimezone();
  print("timezone $currentTimezone");
}

Future singleNotification(
    tz.TZDateTime datetime, String message, String subtext, int hashcode,
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
      payload: hashcode.toString(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
}
//
// Future showInsistentNotification(
//     String title, String body, int hashcode) async {
//   AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//           'your channel id', 'your channel name', 'your channel description',
//           importance: Importance.max,
//           priority: Priority.high,
//           ticker: 'ticker',
//           additionalFlags: Int32List.fromList(<int>[4]));
//
//   NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);
//
//   await localNotificationsPlugin.show(
//       hashcode, title, body, platformChannelSpecifics,
//       payload: hashcode.toString());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await AndroidAlarmManager.initialize();
  await initializeNotifications();
  tz.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Alarm',
      home: HomePage(
        title: 'Flutter Alarm',
      ),
      initialRoute: '/',
      routes: {
        '/alarms': (context) => AlarmsListPage(),
        '/addAlarm': (context) => AddAlarmPage(),
        '/settings': (context) => SettingsPage(),
        '/ring': (context) => AlarmRingPage()
      },
    );
  }
}
