import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm/storage.dart';
import 'package:intl/intl.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';

class AlarmRingPage extends StatefulWidget {
  AlarmRingPage({Key key, this.payload}) : super(key: key);

  final String payload;

  @override
  _AlarmRingPageState createState() => _AlarmRingPageState();
}

// TODO: test vibration and audio player. detect home & lock button
class _AlarmRingPageState extends State<AlarmRingPage> {
  final _formKey = GlobalKey<FormState>();
  AudioPlayer audioPlayer = AudioPlayer();
  String _name, _remarks, _password, _date, _time;

  void initialiseDetails() async {
    await Storage.getAlarmDetails(widget.payload).then((document) {
      setState(() {
        this._name = document.get('name');
        this._remarks = document.get('remarks');
        this._password = document.get('password');
        this._date =
            DateFormat.MMMMd().format(document.get('date').toDate()).toString();
        this._time =
            DateFormat.jm().format(document.get('time').toDate()).toString();
      });
    });

    await audioPlayer.play('https://www.youtube.com/watch?v=jIL2BcXWVSg');
    Vibration.vibrate(pattern: [500, 1500]);
  }

  @override
  void initState() {
    super.initState();
    initialiseDetails();
  }

  void stopAudioAndVibration() async {
    Vibration.cancel();
    await audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
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
                    " $_date ",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    " $_time ",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      " $_name ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
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
