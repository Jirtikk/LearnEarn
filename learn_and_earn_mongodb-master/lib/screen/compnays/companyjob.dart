import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/tools/col.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../monoogshelper/mongoos.dart';
import '../../tools/applayout.dart';
import '../../tools/appstate.dart';
import '../navigation/jobscreen/screens/appliedjob.dart';
import '../navigation/jobscreen/screens/updatejob.dart';
import 'addjob.dart';

class companyjobs extends StatefulWidget {
  const companyjobs({super.key});

  @override
  State<companyjobs> createState() => _companyjobsState();
}

class _companyjobsState extends State<companyjobs> {
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Jobs Posted",
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
                            controller: provider.textEditingController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: EdgeInsets.all(10),
                                hintText: "Search Jobs"),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              provider.textEditingController!.clear();
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
                            child: const addjob(),
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
                )
              ],
            ),
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
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (provider.prefs.getString('useras') ==
                                'Company') {
                              if (provider.prefs.getString('phone') ==
                                  snapshot.data[index]['addedby']) {
                                return listdata(provider, snapshot, index);
                              } else {
                                return const SizedBox.shrink();
                              }
                            } else {
                              return listdata(provider, snapshot, index);
                            }
                          });
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

  Widget listdata(AppState provider, AsyncSnapshot snapshot, int index) {
    if (provider.textEditingController!.text.isEmpty) {
      return jobcontainer(provider, data: snapshot.data[index], inter: true);
    } else {
      if (snapshot.data[index]['title']
          .toLowerCase()
          .contains(provider.textEditingController!.text.toLowerCase())) {
        return jobcontainer(provider, data: snapshot.data[index], inter: true);
      } else {
        return const SizedBox.shrink();
      }
    }
  }

  Widget jobcontainer(AppState provider, {required data, required inter}) {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green.shade50,
        ),
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FutureBuilder(
                  future: ApiHelper.getoneuserdata(
                      context, provider.prefs.getString('phone')),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return CachedNetworkImage(
                        imageUrl: snapshot.data['img'].toString(),
                        imageBuilder: (context, imageProvider) => ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            width: 50,
                            height: 50,
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
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Icon(
                        Icons.error,
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    data['title'].toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                        fontSize: AppLayout.getwidth(context) * 0.04,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Posted By ",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: AppLayout.getwidth(context) * 0.03),
                ),
                Text(
                  data['companyname'].toString(),
                  style: GoogleFonts.montserrat(
                      fontSize: AppLayout.getwidth(context) * 0.03),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Rs : ${data['salary']}",
                      style: GoogleFonts.montserrat(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: AppLayout.getwidth(context) * 0.04),
                    ),
                    Text(
                      "This is fixed monthly salary",
                      style: GoogleFonts.montserrat(
                          fontSize: AppLayout.getwidth(context) * 0.03),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: updatejob(data: data),
                                type: PageTransitionType.fade));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: col.pruple),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: const appliedjob(),
                                type: PageTransitionType.fade));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: col.pruple),
                        child: const Icon(
                          Icons.app_registration,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ));
  }
}
