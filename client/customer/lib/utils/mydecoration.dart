import 'package:customer/utils/mycolor.dart';
import 'package:flutter/material.dart';

class MyDecoration {
  static InputBorder inputBorder =
      OutlineInputBorder(borderRadius: BorderRadius.circular(15.0));
  static BoxDecoration cardDecoration = BoxDecoration(
      boxShadow: MyColor.shadow1,
      color: Colors.white,
      borderRadius: BorderRadius.circular(10));
}
