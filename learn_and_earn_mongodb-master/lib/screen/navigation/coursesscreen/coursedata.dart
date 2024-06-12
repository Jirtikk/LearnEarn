// ignore_for_file: must_be_immutable, camel_case_types, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/monoogshelper/mongoos.dart';
import 'package:learn_and_earn_mongodb/screen/navigation/coursesscreen/videoscreen.dart';
import 'package:learn_and_earn_mongodb/uihelpers/button_helper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../tools/col.dart';
import '../../../tools/applayout.dart';
import '../../../tools/appstate.dart';
import '../../../tools/top.dart';
import '../courses.dart';
import '../profile/quiz.dart';

class coursedata extends StatefulWidget {
  coursedata({Key? key, required this.dataa, required this.indexx})
      : super(key: key);
  Map dataa;
  int indexx;

  @override
  State<coursedata> createState() => _coursedataState();
}

class _coursedataState extends State<coursedata> {
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);

    ApiHelper.registerstarted(provider.prefs.getString('phone'),
        widget.dataa["_id"].toString(), context);

    final MovieTween tween = MovieTween()
      ..scene(
              begin: const Duration(milliseconds: 500),
              end: const Duration(milliseconds: 1000))
          .tween('x', Tween(begin: 100.0, end: 0.0), curve: Curves.elasticOut)
      ..scene(
              begin: const Duration(milliseconds: 0),
              end: const Duration(milliseconds: 800))
          .tween('main', Tween(begin: 100.0, end: 0.0),
              curve: Curves.elasticOut)
      ..scene(
              begin: const Duration(milliseconds: 500),
              end: const Duration(milliseconds: 700))
          .tween('pic', Tween(begin: 0.0, end: 1.0), curve: Curves.bounceOut)
      ..scene(
              begin: const Duration(milliseconds: 500),
              end: const Duration(milliseconds: 900))
          .tween('text', Tween(begin: 0.0, end: 1.0), curve: Curves.easeIn);

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
                        return PlayAnimationBuilder<Movie>(
                            tween: tween, // Pass in tween
                            duration: tween.duration,
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(0, value.get('main')),
                                child: Container(
                                    width: AppLayout.getwidth(context),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    color: Colors.grey.withOpacity(0.1),
                                    child: Column(
                                      children: [
                                        Opacity(
                                          opacity: value.get('pic'),
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot.data![index]
                                                ['img'],
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width:
                                                  AppLayout.getwidth(context),
                                              height: 200,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            progressIndicatorBuilder:
                                                (context, url,
                                                        downloadProgress) =>
                                                    CircularProgressIndicator(
                                                        value:
                                                            downloadProgress
                                                                .progress),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        Transform.translate(
                                          offset: Offset(0, value.get('x')),
                                          child: Opacity(
                                            opacity: value.get('text'),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data![index]
                                                        ['title'],
                                                    style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: AppLayout
                                                                .getwidth(
                                                                    context) *
                                                            0.05),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    snapshot.data![index]
                                                        ['des'],
                                                    style: GoogleFonts.roboto(
                                                        fontSize: AppLayout
                                                                .getwidth(
                                                                    context) *
                                                            0.04),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  FutureBuilder(
                                                    future: ApiHelper.getstartedlength(provider.prefs.getString('phone'), widget.dataa['_id'].toString()),
                                                    builder: (BuildContext context, AsyncSnapshot snapshot22) {
                                                      if(snapshot22.hasData){
                                                        if(snapshot22.data.toString() == '[]'){
                                                          return button_helper(onpress: () async {
                                                            await Navigator.push(
                                                                context,
                                                                PageTransition(
                                                                    child: videoscreen(
                                                                      number: provider.prefs.getString('phone'),
                                                                        cdata: snapshot.data![index],courseid: widget.dataa['_id']),
                                                                    type: PageTransitionType.fade));
                                                            setState(() {});
                                                          }, color: col.pruple,
                                                              width: AppLayout.getwidth(context),
                                                              child: Center(
                                                                child: Text("Watch Now",
                                                                  style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.04,
                                                                      fontWeight: FontWeight.bold,color: col.wh),),
                                                              ));
                                                        } else {
                                                          if (snapshot22.data[0]["v"].contains(snapshot.data![index]["_id"])) {
                                                            if (snapshot22.data[0]["q"].contains(snapshot.data![index]["qid"])) {
                                                              return button_helper(onpress: () async {
                                                                await Navigator.push(
                                                                    context,
                                                                    PageTransition(
                                                                        child: videoscreen(
                                                                            number: provider.prefs.getString('phone'),
                                                                            cdata: snapshot.data![index],courseid: widget.dataa['_id']),
                                                                        type: PageTransitionType.fade));
                                                                setState(() {});
                                                              }, color: col.pruple,
                                                                  width: AppLayout.getwidth(context),
                                                                  child: Center(
                                                                    child: Text("Watch again",
                                                                      style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.04,
                                                                          fontWeight: FontWeight.bold,color: col.wh),),
                                                                  ));
                                                            } else {
                                                              return button_helper(onpress: () async {
                                                                await Navigator.push(
                                                                    context,
                                                                    PageTransition(
                                                                        child: quizsolve(
                                                                            number: provider.prefs.getString('phone'),
                                                                            cdata: snapshot.data![index]
                                                                            ,couseid: widget.dataa['_id']),
                                                                        type: PageTransitionType.fade));
                                                                setState(() {});
                                                              }, color: col.pruple,
                                                                  width: AppLayout.getwidth(context),
                                                                  child: Center(
                                                                    child: Text("Give Quiz",
                                                                      style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.04,
                                                                          fontWeight: FontWeight.bold,color: col.wh),),
                                                                  ));
                                                            }
                                                          } else {
                                                            return button_helper(onpress: () async {
                                                              await Navigator.push(
                                                                  context,
                                                                  PageTransition(
                                                                      child: videoscreen(
                                                                        number: provider.prefs.getString('phone'),
                                                                          cdata: snapshot.data![index],courseid: widget.dataa['_id'],),
                                                                      type: PageTransitionType.fade));
                                                              setState(() {});
                                                            }, color: col.pruple,
                                                                width: AppLayout.getwidth(context),
                                                                child: Center(
                                                                  child: Text("Watch Now",
                                                                    style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.04,
                                                                        fontWeight: FontWeight.bold,color: col.wh),),
                                                                ));
                                                          }
                                                        }
                                                      } else {
                                                        return const SizedBox.shrink();
                                                      }
                                                    },
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              );
                            });
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
