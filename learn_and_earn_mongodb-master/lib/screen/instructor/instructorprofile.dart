import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/tools/col.dart';
import 'package:learn_and_earn_mongodb/tools/top.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../tools/applayout.dart';
import '../../tools/appstate.dart';
import '../account/login.dart';
import '../navigation/profile.dart';

class instructorprofile extends StatefulWidget {
  const instructorprofile({super.key});

  @override
  State<instructorprofile> createState() => _instructorprofileState();
}

class _instructorprofileState extends State<instructorprofile> {
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            top(title: "Your Profile"),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Yours Details",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: AppLayout.getwidth(context) * 0.05),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
              ),
              child: Column(
                children: [
                  accountinfo(
                    title: "Name",
                    name: provider.prefs.getString("name"),
                    icon: Icons.person,
                  ),
                  accountinfo(
                    title: "Bio",
                    name: provider.prefs.getString("edu"),
                    icon: Icons.person,
                  ),
                  accountinfo(
                    title: "Phone Number",
                    name: provider.prefs.getString("phone"),
                    icon: Icons.call,
                  ),
                  accountinfo(
                    title: "Account Type",
                    name: provider.prefs.getString("useras"),
                    icon: Icons.person,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
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
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(right: 20, left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: col.pruple,
                  border: Border.all(width: 1, color: Colors.grey.shade400),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    Text(
                      "Logout",
                      style: GoogleFonts.b612Mono(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget accountinfo(
      {required String title, required String name, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(icon),
              ),
              Text(
                title,
                style: GoogleFonts.b612Mono(
                    fontWeight: FontWeight.bold,
                    fontSize: AppLayout.getwidth(context) * 0.04),
              ),
            ],
          ),
          Text(
            name,
            style: GoogleFonts.b612Mono(
                fontSize: AppLayout.getwidth(context) * 0.04),
          ),
        ],
      ),
    );
  }
}
