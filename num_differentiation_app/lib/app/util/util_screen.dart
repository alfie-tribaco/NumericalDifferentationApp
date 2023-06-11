import 'package:flutter/material.dart';

class UtilScreen {
  double getHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  double getWidth(context) {
    return MediaQuery.of(context).size.width;
  }
}
