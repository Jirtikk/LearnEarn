import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/tools/top.dart';
import 'package:page_transition/page_transition.dart';

import '../../monoogshelper/mongoos.dart';
import '../../tools/applayout.dart';
import '../navigation/courses.dart';
import '../navigation/coursesscreen/coursedata.dart';

class admincourse extends StatefulWidget {
  const admincourse({super.key});

  @override
  State<admincourse> createState() => _admincourseState();
}

class _admincourseState extends State<admincourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            top(title: "course management"),
            Expanded(
              child: FutureBuilder(
                  future: ApiHelper.course(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        children: snapshot.data.map<Widget>((e) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: coursedata(
                                        dataa: e,
                                        indexx: 1,
                                      ),
                                      type: PageTransitionType.fade));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Hero(
                                    tag: "data${1}",
                                    child: maincoursedata(data: e),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Delete",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
                                          onTap: () async {
                                            bool c =
                                                await ApiHelper.deletecourse(
                                                    e['_id'], context);
                                            if (c) {
                                              AppLayout.showsnakbar(context,
                                                  "Deleted Sucessfully");
                                              Navigator.pop(context);
                                            } else {
                                              AppLayout.showsnakbar(
                                                  context, "Try again later");
                                            }
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else if (snapshot.hasError) {
                      return const Icon(Icons.error_outline);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
