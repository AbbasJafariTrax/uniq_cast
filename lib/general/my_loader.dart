import 'package:flutter/material.dart';

Column myLoader(Size deviceSize) {
  return Column(
    children: [
      SizedBox(height: deviceSize.height * 0.1),
      const Center(child: CircularProgressIndicator()),
    ],
  );
}
