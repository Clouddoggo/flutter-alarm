import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';

// const String countKey = 'count';
//
// /// The name associated with the UI isolate's [SendPort].
// const String isolateName = 'isolate';
//
// /// A port used to communicate from a background isolate to the UI isolate.
// final ReceivePort port = ReceivePort();
//
// /// Global [SharedPreferences] object.
// SharedPreferences prefs;
//
// void printHello() {
//   final DateTime now = DateTime.now();
//   final int isolateId = Isolate.current.hashCode;
//   print("[$now] Hello, world! isolate=$isolateId function='$printHello'");
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Register the UI isolate's SendPort to allow for communication from the
  // background isolate.
  // IsolateNameServer.registerPortWithName(
  //   port.sendPort,
  //   isolateName,
  // );
  // prefs = await SharedPreferences.getInstance();
  // if (!prefs.containsKey(countKey)) {
  //   await prefs.setInt(countKey, 0);
  // }
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Alarm',
      home: HomePage(title: 'Flutter Alarm'),
    );
  }
}
