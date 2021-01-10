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

TextFormField buildPasswordField(Function onChangedPassword) {
  return TextFormField(
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
        return "Password requires more than 9 characters";
      }
      return null;
    },
    onChanged: onChangedPassword,
  );
}

TextFormField buildRemarksField(Function onChangedRemarks) {
  return TextFormField(
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

TextFormField buildNameField(Function onChangedName) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: 'Name',
      labelStyle: TextStyle(
        fontSize: 13,
      ),
      enabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      isDense: true,
    ),
    validator: (value) {
      if (value.isEmpty || value.trim().length < 1) {
        return 'Please enter some text';
      }
      return null;
    },
    onChanged: onChangedName,
  );
}
