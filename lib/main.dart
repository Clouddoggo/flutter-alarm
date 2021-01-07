import 'package:firebase_core/firebase_core.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm/addAlarm.dart';
import 'package:flutter_alarm/alarmRing.dart';
import 'package:flutter_alarm/alarmsList.dart';
import 'package:flutter_alarm/settings.dart';
import 'homepage.dart';

void printHello() {
  final DateTime now = DateTime.now();
  print("[$now] Hello, world! function='$printHello'");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AndroidAlarmManager.initialize();
  runApp(MyApp());
  await AndroidAlarmManager.periodic(
      const Duration(seconds: 20), 1, printHello);
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
