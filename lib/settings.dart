import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

// TODO: add update phone number
class SettingsPage extends StatelessWidget {
  _launchURL() async {
    const url = "https://github.com/Clouddoggo/AnnoyingAlarm/pulls";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
                title: Text("Manage sounds"),
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
                title: Text("Logout"),
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
