// ignore_for_file: must_be_immutable, camel_case_types, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/monoogshelper/mongoos.dart';
import 'package:learn_and_earn_mongodb/screen/navigation/jobscreen/screens/updatejob.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../tools/applayout.dart';
import '../../tools/appstate.dart';
import '../../tools/col.dart';
import 'jobscreen/screens/applyjob.dart';
import 'jobscreen/screens/interview.dart';

class jobs extends StatefulWidget {
  const jobs({Key? key}) : super(key: key);

  @override
  State<jobs> createState() => _jobsState();
}

class _jobsState extends State<jobs> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.withOpacity(0.2),
              ),
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search,
                  ),
                  Flexible(
                    child: TextField(
                      style: GoogleFonts.roboto(
                          fontSize: AppLayout.getwidth(context) * 0.04,
                          fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        provider.notifyListeners();
                      },
                      controller: textEditingController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Search"),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        textEditingController!.clear();
                        provider.notifyListeners();
                      },
                      child: const Icon(
                        Icons.clear,
                      )),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Recommended Jobs",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                  SizedBox(
                    width: AppLayout.getwidth(context),
                    height: 120,
                    child: FutureBuilder(
                      future: getre(provider),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.toString() == "[]") {
                            return Column(
                              children: [
                                Text(
                                  "No Recommended Jobs",
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Complete courses for job recommendation",
                                  style: GoogleFonts.roboto(fontSize: 14),
                                ),
                              ],
                            );
                          } else {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    if (provider.prefs.getString('useras') !=
                                        'Job Provider') {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: applyjob(
                                                  data: snapshot.data[index]),
                                              type: PageTransitionType.fade));
                                    } else {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: updatejob(
                                                  data: snapshot.data[index]),
                                              type: PageTransitionType.fade));
                                    }
                                  },
                                  child: Container(
                                    width: 200,
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.amber.shade100,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data[index]['title']
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              fontSize:
                                                  AppLayout.getwidth(context) *
                                                      0.04,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          snapshot.data[index]['companyname']
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              fontSize:
                                                  AppLayout.getwidth(context) *
                                                      0.04),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Icon(Icons.paid),
                                            Text(
                                                snapshot.data[index]['salary']
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize:
                                                        AppLayout.getwidth(
                                                                context) *
                                                            0.03)),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              color: col.pruple,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        } else if (snapshot.hasError) {
                          return const Icon(
                            Icons.error,
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "All Jobs",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                  FutureBuilder(
                    future: ApiHelper.getalljob(context),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.toString() == '[]') {
                          return Center(
                            child: Text(
                              "No Data",
                              style: GoogleFonts.poppins(),
                            ),
                          );
                        } else {
                          return Column(
                            children: snapshot.data.map<Widget>((e) {
                              if (provider.prefs.getString('useras') ==
                                  'Company') {
                                if (provider.prefs.getString('phone') ==
                                    e['addedby']) {
                                  return listdata(e);
                                } else {
                                  return const SizedBox.shrink();
                                }
                              } else {
                                return listdata(e);
                              }
                            }).toList(),
                          );
                        }
                      } else if (snapshot.hasError) {
                        return const Icon(
                          Icons.error,
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listdata(Map snapshot) {
    if (textEditingController!.text.isEmpty) {
      return jobcontainer(data: snapshot, inter: true);
    } else {
      if (snapshot['title']
          .toLowerCase()
          .contains(textEditingController!.text.toLowerCase())) {
        return jobcontainer(data: snapshot, inter: true);
      } else {
        return const SizedBox.shrink();
      }
    }
  }

  Future<List> getre(AppState provider) async {
    List ff = [];
    List data =
        await ApiHelper.getstartedbynum(provider.prefs.getString('phone'));
    List dataj = await ApiHelper.getalljob(context);
    data.forEach((element) async {
      Map cd = await ApiHelper.getcoursebyid(element['courseid']);
      dataj.forEach((element2) {
        if (element2['title']
            .toString()
            .toLowerCase()
            .contains(cd['title'].toString().toLowerCase())) {
          ff.add(element2);
        }
      });
    });
    return ff;
  }
}

class jobcontainer extends StatelessWidget {
  jobcontainer({Key? key, required this.data, required this.inter})
      : super(key: key);
  Map data;
  bool inter;

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    return InkWell(
      onTap: () {
        if (inter) {
          if (provider.prefs.getString('useras') != 'Job Provider') {
            Navigator.push(
                context,
                PageTransition(
                    child: applyjob(data: data),
                    type: PageTransitionType.fade));
          } else {
            Navigator.push(
                context,
                PageTransition(
                    child: updatejob(data: data),
                    type: PageTransitionType.fade));
          }
        } else {
          Navigator.push(
              context,
              PageTransition(
                  child: interview(data: data), type: PageTransitionType.fade));
        }
      },
      child: Container(
          width: AppLayout.getwidth(context),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: inter
                ? Colors.grey.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                child: Icon(
                  CupertinoIcons.app,
                  color: col.wh,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title'].toString(),
                      style: GoogleFonts.poppins(
                          fontSize: AppLayout.getwidth(context) * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      data['companyname'].toString(),
                      style: GoogleFonts.poppins(
                          fontSize: AppLayout.getwidth(context) * 0.04),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.paid),
                  Text(data['salary'].toString(),
                      style: GoogleFonts.poppins(
                          fontSize: AppLayout.getwidth(context) * 0.03))
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: col.pruple,
              )
            ],
          )),
    );
  }
}
