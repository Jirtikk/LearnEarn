import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/tools/top.dart';
import 'package:provider/provider.dart';

import '../../monoogshelper/mongoos.dart';
import '../../tools/applayout.dart';
import '../../tools/appstate.dart';

class adminclasses extends StatefulWidget {
  const adminclasses({super.key});

  @override
  State<adminclasses> createState() => _adminclassesState();
}

class _adminclassesState extends State<adminclasses> {
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            top(title: "class management"),
            Expanded(
              child: FutureBuilder(
                future: ApiHelper.allclass(),
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
                              onTap: () {},
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
                                            FutureBuilder(
                                              future: ApiHelper.getoneuserdata(
                                                  context,
                                                  snapshot.data[index]
                                                      ['addedby']),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot snapshot) {
                                                if (snapshot.hasData) {
                                                  return CachedNetworkImage(
                                                    imageUrl:
                                                        snapshot.data['img'],
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    placeholder: (context,
                                                            url) =>
                                                        const CircularProgressIndicator(),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Icon(
                                                      Icons.error,
                                                    ),
                                                  );
                                                } else if (snapshot.hasError) {
                                                  return const Icon(
                                                    Icons.error,
                                                  );
                                                } else {
                                                  return AppLayout
                                                      .displaysimpleprogress(
                                                          context);
                                                }
                                              },
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
                                                    snapshot.data[index]
                                                        ['name'],
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
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            bool c =
                                                await ApiHelper.deleteclass(
                                                    snapshot.data[index]['_id'],
                                                    context);
                                            if (c) {
                                              AppLayout.showsnakbar(context,
                                                  "Deleted Sucessfully");
                                              Navigator.pop(context);
                                            } else {
                                              AppLayout.showsnakbar(
                                                  context, "Try again later");
                                            }
                                          },
                                          child: const Align(
                                            alignment: Alignment.bottomRight,
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
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
      ),
    );
  }
}
