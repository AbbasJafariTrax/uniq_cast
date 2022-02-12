import 'package:flutter/material.dart';

showLoaderDialog(BuildContext context, String msg) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.black,
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(
          margin: EdgeInsets.only(left: 7),
          child: Text(
            msg,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
