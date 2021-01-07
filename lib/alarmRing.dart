import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlarmRingPage extends StatefulWidget {
  @override
  _AlarmRingPageState createState() => _AlarmRingPageState();
}

class _AlarmRingPageState extends State<AlarmRingPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffddd3ee),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "time",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "alarm name",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  "alarm remarks",
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
                    "Password: password",
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
                      } else if (value != "password") {
                        return "Password entered does not match.";
                      }
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
    );
  }
}
