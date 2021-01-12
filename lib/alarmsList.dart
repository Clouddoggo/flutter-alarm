import 'dart:async';
import 'dart:ui';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm/editAlarm.dart';
import 'package:intl/intl.dart';
import 'package:flutter_alarm/util/receivedNotification.dart';
import 'package:flutter_alarm/util/notificationUtil.dart';
import 'alarmRing.dart';
import 'storage.dart';

class AlarmsListPage extends StatefulWidget {
  AlarmsListPage({Key key}) : super(key: key);

  @override
  _AlarmsListPageState createState() => _AlarmsListPageState();
}

class _AlarmsListPageState extends State<AlarmsListPage> {
  String _time;
  String _date;

  @override
  void initState() {
    super.initState();
    Timer.periodic(
        Duration(
          milliseconds: 50,
        ),
        (Timer t) => _getDateTime());
    _configureSelectNotificationSubject();
    _configureDidReceiveLocalNotificationSubject();
    requestPermissions();
  }

  void _getDateTime() {
    var _dateTime = new DateTime.now();
    final String formattedDate =
        DateFormat('dd MMM').format(_dateTime).toString();
    final String formattedTime =
        DateFormat('kk:mm').format(_dateTime).toString();
    if (this.mounted) {
      setState(() {
        _time = formattedTime;
        _date = formattedDate;
      });
    }
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    bool isAfterSix = document.get('time').toDate().hour > 17;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ListTile(
        leading: isAfterSix
            ? Transform.rotate(
                angle: 180 * math.pi / 180,
                child: Icon(
                  Icons.brightness_2_outlined,
                  size: 22,
                  color: Color(0xffA771DE),
                ),
              )
            : Icon(
                Icons.brightness_low_outlined,
                size: 22,
                color: Color(0xffFB81D1),
              ),
        title: Text(
          DateFormat('kk:mm').format(document.get('time').toDate()).toString(),
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
        ),
        subtitle: Text(
          document.get('remarks') ?? 'No remarks',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete_outline,
            size: 24,
          ),
          color: Colors.red[700],
          highlightColor: Colors.amberAccent,
          onPressed: () {
            Storage.deleteAlarm(document.id);
          },
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      EditAlarmPage(documentId: document.id)));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F8FF),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 65.0, bottom: 5.0),
              child: Text(
                " $_date ",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Text(
              " $_time ",
              style: TextStyle(
                fontSize: 60.0,
                color: Color(0xffFBB500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.pushNamed(context, '/addAlarm');
                  },
                  color: Colors.orange[600],
                  highlightColor: Colors.blue[200],
                ),
              ),
            ),
            StreamBuilder(
              stream: Storage.getStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Text(
                    'no alarms yet',
                  ));
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) => _buildListItem(
                          context, snapshot.data.documents[index])),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      await Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => AlarmRingPage(payload: payload),
        ),
      );
    });
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        AlarmRingPage(payload: receivedNotification.payload),
                  ),
                );
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }
}
