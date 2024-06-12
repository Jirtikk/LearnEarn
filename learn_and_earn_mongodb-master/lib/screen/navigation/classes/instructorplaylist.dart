import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/screen/navigation/classes/instructorvideo.dart';
import 'package:learn_and_earn_mongodb/tools/col.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../monoogshelper/mongoos.dart';
import '../../../tools/applayout.dart';
import '../../../tools/appstate.dart';
import '../../../tools/top.dart';
import '../../../uihelpers/button_helper.dart';
import '../coursesscreen/videoscreen.dart';

class instructorplaylist extends StatefulWidget {
  instructorplaylist({super.key, required this.dataa, required this.indexx});
  Map dataa;
  int indexx;

  @override
  State<instructorplaylist> createState() => _instructorplaylistState();
}

class _instructorplaylistState extends State<instructorplaylist> {
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Column(
          children: [
            top(title: widget.dataa["title"].toString()),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(
                future: ApiHelper.courseplaylist(widget.dataa['_id']),
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            width: AppLayout.getwidth(context),
                            margin: const EdgeInsets.only(bottom: 10),
                            color: Colors.grey.withOpacity(0.1),
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: snapshot.data![index]['img'],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: AppLayout.getwidth(context),
                                    height: 200,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index]['title'],
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                AppLayout.getwidth(context) *
                                                    0.05),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        snapshot.data![index]['des'],
                                        style: GoogleFonts.roboto(
                                            fontSize:
                                                AppLayout.getwidth(context) *
                                                    0.04),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      button_helper(
                                          onpress: () async {
                                            await Navigator.push(
                                                context,
                                                PageTransition(
                                                    child: instructorvideo(
                                                      number: provider.prefs
                                                          .getString('phone'),
                                                      cdata:
                                                          snapshot.data![index],
                                                      courseid:
                                                          widget.dataa['_id'],
                                                    ),
                                                    type: PageTransitionType
                                                        .fade));
                                            setState(() {});
                                          },
                                          color: col.pruple,
                                          width: AppLayout.getwidth(context),
                                          child: Center(
                                            child: Text(
                                              "Watch Now",
                                              style: GoogleFonts.roboto(
                                                  fontSize: AppLayout.getwidth(
                                                          context) *
                                                      0.04,
                                                  fontWeight: FontWeight.bold,
                                                  color: col.wh),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ));
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.error_outline);
                  } else {
                    return const Center(child: CircularProgressIndicator());
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
