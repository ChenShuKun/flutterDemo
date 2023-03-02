import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Tips {
  static void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      // // ..progressColor = Colors.yellow
      // // ..backgroundColor = Colors.green
      // // ..indicatorColor = Colors.yellow
      // ..textColor = Colors.yellow
      // ..maskColor = Colors.blue.withOpacity(0.5)
      ..contentPadding = const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20.0,
      )
      ..textPadding = const EdgeInsets.only(left: 10.0, right: 10)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  static TransitionBuilder easyLoadingInit() {
    return EasyLoading.init();
  }

  static showToast(String msg) {
    if (msg.isNotEmpty) {
      EasyLoading.showToast(msg);
    }
  }

  static showSuccess(String msg) {
    if (msg.isNotEmpty) {
      EasyLoading.showSuccess(msg);
    }
  }

  static showError(String msg) {
    if (msg.isNotEmpty) {
      EasyLoading.showError(msg);
    }
  }

  static showInfo(String msg) {
    if (msg.isNotEmpty) {
      EasyLoading.showInfo(msg);
    }
  }
}
