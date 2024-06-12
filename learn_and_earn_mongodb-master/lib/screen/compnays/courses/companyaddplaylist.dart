import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/screen/instructor/course/instructoraddplaylist.dart';
import 'package:learn_and_earn_mongodb/tools/col.dart';
import 'package:page_transition/page_transition.dart';

import '../../../monoogshelper/mongoos.dart';
import '../../../tools/applayout.dart';
import 'companyaddplaylistnewdata.dart';

class companyaddplaylist extends StatefulWidget {
  companyaddplaylist({super.key,required this.courseid, this.company = true});
  String courseid;
  bool company;

  @override
  State<companyaddplaylist> createState() => _companyaddplaylistState();
}

class _companyaddplaylistState extends State<companyaddplaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: col.pruple,
        actions: [
          InkWell(
              onTap: () {
                setState(() {});
              },
              child: const Icon(Icons.refresh,color: Colors.white,))
        ],
        title: Text('Populate Your Course',
          style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: ApiHelper.courseplaylist(widget.courseid),
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
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
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                CircularProgressIndicator(value: downloadProgress.progress),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(snapshot.data![index]['title'], style: GoogleFonts.b612Mono(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppLayout.getwidth(
                                        context) * 0.05), maxLines: 1,
                                  overflow: TextOverflow.ellipsis,),
                                Text(snapshot.data![index]['des'], style: GoogleFonts.b612Mono(
                                    fontSize: AppLayout.getwidth(
                                        context) * 0.04), maxLines: 2,
                                  overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                          ),
                        ],
                      )
                  );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.company == true) {
            Navigator.push(
                context,
                PageTransition(
                    child: companyaddplaylistnewdata(courseid: widget.courseid,),
                    type: PageTransitionType.fade));
          } else {
            Navigator.push(
                context,
                PageTransition(
                    child: instructoraddplaylist(courseid: widget.courseid,),
                    type: PageTransitionType.fade));
          }
        },
        backgroundColor: col.pruple,
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
