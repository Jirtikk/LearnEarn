import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../monoogshelper/mongoos.dart';
import '../../tools/applayout.dart';
import '../../tools/appstate.dart';

class instructorrequest extends StatefulWidget {
  const instructorrequest({super.key});

  @override
  State<instructorrequest> createState() => _instructorrequestState();
}

class _instructorrequestState extends State<instructorrequest> {
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: ApiHelper.allrequestbyid(provider.prefs.getString('phone')),
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
                        onTap: () async {
                          if(snapshot.data[index]['status'] == "new"){
                            bool c = await ApiHelper.changerequeststatus(
                                snapshot.data[index]['uid'],
                                provider.prefs.getString('phone'), context);
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber.shade50,
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder(
                                  future: ApiHelper.getoneuserdata(
                                      context, snapshot.data[index]['uid']),
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl: snapshot.data['img'].toString(),
                                              width: AppLayout.getwidth(context) * 0.15,
                                              height: AppLayout.getwidth(context) * 0.15,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => const Center(
                                                  child: CircularProgressIndicator()),
                                              errorWidget: (context, url, error) =>
                                              const Center(child: Icon(Icons.error)),
                                            ),
                                          ),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data
                                                ['name'],
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Text(
                                                snapshot.data['number'],
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black),
                                              )
                                            ],
                                          ))
                                        ],
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
                                const SizedBox(height: 10,),
                                Text("status : "+snapshot.data[index]['status'],
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)
                              ]),
                        )
                    );
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
    );
  }
}
