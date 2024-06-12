// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/screen/navigation/profile/quiz.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../monoogshelper/mongoos.dart';
import '../../../tools/applayout.dart';
import '../../../tools/appstate.dart';
import '../../../tools/top.dart';
import '../coursesscreen/coursedata.dart';
import 'certificate.dart';

class certificateview extends StatelessWidget {
  const certificateview({super.key});

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            top(
              title: 'Certificate',
            ),
            Expanded(
              child: FutureBuilder(
                future: ApiHelper.getstartedbynum(
                    provider.prefs.getString('phone')),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(snapshot.data);
                        return Container(
                          width: AppLayout.getwidth(context),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.3), // Shadow color
                                spreadRadius: 2, // Spread radius
                                blurRadius: 2, // Blur radius
                                offset: const Offset(
                                    0, 0), // Offset in the x and y direction
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: snapshot.data![index]
                                            ['courseData']['img']
                                        .toString(),
                                    width: AppLayout.getwidth(context) * 0.15,
                                    height: AppLayout.getwidth(context) * 0.15,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Center(child: Icon(Icons.error)),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index]['courseData']
                                                ['title']
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              AppLayout.getwidth(context) *
                                                  0.045,
                                        ),
                                      ),
                                      Wrap(
                                        children: [
                                          Text(
                                            'Total :  ',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold,
                                                fontSize: AppLayout.getwidth(
                                                        context) *
                                                    0.04),
                                          ),
                                          Text(
                                            (snapshot.data![index]
                                                    ['playlistLength'])
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                fontSize: AppLayout.getwidth(
                                                        context) *
                                                    0.04),
                                          ),
                                        ],
                                      ),
                                      Wrap(
                                        children: [
                                          Text(
                                            'Completed :  ',
                                            style: GoogleFonts.roboto(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: AppLayout.getwidth(
                                                        context) *
                                                    0.04),
                                          ),
                                          Text(
                                            (snapshot.data![index]['q'].length)
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                fontSize: AppLayout.getwidth(
                                                        context) *
                                                    0.04,
                                                color: Colors.green),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 70,
                                      child: Center(
                                        child: SfCircularChart(
                                          series: <CircularSeries>[
                                            DoughnutSeries<ChartData, String>(
                                              dataSource: [
                                                ChartData(
                                                    'Total',
                                                    double.parse((snapshot
                                                                .data![index]
                                                            ['playlistLength'])
                                                        .toString())),
                                                ChartData(
                                                    'Completed',
                                                    double.parse((snapshot
                                                        .data![index]['q']
                                                        .length
                                                        .toString()))),
                                              ],
                                              xValueMapper:
                                                  (ChartData data, _) =>
                                                      data.category,
                                              yValueMapper:
                                                  (ChartData data, _) =>
                                                      data.value,
                                              dataLabelSettings:
                                                  const DataLabelSettings(
                                                      isVisible: true,
                                                      labelPosition:
                                                          ChartDataLabelPosition
                                                              .outside),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () async {
                                  if (snapshot.data![index]['playlistLength'] ==
                                      snapshot.data![index]['q'].length) {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: certificate(
                                              title: snapshot.data![index]
                                                      ['title']
                                                  .toString(),
                                            ),
                                            type: PageTransitionType.fade));
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: snapshot.data![index]
                                                ['playlistLength'] ==
                                            snapshot.data![index]['q'].length
                                        ? Colors.green
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Certificate',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              AppLayout.getwidth(context) *
                                                  0.045,
                                          color: snapshot.data![index]
                                                      ['playlistLength'] ==
                                                  snapshot
                                                      .data![index]['q'].length
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Icon(
                      Icons.error,
                      color: Colors.black,
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

class ChartData {
  final String category;
  final double value;
  ChartData(this.category, this.value);
}
