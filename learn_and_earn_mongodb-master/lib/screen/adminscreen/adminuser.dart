import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/monoogshelper/mongoos.dart';
import 'package:learn_and_earn_mongodb/tools/applayout.dart';
import 'package:learn_and_earn_mongodb/tools/top.dart';

class adminuser extends StatefulWidget {
  const adminuser({super.key});

  @override
  State<adminuser> createState() => _adminuserState();
}

class _adminuserState extends State<adminuser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            top(title: "User Management"),
            Expanded(
                child: FutureBuilder(
              future: ApiHelper.alluser(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  if (snapshot.data.toString() == '[]') {
                    return const Center(
                      child: Text("No Data"),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200),
                          width: AppLayout.getwidth(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: snapshot.data[index]['img'],
                                    imageBuilder: (context, imageProvider) =>
                                        ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
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
                                        AppLayout.displaysimpleprogress(
                                            context),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data[index]['name'],
                                          style: GoogleFonts.b612Mono(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(snapshot.data[index]['number']),
                                        Text(snapshot.data[index]['gender']),
                                      ]),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data[index]['edu'],
                                style: GoogleFonts.b612Mono(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                snapshot.data[index]['useras'],
                                style: GoogleFonts.poppins(),
                              ),
                              InkWell(
                                onTap: () async {
                                  bool c = await ApiHelper.deleteuser(
                                      snapshot.data[index]['_id'], context);
                                  if (c) {
                                    AppLayout.showsnakbar(
                                        context, "Deleted Sucessfully");
                                    Navigator.pop(context);
                                  } else {
                                    AppLayout.showsnakbar(
                                        context, "Try again later");
                                  }
                                },
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                } else if (snapshot.hasError) {
                  return const Icon(
                    Icons.error,
                  );
                } else {
                  return AppLayout.displaysimpleprogress(context);
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
