import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// TODO: add update phone number
class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.purple[200], Colors.blue[200]],
        ),
      ),
      child: Center(
        child: SafeArea(
          child: ListView(padding: const EdgeInsets.all(8.0), children: [
            Container(
              child: Text("phone number"),
            ),
          ]),
        ),
      ),
    );
  }
}
