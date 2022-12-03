import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';

class DialogUtils {
  DialogUtils._();
  static void showInSnackBar(
      {String? msg, required BuildContext context, Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Text(
          msg!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 7,
          horizontal: 12,
        ),
        backgroundColor: messageColor,
        elevation: 8,
      ),
    );
  }

  static showToast({
    String? msg,
    double? fontSize,
    Color? color,
    Color? backgroundColor,
    ToastGravity? gravity,
  }) {
    Fluttertoast.showToast(
      msg: msg!,
      fontSize: fontSize,
      textColor: color ?? Colors.white,
      backgroundColor: backgroundColor ?? messageColor,
      gravity: gravity,
    );
  }
}
