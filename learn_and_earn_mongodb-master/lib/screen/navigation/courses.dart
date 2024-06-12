// ignore_for_file: camel_case_types, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, must_be_immutable, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/monoogshelper/mongoos.dart';
import 'package:learn_and_earn_mongodb/screen/navigation/profile.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../tools/applayout.dart';
import '../../tools/appstate.dart';
import '../../tools/col.dart';
import 'coursesscreen/coursedata.dart';
import 'jobscreen/screens/videocall.dart';

class course extends StatelessWidget {
  const course({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: AppLayout.getwidth(context),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: col.pruple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: provider.prefs.containsKey('img')
                          ? provider.prefs.getString("img")
                          : 'www.google.com',
                      width: AppLayout.getwidth(context) * 0.1,
                      height: AppLayout.getwidth(context) * 0.1,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              provider.prefs.containsKey('name')
                                  ? provider.prefs.getString("name")
                                  : "name",
                              style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppLayout.getwidth(context) * 0.05),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                        Text(
                          provider.prefs.containsKey('education')
                              ? provider.prefs.getString("education")
                              : "education",
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: AppLayout.getwidth(context) * 0.03),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  FutureBuilder(
                      future: getdataa(context),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return CarouselSlider(
                              options: CarouselOptions(
                                  height: 200.0, autoPlay: true),
                              items: snapshot.data);
                        } else if (snapshot.hasError) {
                          return const Icon(Icons.error_outline);
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.withOpacity(0.2),
                    ),
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 5, bottom: 5),
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
                                fontWeight: FontWeight.bold, fontSize: 20),
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
                                hintText: "Search"),
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
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Recommended Courses",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                  SizedBox(
                    width: AppLayout.getwidth(context),
                    height: 200,
                    child: FutureBuilder(
                        future: ApiHelper.course(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length - 2 > 0
                                  ? snapshot.data.length - 2
                                  : snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (snapshot.data[index]['type'] == 'Company') {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: coursedata(
                                                dataa: snapshot.data[index],
                                                indexx: 1,
                                              ),
                                              type: PageTransitionType.fade));
                                    },
                                    child: Container(
                                      width: 140,
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.amber.shade50,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl: snapshot.data[index]
                                                      ['img']
                                                  .toString(),
                                              width:
                                                  AppLayout.getwidth(context) *
                                                      0.15,
                                              height:
                                                  AppLayout.getwidth(context) *
                                                      0.15,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  const Center(
                                                      child: Icon(Icons.error)),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Text(
                                              snapshot.data[index]['title'],
                                              style: GoogleFonts.b612Mono(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: AppLayout.getwidth(
                                                          context) *
                                                      0.04),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Text(
                                              snapshot.data[index]['des'],
                                              style: GoogleFonts.b612Mono(
                                                  fontSize: AppLayout.getwidth(
                                                          context) *
                                                      0.03),
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            );
                          } else if (snapshot.hasError) {
                            return const Icon(Icons.error_outline);
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "All Courses",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                  FutureBuilder(
                      future: ApiHelper.course(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: snapshot.data.map<Widget>((e) {
                              if (e['type'] == 'Company') {
                                if (e["title"]
                                    .toString()
                                    .toLowerCase()
                                    .contains(provider
                                        .textEditingController!.text
                                        .toLowerCase())) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: coursedata(
                                                dataa: e,
                                                indexx: 1,
                                              ),
                                              type: PageTransitionType.fade));
                                    },
                                    child: Hero(
                                      tag: "data${1}",
                                      child: maincoursedata(data: e),
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              } else {
                                return const SizedBox.shrink();
                              }
                            }).toList(),
                          );
                        } else if (snapshot.hasError) {
                          return const Icon(Icons.error_outline);
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Widget>> getdataa(BuildContext context) async {
    List<Widget> img = [];
    List value = await ApiHelper.adver();
    for (var element in value) {
      img.add(Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: element['img'],
            width: AppLayout.getwidth(context),
            height: AppLayout.getwidth(context) * 0.1,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
          ),
        ),
      ));
    }
    return img;
  }
}

class maincoursedata extends StatelessWidget {
  maincoursedata({Key? key, required this.data}) : super(key: key);
  Map data;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: col.wh,
      child: Container(
        width: AppLayout.getwidth(context),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green.withOpacity(0.1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      accountinfo(
                        title: "Name : ",
                        name: data['title'].toString(),
                        icon: Icons.golf_course,
                      ),
                      FutureBuilder(
                        future: ApiHelper.getoneuserdata(context, data['ins']),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return accountinfo(
                              title: "Company : ",
                              name: snapshot.data['edu'].toString(),
                              icon: Icons.person,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          data['des'],
                          style: GoogleFonts.poppins(
                              fontSize: AppLayout.getwidth(context) * 0.04),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: data['img'].toString(),
                    width: AppLayout.getwidth(context) * 0.15,
                    height: AppLayout.getwidth(context) * 0.15,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
