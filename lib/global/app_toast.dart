import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

mixin AppToast {
  static Future<void> showToast(String message) async {
    await Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 74, 73, 73),
      fontSize: 16,
      textColor: Colors.white,
    );
  }
}
