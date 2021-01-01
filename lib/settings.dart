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
      color: Color(0xffF1F8FF),
      child: Center(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: ListView(padding: const EdgeInsets.all(0.0), children: [
              Padding(
                padding: EdgeInsets.only(top: 30, left: 20, bottom: 10),
                child: Text(
                  "Settings",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ListTile(
                title: Text("Change number"),
                leading: IconButton(
                  icon: Icon(
                    Icons.phone,
                    size: 18,
                    color: Color(0xff0785CC),
                  ),
                  highlightColor: Colors.redAccent,
                  onPressed: () {
                    print("change");
                  },
                ),
                onTap: () {
                  print("tapped");
                },
              ),
              ListTile(
                title: Text("Manage sounds"),
                leading: IconButton(
                  icon: Icon(
                    Icons.hearing,
                    size: 18,
                    color: Color(0xff872EF9),
                  ),
                  highlightColor: Colors.redAccent,
                  onPressed: () {
                    print("change");
                  },
                ),
                onTap: () {
                  print("tapped");
                },
              ),
              ListTile(
                title: Text("Contribute"),
                leading: IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    size: 18,
                    color: Color(0xffFA1FCA),
                  ),
                  highlightColor: Colors.redAccent,
                  onPressed: () {
                    print("change");
                  },
                ),
                onTap: () {
                  print("Contribute");
                },
              ),
              ListTile(
                title: Text("Logout"),
                leading: IconButton(
                  icon: Icon(
                    Icons.phone,
                    size: 18,
                    color: Color(0xffEB2B2B),
                  ),
                  highlightColor: Colors.redAccent,
                  onPressed: () {
                    print("change");
                  },
                ),
                onTap: () {
                  print("Logout");
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
