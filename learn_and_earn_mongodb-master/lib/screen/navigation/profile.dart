// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/screen/navigation/profile/certificateview.dart';
import 'package:learn_and_earn_mongodb/screen/navigation/profile/faq.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../tools/col.dart';
import '../../tools/applayout.dart';
import '../../tools/appstate.dart';
import '../account/login.dart';
import 'jobscreen/helper/abouduser.dart';

class profile extends StatelessWidget {
  const profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: abouduser(num: provider.prefs.getString('phone')),
              ),
              Container(
                  padding: const EdgeInsets.all(15),
                  child: accountinfo(
                    title: "Phone : ",
                    name: provider.prefs.getString("phone"),
                    icon: Icons.call,
                  )),
              Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 5),
                  child: accountinfo(
                    title: "Type : ",
                    name: provider.prefs.getString("useras"),
                    icon: Icons.person,
                  )),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        child: const certificateview(),
                        type: PageTransitionType.fade),
                  );
                },
                child: Container(
                  width: AppLayout.getwidth(context),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.1)),
                  child: Row(
                    children: [
                      const Icon(Icons.casino_outlined),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'Certificate',
                          style: GoogleFonts.roboto(
                              fontSize: AppLayout.getwidth(context) * 0.04),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const faq(), type: PageTransitionType.fade));
                },
                child: Container(
                  width: AppLayout.getwidth(context),
                  margin:
                  const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.1)),
                  child: Row(
                    children: [
                      const Icon(Icons.question_answer),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'FAQs',
                          style: GoogleFonts.roboto(
                              fontSize: AppLayout.getwidth(context) * 0.04),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  provider.prefs.remove('phone');
                  provider.prefs.remove('img');
                  provider.prefs.remove('education');
                  provider.prefs.remove('name');
                  provider.prefs.remove('useras');
                  provider.prefs.remove('auth');
                  provider.phone = '';
                  provider.pass = '';

                  Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                          child: const Login(), type: PageTransitionType.fade),
                          (Route<dynamic> route) => false);
                },
                child: Container(
                  width: AppLayout.getwidth(context),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.1)),
                  child: Row(
                    children: [
                      const Icon(Icons.logout),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'Logout',
                          style: GoogleFonts.roboto(
                              fontSize: AppLayout.getwidth(context) * 0.04),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class accountinfo extends StatelessWidget {
  accountinfo(
      {Key? key, required this.title, required this.name, required this.icon})
      : super(key: key);
  String title, name;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(icon),
          ),
          Text(
            title,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: AppLayout.getwidth(context) * 0.04),
          ),
          Expanded(
            child: Text(
              name,
              style: GoogleFonts.roboto(
                  fontSize: AppLayout.getwidth(context) * 0.04),
            ),
          ),
        ],
      ),
    );
  }
}