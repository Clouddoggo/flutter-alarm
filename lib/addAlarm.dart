import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
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
  DateTime _dateTime;
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF1F8FF),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    "date",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "time",
                    style: TextStyle(fontSize: 55.0),
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
                      RaisedButton(
                        color: Color.fromRGBO(92, 184, 92, 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            Storage.addAlarm({
                              'name': _name,
                              'remarks': _remarks,
                              'dateTime': DateTime.now(),
                              'password': _password,
                            });
                            callback();
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
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
