// ignore_for_file: camel_case_types

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/screen/navigation/jobscreen/screens/videocall.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../monoogshelper/mongoos.dart';
import '../../../../tools/applayout.dart';
import '../../../../tools/appstate.dart';
import '../../../../tools/col.dart';
import '../../../../tools/top.dart';
import '../../jobs.dart';

class appliedjob extends StatelessWidget {
  const appliedjob({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Column(
          children: [
            top(title: "Applications"),
            Expanded(
              child: FutureBuilder(
                future: ApiHelper.getalljobapplied(context),
                builder:
                    (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.toString() == '[]') {
                      return Center(
                          child: Text(
                            "No Data",
                            style: GoogleFonts.poppins(),
                          ));
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder:
                              (BuildContext context, int index) {
                            if (snapshot.data[index]['addedby'] ==
                                provider.prefs.getString('phone')) {
                              if(snapshot.data[index]['status'] == 'new') {
                                return jobcontainer(
                                    data: snapshot.data[index],
                                    inter: false);
                              } else {
                                return hire(data: snapshot.data[index]);
                              }
                            } else {
                              return const SizedBox.shrink();
                            }
                          });
                    }
                  } else if (snapshot.hasError) {
                    return const Icon(
                      Icons.error,
                    );
                  } else {
                    return AppLayout.displaysimpleprogress(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class hire extends StatelessWidget {
  hire({super.key, required this.data});
  Map data;

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    return InkWell(
      onTap: () {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: CallPage(
                    callID: data['addedby'] + data['appliedby'],
                    userid: provider.prefs.getString('phone'),
                    username: provider.prefs.getString('phone'),
                  ),
                  type: PageTransitionType.fade));
      },
      child: Container(
          width: AppLayout.getwidth(context),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.lightGreen.withOpacity(0.1),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                child: Icon(
                  Icons.done,
                  color: col.wh,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "take interview",
                      style: GoogleFonts.poppins(
                        fontSize: AppLayout.getwidth(context) * 0.04,
                        fontWeight: FontWeight.bold,
                        textStyle: const TextStyle(
                            color: Colors.blue,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    Text(
                      data['date'] + " " + data['time'].toString(),
                      style: GoogleFonts.poppins(
                          fontSize: AppLayout.getwidth(context) * 0.03),
                    ),
                    // Text(
                    //   data['test'] == "no" ? "Not Give Test" : "Give Test",
                    //   style: GoogleFonts.poppins(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: AppLayout.getwidth(context) * 0.03),
                    // ),
                    // Text(
                    //   "Test Result : " + data['result'],
                    //   style: GoogleFonts.poppins(
                    //       fontSize: AppLayout.getwidth(context) * 0.03),
                    // ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
