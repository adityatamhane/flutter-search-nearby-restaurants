import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ReusableWidgets {
  //loader
  static Widget centerCircularLoader() {
    return Center(
      child: Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff0481de)))),
    );
  }

  //Normal Snackbar
  static void normalSnackBar(messageTitle, messageText) {
    return Get.snackbar(
      messageTitle,
      messageText,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Color(0xFF6b6d63),
      backgroundColor: Color(0xff0481de),
    );
  }
}
