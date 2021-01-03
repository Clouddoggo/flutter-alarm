import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'storage.dart';
import 'addAlarm.dart';

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
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getDateTime());
    AndroidAlarmManager.initialize();
  }

  void _getDateTime() {
    var _dateTime = new DateTime.now();
    final String formattedDate =
        DateFormat('dd MMM').format(_dateTime).toString();
    final String formattedTime =
        DateFormat('kk:mm').format(_dateTime).toString();
    setState(() {
      _time = formattedTime;
      _date = formattedDate;
    });
  }

  Future navigateToPage(context, page) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Text("time picker"),
      subtitle: Text(
        document.get('name'),
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete_outline,
          size: 20,
        ),
        highlightColor: Colors.redAccent,
        onPressed: () {
          Storage.deleteAlarm(document.id);
        },
      ),
      onTap: () {
        print("tapped");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F8FF),
      body: Center(
        child: SafeArea(
          child: Container(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(top: 65.0, bottom: 5.0),
                child: Text(
                  _date,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Text(
                _time,
                style: TextStyle(fontSize: 55.0),
              ),
              SizedBox(
                height: 20,
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
            ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToPage(context, AddAlarmPage());
        },
        child: Icon(Icons.add_alarm),
        backgroundColor: Colors.amber[400],
        elevation: 15,
      ),
    );
  }
}
