import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../monoogshelper/mongoos.dart';
import '../../../../tools/applayout.dart';
import '../../../../tools/appstate.dart';
import '../../../../tools/col.dart';
import '../../../../tools/top.dart';
import 'appliedjob.dart';

class studenview extends StatelessWidget {
  studenview({super.key, required this.check});
  bool check;

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Column(
          children: [
            top(title: 'Application'),
            Expanded(
                child: FutureBuilder(
              future: ApiHelper.getalljobapplied(context),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.toString() == '[]') {
                    return Center(
                        child: Text(
                      "No Data",
                      style: GoogleFonts.poppins(),
                    ));
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (snapshot.data[index]['appliedby'] ==
                              provider.prefs.getString('phone')) {
                            if (snapshot.data[index]['status'] == 'new') {
                              return studentjobs(data: snapshot.data[index]);
                            } else {
                              return hire(data: snapshot.data[index]);
                            }
                          } else {
                            return const SizedBox.shrink();
                          }
                        });
                  }
                } else if (snapshot.hasError) {
                  return const Icon(
                    Icons.error,
                  );
                } else {
                  return AppLayout.displaysimpleprogress(context);
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}

class studentjobs extends StatelessWidget {
  studentjobs({super.key, required this.data});
  Map data;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: AppLayout.getwidth(context),
        height: 70,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.withOpacity(0.1),
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
                mainAxisAlignment: MainAxisAlignment.start,
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
              children: [
                const Icon(Icons.paid),
                Text(data['salary'].toString(),
                    style: GoogleFonts.poppins(
                        fontSize: AppLayout.getwidth(context) * 0.03))
              ],
            ),
          ],
        ));
  }
}
