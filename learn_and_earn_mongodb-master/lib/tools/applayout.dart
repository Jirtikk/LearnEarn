import 'package:flutter/material.dart';
import '../tools/col.dart';

class AppLayout {
  static getwidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static getheight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showsnakbar(
      BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(fontFamily: 'paul'),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static Widget displaysimpleprogress(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 6.0,
        valueColor: AlwaysStoppedAnimation<Color>(col.pruple),
      ),
    );
  }

  static void displayprogress(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 6.0,
              valueColor: AlwaysStoppedAnimation<Color>(col.pruple),
            ),
          ),
        );
      },
    );
  }

  static void hideprogress(BuildContext context) {
    Navigator.pop(context);
  }

  static RegExp getRegExpint() {
    return RegExp('[0-9]');
  }

  static RegExp getRegExpstring() {
    return RegExp('[a-zA-Z ]');
  }
}
