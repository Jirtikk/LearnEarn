// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../tools/col.dart';
import '../../tools/applayout.dart';
import '../../tools/appstate.dart';
import '../../uihelpers/stuorjobhelper.dart';
import 'detail.dart';

class stuorjob extends StatelessWidget {
  stuorjob({Key? key, required this.phone, required this.pass})
      : super(key: key);
  String phone, pass;

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Select a Category',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: AppLayout.getwidth(context) * 0.1),
              ),
              Row(
                children: [
                  stuorhier(
                    text2: 'Student',
                  ),
                  stuorhier(
                    text2: 'Company',
                  ),
                ],
              ),
              stuorhier(
                text2: 'Instructor',
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {
                      if (provider.cat != '') {
                        // provider.database
                        //     .child('user')
                        //     .child(phone)
                        //     .child('useras')
                        //     .set(provider.cat);
                        provider.prefs.setString('useras', provider.cat);
                        provider.cat = '';
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: detail(
                                  phone: phone,
                                  pass: pass,
                                ),
                                type: PageTransitionType.fade));
                      } else {
                        AppLayout.showsnakbar(
                            context, 'Please Select a Category');
                      }
                    },
                    child: Container(
                      height: 50,
                      width: AppLayout.getwidth(context) * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: col.pruple),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Next',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                color: col.wh,
                                fontSize: AppLayout.getwidth(context) * 0.05),
                          ),
                        ),
                      ),
                    ),
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
