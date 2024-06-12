import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/screen/navigation/classes/instructorplaylist.dart';
import 'package:learn_and_earn_mongodb/tools/top.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../monoogshelper/mongoos.dart';
import '../../../tools/applayout.dart';
import '../../../tools/appstate.dart';
import '../courses.dart';
import '../jobscreen/screens/videocall.dart';

class instructor extends StatefulWidget {
  instructor({super.key, required this.data});
  Map data;

  @override
  State<instructor> createState() => _instructorState();
}

class _instructorState extends State<instructor> {
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            top(title: "Instructor ${widget.data['name']}"),
            Expanded(
              child: DefaultTabController(
                  length: 2,
                  child: Column(children: [
                    TabBar(
                      tabs: [
                        Tab(
                          child: Text(
                            'Courses',
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Classes',
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          FutureBuilder(
                              future: ApiHelper.course(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (snapshot.data[index]['ins'] ==
                                          widget.data['number']) {
                                        if (snapshot.data[index]['type'] ==
                                            'Instructor') {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      child: instructorplaylist(
                                                        dataa: snapshot
                                                            .data[index],
                                                        indexx: 1,
                                                      ),
                                                      type: PageTransitionType
                                                          .fade));
                                            },
                                            child: Hero(
                                              tag: "data${1}",
                                              child: maincoursedata(
                                                  data: snapshot.data[index]),
                                            ),
                                          );
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return const Icon(Icons.error_outline);
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                          FutureBuilder(
                              future:
                                  ApiHelper.allclassbyid(widget.data['number']),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return jobcontainer(
                                          snapshot, index, provider);
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return const Icon(Icons.error_outline);
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                        ],
                      ),
                    ),
                  ])),
            )
          ],
        ),
      ),
    );
  }

  Widget jobcontainer(AsyncSnapshot snapshot, int index, AppState provider) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: CallPage(
                  callID: snapshot.data[index]['addedby'] +
                      snapshot.data[index]['_id'],
                  userid: provider.prefs.getString('phone'),
                  username: provider.prefs.getString('phone'),
                ),
                type: PageTransitionType.fade));
      },
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade50,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: ApiHelper.getoneuserdata(
                      context, snapshot.data[index]['addedby']),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Align(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data['img'].toString(),
                            width: AppLayout.getwidth(context) * 0.15,
                            height: AppLayout.getwidth(context) * 0.15,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Center(child: Icon(Icons.error)),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Icon(
                        Icons.error,
                      );
                    } else {
                      return AppLayout.displaysimpleprogress(context);
                    }
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data[index]['name'],
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: AppLayout.getwidth(context) * 0.04),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          snapshot.data[index]['des'],
                          style: GoogleFonts.poppins(
                              fontSize: AppLayout.getwidth(context) * 0.03),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(snapshot.data[index]['date'],
                    style: GoogleFonts.poppins(
                        fontSize: AppLayout.getwidth(context) * 0.03,
                        fontWeight: FontWeight.bold)),
                Text(
                  snapshot.data[index]['time'],
                  style: GoogleFonts.poppins(
                      fontSize: AppLayout.getwidth(context) * 0.03,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
