import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/screen/adminscreen/adminclasses.dart';
import 'package:learn_and_earn_mongodb/screen/adminscreen/adminjobs.dart';
import 'package:learn_and_earn_mongodb/screen/adminscreen/adminuser.dart';
import 'package:learn_and_earn_mongodb/tools/applayout.dart';
import 'package:page_transition/page_transition.dart';

import '../account/login.dart';
import 'admincourse.dart';

class admin extends StatelessWidget {
  const admin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to Admin",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            Text(
              "Here you can manage everything",
              style: GoogleFonts.poppins(fontSize: 12),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: const Login(), type: PageTransitionType.fade),
                  (Route<dynamic> route) => false);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
                child: Column(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const admincourse()));
                    },
                    child: btn(context, "Courses", "Manage courses",
                        "assets/courses.jpg")),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const adminjobs()));
                    },
                    child:
                        btn(context, "Jobs", "Manage Jobs", "assets/job0.jpg"))
              ],
            )),
            Expanded(
                child: Column(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const adminclasses()));
                    },
                    child: btn(context, "Classes", "Manage classes",
                        "assets/class.jpg")),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const adminuser()));
                    },
                    child: btn(
                        context, "Users", "Manage users", "assets/users.jpg"))
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget btn(BuildContext context, String title, String des, String img) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(img),
          Text(
            title,
            style: GoogleFonts.b612Mono(
                fontWeight: FontWeight.bold,
                fontSize: AppLayout.getwidth(context) * 0.05),
          ),
          Text(
            des,
            style: GoogleFonts.b612Mono(
                fontSize: AppLayout.getwidth(context) * 0.03),
          ),
        ],
      ),
    );
  }
}
