import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm/storage.dart';
import 'package:intl/intl.dart';
import 'package:vibration/vibration.dart';

class AlarmRingPage extends StatefulWidget {
  AlarmRingPage({Key key, this.payload}) : super(key: key);

  final String payload;

  @override
  _AlarmRingPageState createState() => _AlarmRingPageState();
}

// TODO: detect home & lock button
class _AlarmRingPageState extends State<AlarmRingPage> {
  final _formKey = GlobalKey<FormState>();
  final player = AudioCache();
  AudioPlayer advancedPlayer;
  String _remarks, _password, _dateString, _timeString;

  void initialiseDetails() async {
    await Storage.getAlarmDetails(widget.payload).then((document) {
      setState(() {
        this._remarks = document.get('remarks');
        this._password = document.get('password');
        this._dateString =
            DateFormat.MMMMd().format(document.get('date').toDate()).toString();
        this._timeString =
            DateFormat.jm().format(document.get('time').toDate()).toString();
      });
    });
    startAudioAndVibrate();
  }

  void startAudioAndVibrate() async {
    await Vibration.vibrate(duration: 10000);
    await player.load('sound1.wav');
    advancedPlayer = await player.loop('sound1.wav');
  }

  void stopAudioAndVibration() async {
    await Vibration.cancel();
    await advancedPlayer?.stop();
    player.clearCache();
  }

  @override
  void initState() {
    super.initState();
    initialiseDetails();
  }

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text('Are you attempting to leave the alarm hanging?'),
            content: new Text(
                'Please enter the password correctly before you leave'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('OK'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        backgroundColor: Color(0xffddd3ee),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " $_dateString ",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    " $_timeString ",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    " $_remarks ",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password: $_password",
                      style: TextStyle(
                          color: Colors.red[800], fontWeight: FontWeight.bold),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      enableInteractiveSelection: false,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontSize: 13,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          isDense: true,
                          hintText: "Enter the case-sensitive password"),
                      validator: (value) {
                        if (value.isEmpty || value.trim().length < 1) {
                          return "Password cannot be empty";
                        } else if (value != _password) {
                          return "Password entered does not match.";
                        }
                        stopAudioAndVibration();
                        return null;
                      },
                    ),
                  ),
                  RaisedButton(
                    color: Color.fromRGBO(92, 184, 92, 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.popAndPushNamed(context, '/');
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
