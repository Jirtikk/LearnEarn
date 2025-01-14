// ignore_for_file: use_build_context_synchronously, must_be_immutable, camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/screen/account/stuorjob.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../tools/applayout.dart';
import '../../tools/col.dart';
import '../../tools/appstate.dart';
import 'login.dart';

class otp extends StatelessWidget {
  otp(
      {Key? key,
      required this.id,
      required this.phone,
      required this.name,
      required this.pass})
      : super(key: key);
  String id, phone, name, pass;

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);
    final FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Phone Verification',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: AppLayout.getwidth(context) * 0.1),
              ),
              Pinput(
                length: 6,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onChanged: (value) {
                  provider.otp = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: InkWell(
                  onTap: () async {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: id, smsCode: provider.otp);
                    var check = await auth.signInWithCredential(credential);
                    if (check.additionalUserInfo!.isNewUser) {
                      provider.prefs.setString('phone', phone);
                      provider.prefs.setString('name', name);

                      provider.database.child('user').child(phone).set({
                        "pass": pass,
                        "name": name,
                      });

                      provider.cat = '';
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: stuorjob(
                                phone: phone,
                                pass: pass,
                              ),
                              type: PageTransitionType.fade));
                    } else {
                      AppLayout.showsnakbar(context, "Already register");
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: const Login(),
                              type: PageTransitionType.fade));
                    }
                  },
                  child: Container(
                    height: 50,
                    width: AppLayout.getwidth(context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: col.pruple),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Verify',
                          style: GoogleFonts.roboto(
                              color: col.wh,
                              fontSize: AppLayout.getwidth(context) * 0.05),
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
