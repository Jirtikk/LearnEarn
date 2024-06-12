import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/screen/navigation/classes/instructor.dart';
import 'package:learn_and_earn_mongodb/tools/col.dart';
import 'package:provider/provider.dart';

import '../../monoogshelper/mongoos.dart';
import '../../tools/applayout.dart';
import '../../tools/appstate.dart';

class classes extends StatefulWidget {
  const classes({super.key});

  @override
  State<classes> createState() => _classesState();
}

class _classesState extends State<classes> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.withOpacity(0.2),
              ),
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
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
                          hintText: "Search"),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        textEditingController.clear();
                        provider.notifyListeners();
                      },
                      child: const Icon(
                        Icons.clear,
                      )),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "All Instructor",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Expanded(
              child: FutureBuilder(
                  future: ApiHelper.alluser(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (snapshot.data[index]['useras'] == "Instructor") {
                            if (textEditingController.text.isEmpty) {
                              return jobcontainer(snapshot, index, provider);
                            } else if (snapshot.data[index]['name']
                                .toString()
                                .toLowerCase()
                                .contains(textEditingController.text
                                    .toString()
                                    .toLowerCase())) {
                              return jobcontainer(snapshot, index, provider);
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
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget jobcontainer(AsyncSnapshot snapshot, int index, AppState provider) {
    return InkWell(
      onTap: () async {
        bool c = await ApiHelper.registerrequest(
            provider.prefs.getString('phone'),
            snapshot.data[index]['number'],
            context);
        if (c) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return instructor(
              data: snapshot.data[index],
            );
          }));
        } else {
          AppLayout.showsnakbar(context, "your request is in process");
        }
      },
      child: Container(
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
                CachedNetworkImage(
                  imageUrl: snapshot.data[index]['img'].toString(),
                  width: AppLayout.getwidth(context) * 0.15,
                  height: AppLayout.getwidth(context) * 0.15,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
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
                          snapshot.data[index]['edu'],
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
            FutureBuilder(
              future: ApiHelper.giverequest(provider.prefs.getString('phone'),
                  snapshot.data[index]['number']),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.toString() == "{}") {
                    return Container(
                      width: AppLayout.getwidth(context),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red),
                      child: Center(
                          child: Text(
                        "Enroll now",
                        style: GoogleFonts.roboto(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    );
                  } else if (snapshot.data['status'] == "new") {
                    return Container(
                      width: AppLayout.getwidth(context),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green),
                      child: Center(
                          child: Text(
                        "Request is in process",
                        style: GoogleFonts.roboto(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                } else if (snapshot.hasError) {
                  return const Icon(
                    Icons.error,
                  );
                } else {
                  return AppLayout.displaysimpleprogress(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
