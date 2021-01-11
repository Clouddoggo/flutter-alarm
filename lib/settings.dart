import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  _launchURL() async {
    const url = "https://github.com/Clouddoggo/flutter-alarm/issues";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F8FF),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: ListView(padding: const EdgeInsets.all(0.0), children: [
              Padding(
                padding: EdgeInsets.only(top: 40, left: 20, bottom: 12),
                child: Text(
                  "Settings",
                  style: TextStyle(fontSize: 26),
                ),
              ),
              ListTile(
                title: Text("Coming soon: Change number"),
                leading: Icon(
                  Icons.phone,
                  size: 18,
                  color: Color(0xff0785CC),
                ),
                onTap: () {
                  print("tapped");
                },
              ),
              ListTile(
                title: Text("Coming soon: Manage sounds"),
                leading: Icon(
                  Icons.hearing,
                  size: 18,
                  color: Color(0xff872EF9),
                ),
                onTap: () {
                  print("tapped");
                },
              ),
              ListTile(
                title: Text("Contribute"),
                leading: Icon(
                  Icons.favorite_border,
                  size: 18,
                  color: Color(0xffFA1FCA),
                ),
                onTap: _launchURL,
              ),
              ListTile(
                title: Text("Coming soon: Logout"),
                leading: Icon(
                  Icons.phone,
                  size: 18,
                  color: Color(0xffEB2B2B),
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
