// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:learn_and_earn_mongodb/screen/compnays/company.dart';
import 'package:learn_and_earn_mongodb/screen/instructor/instructorhome.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/account/login.dart';
import '../screen/homepage.dart';
import 'applayout.dart';

class AppState extends ChangeNotifier {
  Future<void> change_screen(BuildContext context, AppState provider) async {
    Future.delayed(const Duration(seconds: 3), () {
      try {
        if (prefs.containsKey('auth')) {
          if(prefs.getString('useras') == "Company") {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: const company(), type: PageTransitionType.fade));
          } else if (prefs.getString('useras') == "Instructor") {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: const instructorhome(), type: PageTransitionType.fade));
          } else {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: const Homepage(), type: PageTransitionType.fade));
          }
        } else {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: const Login(), type: PageTransitionType.fade));
        }
      } catch (e) {
        AppLayout.showsnakbar(context, e.toString());
      }
    });
  }

  var prefs;
  Future<void> sharepref() async {
    prefs = await SharedPreferences.getInstance();
  }

  final FancyPasswordController passwordController = FancyPasswordController();

  String cat = '';
  File? image;

  // sing up
  String name = '', phone = '', pass = '', confirm = '', otp = '';
  bool resetvisi = false;

  // details
  String edu = '';

  TextEditingController? textEditingController = TextEditingController();

  // database
  DatabaseReference database = FirebaseDatabase.instance.ref();
  final storage = FirebaseStorage.instance.ref();

  // chat
  bool chatbottom = false;

  void saveImage(image) {
    this.image = image;
    notifyListeners();
  }
}
