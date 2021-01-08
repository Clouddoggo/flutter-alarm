import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'notificationUtil.dart';
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

  static Future<void> callback() async {
    print("Alarm fired successfully!");
    var now = tz.TZDateTime.now(tz.getLocation('America/Detroit'))
        .add(Duration(seconds: 5));
    await singleNotification(localNotificationsPlugin, now, "Notification",
        "testing", Random().nextInt(100));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F8FF),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(children: [
                SizedBox(
                  height: 40.0,
                ),
                TextButton(
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (date) {
                        setState(() {
                          _date = date;
                          _dateString =
                              DateFormat.MMMMd().format(_date).toString();
                        });
                        print('confirm $date');
                      },
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
                      onConfirm: (time) {
                        setState(() {
                          _time = time;
                          _timeString =
                              DateFormat.jm().format(_time).toString();
                        });
                        print('confirm $time');
                      },
                      showSecondsColumn: false,
                    );
                  },
                  child: Text(
                    _timeString ??
                        DateFormat.jm().format(DateTime.now()).toString(),
                    style: TextStyle(color: Colors.amber, fontSize: 60),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            fontSize: 13,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          isDense: true,
                        ),
                        validator: (value) {
                          if (value.isEmpty || value.trim().length < 1) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (value) => {
                          setState(() {
                            this._name = value;
                          })
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Remarks',
                            labelStyle: TextStyle(
                              fontSize: 13,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            isDense: true,
                          ),
                          onChanged: (value) => {
                            setState(() {
                              this._remarks = value;
                            })
                          },
                        ),
                      ),
                      // TODO: add option to use pattern lock [https://pub.dev/packages/pattern_lock/]
                      // TODO: generate random password for users
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize: 13,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            isDense: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty || value.trim().length < 1) {
                              return 'Password cannot be empty';
                            } else if (value.trim().length < 10) {
                              return "Password requires more than 9 characters";
                            }
                            return null;
                          },
                          onChanged: (value) => {
                            setState(() {
                              this._password = value;
                            })
                          },
                        ),
                      ),
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
                            Storage.addAlarm({
                              'name': _name,
                              'remarks': _remarks,
                              'date': _date ?? DateTime.now(),
                              'time': _time ?? DateTime.now(),
                              'password': _password,
                            });
                            callback();
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
                      RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(15.0)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.red[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
