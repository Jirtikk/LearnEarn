import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/tools/col.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../monoogshelper/mongoos.dart';
import '../../tools/applayout.dart';
import '../../tools/appstate.dart';
import '../account/login.dart';
import '../navigation/jobscreen/screens/appliedjob.dart';
import '../navigation/jobscreen/screens/updatejob.dart';
import '../navigation/profile.dart';
import 'addjob.dart';
import 'courses/companyaddcourse.dart';
import 'courses/companyaddplaylist.dart';

class companyprofile extends StatefulWidget {
  const companyprofile({super.key});

  @override
  State<companyprofile> createState() => _companyprofileState();
}

class _companyprofileState extends State<companyprofile> {
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: col.pruple,
        title: Text(
          "Your Profile",
          style: GoogleFonts.poppins(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Yours Details",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: AppLayout.getwidth(context) * 0.05),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
            ),
            child: Column(
              children: [
                accountinfo(
                  title: "Name",
                  name: provider.prefs.getString("name"),
                  icon: Icons.person,
                ),
                accountinfo(
                  title: "Bio",
                  name: provider.prefs.getString("edu"),
                  icon: Icons.person,
                ),
                accountinfo(
                  title: "Phone Number",
                  name: provider.prefs.getString("phone"),
                  icon: Icons.call,
                ),
                accountinfo(
                  title: "Account Type",
                  name: provider.prefs.getString("useras"),
                  icon: Icons.person,
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Text(
          //     "Jobs Posted",
          //     style: GoogleFonts.poppins(
          //         fontWeight: FontWeight.bold,
          //         fontSize: AppLayout.getwidth(context) * 0.05),
          //   ),
          // ),
          // SizedBox(
          //   width: AppLayout.getwidth(context),
          //   height: 200,
          //   child: FutureBuilder(
          //     future: ApiHelper.getalljob(context),
          //     builder: (BuildContext context, AsyncSnapshot snapshot) {
          //       if (snapshot.hasData) {
          //         if (snapshot.data.toString() == '[]') {
          //           return Center(
          //             child: Text(
          //               "No Data",
          //               style: GoogleFonts.poppins(),
          //             ),
          //           );
          //         } else {
          //           return ListView.builder(
          //               itemCount: snapshot.data.length,
          //               scrollDirection: Axis.horizontal,
          //               itemBuilder: (BuildContext context, int index) {
          //                 if (provider.prefs.getString('useras') == 'Company') {
          //                   if (provider.prefs.getString('phone') ==
          //                       snapshot.data[index]['addedby']) {
          //                     return jobcontainer(provider,
          //                         data: snapshot.data[index], inter: true);
          //                   } else {
          //                     return const SizedBox.shrink();
          //                   }
          //                 } else {
          //                   return jobcontainer(provider,
          //                       data: snapshot.data[index], inter: true);
          //                 }
          //               });
          //         }
          //       } else if (snapshot.hasError) {
          //         return const Icon(
          //           Icons.error,
          //         );
          //       } else {
          //         return const Center(child: CircularProgressIndicator());
          //       }
          //     },
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Text(
          //     "Courses",
          //     style: GoogleFonts.poppins(
          //         fontWeight: FontWeight.bold,
          //         fontSize: AppLayout.getwidth(context) * 0.05),
          //   ),
          // ),
          // SizedBox(
          //   width: AppLayout.getwidth(context),
          //   height: 350,
          //   child: FutureBuilder(
          //     future: ApiHelper.course(),
          //     builder: (BuildContext context, AsyncSnapshot snapshot) {
          //       if (snapshot.hasData) {
          //         if (snapshot.data.toString() == '[]') {
          //           return const Center(
          //             child: Text("No Data"),
          //           );
          //         } else {
          //           return ListView.builder(
          //             itemCount: snapshot.data.length,
          //             scrollDirection: Axis.horizontal,
          //             itemBuilder: (BuildContext context, int index) {
          //               if (snapshot.data[index]['ins'] ==
          //                   provider.prefs.getString("phone")) {
          //                 return InkWell(
          //                   onTap: () {
          //                     Navigator.push(
          //                         context,
          //                         PageTransition(
          //                             child: companyaddplaylist(
          //                                 courseid: snapshot.data[index]
          //                                     ['_id']),
          //                             type: PageTransitionType.fade));
          //                   },
          //                   child: Stack(
          //                     children: [
          //                       Container(
          //                         width: AppLayout.getwidth(context),
          //                         height: 280,
          //                         margin: const EdgeInsets.only(
          //                             left: 20, top: 20, right: 10),
          //                         decoration: BoxDecoration(
          //                             color: Colors.black,
          //                             borderRadius: BorderRadius.circular(10)),
          //                       ),
          //                       Container(
          //                           width: AppLayout.getwidth(context),
          //                           height: 280,
          //                           margin: const EdgeInsets.only(
          //                               left: 10, top: 10, right: 20),
          //                           decoration: BoxDecoration(
          //                               color: Colors.white,
          //                               borderRadius: BorderRadius.circular(10),
          //                               boxShadow: [
          //                                 BoxShadow(
          //                                   color:
          //                                       Colors.black.withOpacity(0.1),
          //                                   spreadRadius: 2,
          //                                   blurRadius: 2,
          //                                   offset: const Offset(0, 2),
          //                                 ),
          //                               ]),
          //                           child: Column(
          //                               crossAxisAlignment:
          //                                   CrossAxisAlignment.start,
          //                               children: [
          //                                 CachedNetworkImage(
          //                                   imageUrl: snapshot.data[index]
          //                                       ['img'],
          //                                   imageBuilder:
          //                                       (context, imageProvider) =>
          //                                           Container(
          //                                     width:
          //                                         AppLayout.getwidth(context),
          //                                     height: 200,
          //                                     decoration: BoxDecoration(
          //                                       image: DecorationImage(
          //                                         image: imageProvider,
          //                                         fit: BoxFit.cover,
          //                                       ),
          //                                     ),
          //                                   ),
          //                                   placeholder: (context, url) =>
          //                                       AppLayout.displaysimpleprogress(
          //                                           context),
          //                                   errorWidget:
          //                                       (context, url, error) =>
          //                                           const Icon(Icons.error),
          //                                 ),
          //                                 Padding(
          //                                   padding: const EdgeInsets.all(8.0),
          //                                   child: Column(
          //                                     crossAxisAlignment:
          //                                         CrossAxisAlignment.start,
          //                                     children: [
          //                                       Text(
          //                                         snapshot.data[index]['title'],
          //                                         style: GoogleFonts.b612Mono(
          //                                             color: Colors.black,
          //                                             fontSize: 20,
          //                                             fontWeight:
          //                                                 FontWeight.bold),
          //                                       ),
          //                                       Text(
          //                                         snapshot.data[index]['des'],
          //                                         style: GoogleFonts.b612Mono(
          //                                             color: Colors.black),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 )
          //                               ])),
          //                     ],
          //                   ),
          //                 );
          //               } else {
          //                 return SizedBox.shrink();
          //               }
          //             },
          //           );
          //         }
          //       } else if (snapshot.hasError) {
          //         return const Icon(Icons.error);
          //       } else {
          //         return AppLayout.displaysimpleprogress(context);
          //       }
          //     },
          //   ),
          // ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              provider.prefs.remove('phone');
              provider.prefs.remove('img');
              provider.prefs.remove('education');
              provider.prefs.remove('name');
              provider.prefs.remove('useras');
              provider.prefs.remove('auth');
              provider.phone = '';
              provider.pass = '';

              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: const Login(), type: PageTransitionType.fade),
                  (Route<dynamic> route) => false);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 20, left: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: col.pruple,
                border: Border.all(width: 1, color: Colors.grey.shade400),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  Text(
                    "Logout",
                    style: GoogleFonts.b612Mono(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget jobcontainer(AppState provider, {required data, required inter}) {
    return Container(
        width: AppLayout.getwidth(context),
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

  Widget accountinfo(
      {required String title, required String name, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(icon),
              ),
              Text(
                title,
                style: GoogleFonts.b612Mono(
                    fontWeight: FontWeight.bold,
                    fontSize: AppLayout.getwidth(context) * 0.04),
              ),
            ],
          ),
          Text(
            name,
            style: GoogleFonts.b612Mono(
                fontSize: AppLayout.getwidth(context) * 0.04),
          ),
        ],
      ),
    );
  }
}
