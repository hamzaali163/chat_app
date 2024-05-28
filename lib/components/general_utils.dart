import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';

import 'package:flutter/material.dart';

class GeneralUtils with ChangeNotifier {
  bool load = false;
  void showerrormessage(String msg, context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        //title: "Hey Ninja",
        titleColor: Colors.white,
        message: msg,
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.FLOATING,
        reverseAnimationCurve: Curves.decelerate,
        forwardAnimationCurve: Curves.elasticOut,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  void successfulmessage(String success, context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        titleColor: Colors.white,
        message: success,
        flushbarPosition: FlushbarPosition.BOTTOM,
        flushbarStyle: FlushbarStyle.FLOATING,
        reverseAnimationCurve: Curves.decelerate,
        forwardAnimationCurve: Curves.elasticOut,
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 4),
        icon: const Icon(
          Icons.info,
          color: Colors.white,
        ),
      )..show(context),
    );
    loading(bool val) {
      val = load;
    }
  }

  static focusnodechange(
      FocusNode current, FocusNode next, BuildContext context) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  progressindic(bool value) {
    load = value;
    notifyListeners();
  }
}
