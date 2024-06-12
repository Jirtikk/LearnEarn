import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../monoogshelper/mongoos.dart';
import '../../tools/applayout.dart';
import '../../tools/appstate.dart';
import '../../tools/top.dart';
import '../navigation/jobs.dart';

class adminjobs extends StatefulWidget {
  const adminjobs({super.key});

  @override
  State<adminjobs> createState() => _adminjobsState();
}

class _adminjobsState extends State<adminjobs> {
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            top(title: "jobs management"),
            Expanded(
              child: FutureBuilder(
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
                          return Column(
                            children: [
                              jobcontainer(data: e, inter: true),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.end,
                                  children: [
                                    // Text(
                                    //   "Delete",
                                    //   style: GoogleFonts.poppins(
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                    InkWell(
                                        onTap: () async {
                                          bool c = await ApiHelper.deletejob(
                                              e['_id'], context);
                                          if (c) {
                                            AppLayout.showsnakbar(
                                                context, "Deleted Sucessfully");
                                            Navigator.pop(context);
                                          } else {
                                            AppLayout.showsnakbar(
                                                context, "Try again later");
                                          }
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          );
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
