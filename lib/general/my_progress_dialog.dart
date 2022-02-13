import 'package:flutter/material.dart';

showLoaderDialog(BuildContext context, String msg) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.black,
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
          margin: const EdgeInsets.only(left: 7),
          child: Text(
            msg,
            style: const TextStyle(color: Colors.white),
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
