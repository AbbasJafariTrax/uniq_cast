import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Base {
  Container getTextField(
    TextEditingController txtCtrl, {
    String label = "",
    String hint = "",
    bool editing = false,
    double minWidth = 0.0,
    double maxWidth = double.infinity,
    double minHeight = 0.0,
    double maxHeight = double.infinity,
    bool readOnly = false,
    TextInputType textInputType = TextInputType.text,
    bool isNum = false,
        bool isObscure = false,
    bool alignLabelWithHint = false,
    int maxLine = 1,
    Color fillColor = Colors.transparent,
  }) {
    InputDecoration tmpInputDeco = InputDecoration(
      hintText: hint,
      labelText: label,
      fillColor: fillColor,
      filled: true,
      alignLabelWithHint: alignLabelWithHint,
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.7),
      ),
    );

    return Container(
      constraints: BoxConstraints(
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        maxHeight: maxHeight,
      ),
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: txtCtrl,
        style: TextStyle(color: Colors.white),
        validator: (str) {
          if (txtCtrl.text.isEmpty) {
            return "Please enter your $label";
          }
          return null;
        },
        maxLines: maxLine,
        keyboardType: textInputType,
        obscureText: isObscure,
        inputFormatters: isNum
            ? [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))]
            : [],
        enabled: !readOnly,
        readOnly: readOnly,
        decoration: tmpInputDeco,
      ),
    );
  }

  ElevatedButton myElevatedButton(
    String text, {
    required VoidCallback clickListener,
    required Color text_color,
    required Color button_color,
  }) {
    return ElevatedButton(
      child: Text(text, style: TextStyle(color: text_color)),
      onPressed: clickListener,
      style: ElevatedButton.styleFrom(
        primary: button_color,
      ),
    );
  }
}
