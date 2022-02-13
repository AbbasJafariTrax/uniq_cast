import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void myToastMsg(String msg, Color bgColor, Color textColor) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: bgColor,
    textColor: textColor,
    fontSize: 16.0,
  );
}
