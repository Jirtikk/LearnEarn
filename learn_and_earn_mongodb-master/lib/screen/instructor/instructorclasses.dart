import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/screen/instructor/classes/addnewclass.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../monoogshelper/mongoos.dart';
import '../../tools/applayout.dart';
import '../../tools/appstate.dart';
import '../navigation/jobscreen/screens/videocall.dart';

class instructorclasses extends StatefulWidget {
  const instructorclasses({super.key});

  @override
  State<instructorclasses> createState() => _instructorclassesState();
}

class _instructorclassesState extends State<instructorclasses> {
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Yours Classes",
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: const addnewclass(),
                            type: PageTransitionType.fade));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.shade100,
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: ApiHelper.allclassbyid(provider.prefs.getString('phone')),
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
                        return InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: CallPage(
                                        callID: snapshot.data[index]
                                                ['addedby'] +
                                            snapshot.data[index]['_id'],
                                        userid:
                                            provider.prefs.getString('phone'),
                                        username:
                                            provider.prefs.getString('phone'),
                                      ),
                                      type: PageTransitionType.fade));
                            },
                            child: Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffecf3f8),
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl:
                                                provider.prefs.getString('img'),
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.error,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data[index]['name'],
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          AppLayout.getwidth(
                                                                  context) *
                                                              0.04),
                                                ),
                                                Text(
                                                  snapshot.data[index]['des'],
                                                  style: GoogleFonts.roboto(),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            provider.prefs.getString('name'),
                                            style: GoogleFonts.roboto(),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(
                                            Icons.circle,
                                            size: 10,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            snapshot.data[index]['date'],
                                            style: GoogleFonts.roboto(),
                                          ),
                                          Text(
                                            snapshot.data[index]['time'],
                                            style: GoogleFonts.roboto(),
                                          ),
                                        ],
                                      )
                                    ])));
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
    );
  }
}
