import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/monoogshelper/mongoos.dart';
import 'package:learn_and_earn_mongodb/screen/compnays/courses/companyaddplaylist.dart';
import 'package:learn_and_earn_mongodb/tools/applayout.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../tools/appstate.dart';
import 'courses/companyaddcourse.dart';

class companycourse extends StatefulWidget {
  const companycourse({super.key});

  @override
  State<companycourse> createState() => _companycourseState();
}

class _companycourseState extends State<companycourse> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Yours Courses",
                style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.shade100,
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
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
                                hintText: "Search Course"),
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
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: const companyaddcourse(),
                            type: PageTransitionType.fade));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.shade100,
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                    ),
                    padding: const EdgeInsets.all(13),
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: ApiHelper.course(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.toString() == '[]') {
                      return const Center(
                        child: Text("No Data"),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (snapshot.data[index]['ins'] ==
                              provider.prefs.getString("phone")) {
                            if (textEditingController.text.isEmpty) {
                              return coudata(snapshot, index);
                            } else {
                              if (snapshot.data[index]['title']
                                  .toLowerCase()
                                  .contains(textEditingController.text
                                      .toLowerCase())) {
                                return coudata(snapshot, index);
                              } else {
                                return const SizedBox.shrink();
                              }
                            }
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      );
                    }
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.error);
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

  Widget coudata(AsyncSnapshot snapshot, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child:
                    companyaddplaylist(courseid: snapshot.data[index]['_id']),
                type: PageTransitionType.fade));
      },
      child: Stack(
        children: [
          Container(
            width: AppLayout.getwidth(context),
            height: 320,
            margin: const EdgeInsets.only(left: 20, top: 20, right: 10),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10)),
          ),
          Container(
              width: AppLayout.getwidth(context),
              height: 320,
              margin: const EdgeInsets.only(left: 10, top: 10, right: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ]),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: snapshot.data[index]['img'],
                      imageBuilder: (context, imageProvider) => Container(
                        width: AppLayout.getwidth(context),
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          AppLayout.displaysimpleprogress(context),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data[index]['title'],
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            snapshot.data[index]['des'],
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                        ],
                      ),
                    )
                  ])),
        ],
      ),
    );
  }
}
