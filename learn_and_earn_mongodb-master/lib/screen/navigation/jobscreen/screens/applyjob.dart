// ignore_for_file: must_be_immutable, use_build_context_synchronously, camel_case_types

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/firenasedatabasehelper/firebaseuploadhelper.dart';
import 'package:learn_and_earn_mongodb/monoogshelper/mongoos.dart';
import 'package:learn_and_earn_mongodb/screen/navigation/jobscreen/screens/videocall.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

import '../../../../tools/applayout.dart';
import '../../../../tools/appstate.dart';
import '../../../../tools/col.dart';
import '../../../../tools/top.dart';

class applyjob extends StatefulWidget {
  applyjob({Key? key, required this.data}) : super(key: key);
  Map data;

  @override
  State<applyjob> createState() => _applyjobState();
}

class _applyjobState extends State<applyjob> {
  File? _selectedPdf;
  String? _pdfTitle;
  String? _pdfDescription;

  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        _selectedPdf = file;
        _pdfTitle = path.basename(file.path);
        _pdfDescription = path.basename(file.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            top(title: "Apply Job"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      FutureBuilder(
                        future: ApiHelper.getoneuserdata(
                            context, provider.prefs.getString('phone')),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return CachedNetworkImage(
                              imageUrl: snapshot.data['img'].toString(),
                              imageBuilder: (context, imageProvider) =>
                                  ClipRRect(
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
                          widget.data['title'].toString(),
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
                        widget.data['companyname'].toString(),
                        style: GoogleFonts.montserrat(
                            fontSize: AppLayout.getwidth(context) * 0.03),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              width: AppLayout.getwidth(context),
              child: Text(widget.data['des'],
                  style: GoogleFonts.roboto(
                      fontSize: AppLayout.getwidth(context) * 0.04)),
            ),
            Column(
              children: [
                Text(
                  "Rs : ${widget.data['salary']}",
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(Icons.call),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(widget.data['addedby'],
                      style: GoogleFonts.roboto(
                          fontSize: AppLayout.getwidth(context) * 0.035)),
                ],
              ),
            ),
            FutureBuilder(
              future: ApiHelper.getjobappliedby(
                  context,
                  provider.prefs.getString("phone"),
                  widget.data['addedby'],
                  widget.data['title'],
                  widget.data['des'],
                  widget.data['companyname'],
                  widget.data['salary']),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length == 0) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () => _pickPdf(),
                          child: Container(
                            width: AppLayout.getwidth(context) * 0.4,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1,
                                    color: Colors.grey.withOpacity(0.3))),
                            child: Column(
                              children: [
                                const Icon(Icons.file_upload_outlined),
                                Text(
                                  _pdfTitle ?? 'No PDF selected',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (_selectedPdf == null) {
                              AppLayout.showsnakbar(
                                  context, "Please add your resume");
                            } else {
                              AppLayout.displayprogress(context);

                              String rurl = await FirebaseHelper.uploadFile(
                                  _selectedPdf,
                                  provider,
                                  widget.data['addedby']);

                              bool c = await ApiHelper.registerjobapplied(
                                  widget.data['addedby'],
                                  widget.data['title'],
                                  widget.data['des'],
                                  widget.data['companyname'],
                                  widget.data['salary'],
                                  provider.prefs.getString('phone'),
                                  rurl,
                                  context);

                              if (c) {
                                AppLayout.hideprogress(context);
                                AppLayout.showsnakbar(
                                    context, "Applied sucessfully");
                                Navigator.pop(context);
                              } else {
                                AppLayout.hideprogress(context);
                                AppLayout.showsnakbar(
                                    context, "Something went wrong");
                                Navigator.pop(context);
                              }
                            }
                          },
                          child: Container(
                            width: AppLayout.getwidth(context) * 0.4,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: col.pruple),
                            child: Center(
                                child: Text(
                              'Apply',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppLayout.getwidth(context) * 0.04,
                                  color: Colors.white),
                            )),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: CallPage(
                                  callID: snapshot.data[0]['addedby'] +
                                      snapshot.data[0]['appliedby'],
                                  userid: provider.prefs.getString('phone'),
                                  username: provider.prefs.getString('phone'),
                                ),
                                type: PageTransitionType.fade));
                      },
                      child: Container(
                        width: AppLayout.getwidth(context),
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: col.pruple),
                        child: Column(
                          children: [
                            Text(
                              'Already Applied',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppLayout.getwidth(context) * 0.04,
                                  color: Colors.white),
                            ),
                            Text(
                              "Interview Date : ${snapshot.data[0]['date']}",
                              style: GoogleFonts.roboto(
                                  fontSize: AppLayout.getwidth(context) * 0.04,
                                  color: Colors.white),
                            ),
                            Text(
                              'Interview Date : ${snapshot.data[0]['time']}',
                              style: GoogleFonts.roboto(
                                  fontSize: AppLayout.getwidth(context) * 0.04,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
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
            ),
          ],
        ),
      ),
    );
  }
}
