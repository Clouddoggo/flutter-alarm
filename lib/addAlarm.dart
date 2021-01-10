import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_alarm/util/widgetsUtil.dart';
import 'package:flutter_alarm/util/notificationUtil.dart';
import 'main.dart';
import 'storage.dart';

class AddAlarmPage extends StatefulWidget {
  AddAlarmPage({Key key}) : super(key: key);

  @override
  _AddAlarmPageState createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {
  final _formKey = GlobalKey<FormState>();
  String _dateString, _timeString;
  DateTime _date, _time;
  String _name;
  String _remarks;
  String _password;

  static Future<void> callback(docId, notificationId) async {
    print("Callback to fire alarm!!");
    var now = tz.TZDateTime.now(tz.getLocation('America/Detroit'))
        .add(Duration(seconds: 10));
    await singleNotification(localNotificationsPlugin, now, "Notification",
        "testing", notificationId, docId);
  }

  void onChangePassword(value) => {
        setState(() {
          this._password = value;
        })
      };

  void onChangedRemarks(value) => {
        setState(() {
          this._remarks = value;
        })
      };

  void onChangedName(value) => {
        setState(() {
          this._name = value;
        })
      };

  void onConfirmTime(time) {
    setState(() {
      _time = time;
      _timeString = DateFormat.jm().format(_time).toString();
    });
    print('confirm $time');
  }

  void onConfirmDate(date) {
    setState(() {
      _date = date;
      _dateString = DateFormat.MMMMd().format(_date).toString();
    });
    print('confirm $date');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F8FF),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(children: [
              SizedBox(
                height: 20.0,
              ),
              TextButton(
                onPressed: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    onConfirm: onConfirmDate,
                    minTime: DateTime.now(),
                    maxTime: DateTime.now().add(Duration(days: 14)),
                  );
                },
                child: Text(
                  _dateString ??
                      DateFormat.MMMMd().format(DateTime.now()).toString(),
                  style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () {
                  DatePicker.showTimePicker(
                    context,
                    showTitleActions: true,
                    onConfirm: onConfirmTime,
                    showSecondsColumn: false,
                  );
                },
                child: Text(
                  _timeString ??
                      DateFormat.jm().format(DateTime.now()).toString(),
                  style: TextStyle(color: Colors.amber, fontSize: 60),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                  children: [
                    buildNameField(onChangedName),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: buildRemarksField(onChangedRemarks),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: buildPasswordField(onChangePassword),
                    ),
                    buildPasswordRules(),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(15.0)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          int notificationId = Random().nextInt(1000);
                          var docId = await Storage.addAlarm({
                            'name': _name,
                            'remarks': _remarks,
                            'date': _date ?? DateTime.now(),
                            'time': _time ?? DateTime.now(),
                            'password': _password,
                            'notificationId': notificationId,
                          });
                          callback(docId, notificationId);
                          print("id: $docId");
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    buildCancelButton(context),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
