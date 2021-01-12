import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_alarm/util/notificationUtil.dart';
import 'package:flutter_alarm/util/widgetsUtil.dart';
import 'storage.dart';
import 'main.dart';

class EditAlarmPage extends StatefulWidget {
  EditAlarmPage({Key key, this.documentId}) : super(key: key);

  final String documentId;

  @override
  _EditAlarmPageState createState() => _EditAlarmPageState();
}

class _EditAlarmPageState extends State<EditAlarmPage> {
  final _formKey = GlobalKey<FormState>();
  String _dateString, _timeString;
  DateTime _date, _time;
  String _remarks;
  String _password;

  void inititaliseDetails() async {
    await Storage.getAlarmDetails(widget.documentId).then((document) {
      setState(() {
        this._remarks = document.get('remarks');
        this._password = document.get('password');
        this._date = document.get('date').toDate();
        this._time = document.get('time').toDate();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    inititaliseDetails();
  }

  Future<void> callback(docId, notificationId, remarks) async {
    var now = tz.TZDateTime.now(
            tz.getLocation(await FlutterNativeTimezone.getLocalTimezone()))
        .add(Duration(seconds: 10));
    cancelAlarm(notificationId);
    await singleNotification(localNotificationsPlugin, now, "Flutter alarm",
        remarks, notificationId, docId);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F8FF),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: _formKey,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        TextButton(
                          onPressed: () {
                            DatePicker.showDatePicker(
                              context,
                              showTitleActions: true,
                              onConfirm: (date) {
                                setState(() {
                                  _date = date;
                                  _dateString = DateFormat.MMMMd()
                                      .format(_date)
                                      .toString();
                                });
                              },
                              minTime: DateTime.now(),
                              maxTime: DateTime.now().add(Duration(days: 14)),
                            );
                          },
                          child: Text(
                            _dateString ??
                                DateFormat.MMMMd()
                                    .format(DateTime.now())
                                    .toString(),
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 18),
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
                              },
                              showSecondsColumn: false,
                            );
                          },
                          child: Text(
                            _timeString ??
                                DateFormat.jm()
                                    .format(DateTime.now())
                                    .toString(),
                            style: TextStyle(color: Colors.amber, fontSize: 60),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Column(
                            children: [
                              buildRemarksField(onChangedRemarks,
                                  initialValue: this._remarks),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: buildPasswordField(onChangePassword,
                                    initialValue: this._password),
                              ),
                              buildPasswordRules(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
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
                                  Storage.updateAlarm(widget.documentId, {
                                    'remarks': _remarks,
                                    'date': _date ?? DateTime.now(),
                                    'time': _time ?? DateTime.now(),
                                    'password': _password,
                                    'notificationId': notificationId,
                                  });
                                  callback(widget.documentId, notificationId);
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(
                                'Update',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            buildCancelButton(context),
                          ],
                        ),
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
