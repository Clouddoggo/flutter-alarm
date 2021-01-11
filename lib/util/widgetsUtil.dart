import 'package:flutter/material.dart';

RaisedButton buildCancelButton(BuildContext context) {
  return RaisedButton(
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
  );
}

TextFormField buildPasswordField(Function onChangedPassword,
    {String initialValue}) {
  return TextFormField(
    initialValue: initialValue,
    decoration: InputDecoration(
      labelText: 'Password',
      labelStyle: TextStyle(
        fontSize: 13,
      ),
      enabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      isDense: true,
    ),
    validator: (value) {
      if (value.isEmpty || value.trim().length < 1) {
        return 'Password cannot be empty';
      } else if (value.trim().length < 10) {
        return "Password must have more than 11 characters";
      } else if (!value.contains(new RegExp(r'[A-Z]'))) {
        return 'Password must contain at least 1 uppercase letter';
      } else if (!value.contains(new RegExp(r'[a-z]'))) {
        return 'Password must contain at least 1 lowercase letter';
      } else if (!value.contains(new RegExp(r'[0-9]'))) {
        return 'Password must contain at least 1 digit';
      } else if (!value.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        return 'Password must contain at least 1 of: !@#\$%^&*(),.?:{}|<>';
      }
      return null;
    },
    onChanged: onChangedPassword,
  );
}

TextFormField buildRemarksField(Function onChangedRemarks,
    {String initialValue}) {
  return TextFormField(
    initialValue: initialValue,
    decoration: InputDecoration(
      labelText: 'Remarks',
      labelStyle: TextStyle(
        fontSize: 13,
      ),
      enabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      isDense: true,
    ),
    onChanged: onChangedRemarks,
  );
}

Align buildPasswordRules() {
  return Align(
    alignment: Alignment.centerLeft,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "Password must have all of the following:",
            style: TextStyle(fontSize: 12.0, color: Colors.blueGrey[700]),
          ),
        ),
        Text(
          "At least 1 uppercase letter\nAt least 1 lowercase letter\nAt least 1 character from !@#\$%^&*(),.?:{}|<>\nMore than 11 characters",
          style: TextStyle(fontSize: 11.0, color: Colors.grey[600]),
        ),
      ],
    ),
  );
}
