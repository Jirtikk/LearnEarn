import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/monoogshelper/mongoos.dart';

import '../../../tools/applayout.dart';
import '../../../tools/top.dart';

class faq extends StatelessWidget {
  const faq({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            top(title: "FAQ"),
            Expanded(
              child: FutureBuilder(
                future: ApiHelper.allfaqs(context),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            width: AppLayout.getwidth(context),
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.deepPurple.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(snapshot.data[index]['title'],
                                        style: GoogleFonts.roboto(
                                            fontSize:
                                                AppLayout.getwidth(context) *
                                                    0.045,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(snapshot.data[index]['ans'],
                                        style: GoogleFonts.roboto(
                                            fontSize:
                                                AppLayout.getwidth(context) *
                                                    0.04)),
                                  ),
                                ]));
                      },
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
            )
          ],
        ),
      ),
    );
  }
}
