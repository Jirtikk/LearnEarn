// ignore_for_file: must_be_immutable, camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/monoogshelper/mongoos.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../tools/appstate.dart';
import '../../../../tools/applayout.dart';
import '../../../../tools/col.dart';

class interview extends StatefulWidget {
  interview({super.key, required this.data});
  Map data;

  @override
  State<interview> createState() => _interviewState();
}

class _interviewState extends State<interview> {
  Key datekey = UniqueKey();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _time = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                abouduser(num: widget.data['appliedby'].toString()),
                const SizedBox(
                  height: 10,
                ),
                Text(widget.data['title'],
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: AppLayout.getwidth(context) * 0.05)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    widget.data['des'],
                    style: GoogleFonts.poppins(),
                  ),
                ),
                InkWell(
                    onTap: () async {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: pdfviewers(link: widget.data['resume']),
                              type: PageTransitionType.fade));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: AppLayout.getwidth(context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.1)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "View Resume",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    )),
                Container(
                  width: AppLayout.getwidth(context),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Date',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: AppLayout.getwidth(context) * 0.04),
                      ),
                      TextField(
                          controller: _date,
                          readOnly: true,
                          decoration: InputDecoration(
                              icon: const Icon(Icons.date_range),
                              hintStyle: GoogleFonts.roboto()),
                          onTap: () async {
                            DateTime? pickeddate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 2));
                            if (pickeddate != null) {
                              setState(() {
                                _date.text =
                                    DateFormat('dd-MM-yyyy').format(pickeddate);
                              });
                            }
                            provider.pass = _date.text;
                          }),
                    ],
                  ),
                ),
                Container(
                  width: AppLayout.getwidth(context),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Time',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: AppLayout.getwidth(context) * 0.04),
                      ),
                      TextField(
                          controller: _time,
                          readOnly: true,
                          decoration: InputDecoration(
                              icon: const Icon(Icons.date_range),
                              hintStyle: GoogleFonts.roboto()),
                          onTap: () async {
                            var pickedtime = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            if (pickedtime != null) {
                              setState(() {
                                _time.text += " " + pickedtime.format(context);
                              });
                            }
                            provider.confirm = _time.text;
                          }),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (provider.confirm == "" || provider.pass == "") {
                      AppLayout.showsnakbar(
                          context, 'Add Interview link and Date Time');
                    } else {
                      AppLayout.displayprogress(context);
                      await ApiHelper.updatejobapplied(
                          widget.data['addedby'].toString(),
                          widget.data['appliedby'].toString(),
                          "old",
                          _date.text,
                          _time.text,
                          context);
                      AppLayout.hideprogress(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: AppLayout.getwidth(context) * 0.5,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      'Hire',
                      style: GoogleFonts.poppins(
                          color: col.wh,
                          fontWeight: FontWeight.w600,
                          fontSize: AppLayout.getwidth(context) * 0.05),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class abouduser extends StatelessWidget {
  abouduser({Key? key, required this.num}) : super(key: key);
  String num;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: AppLayout.getwidth(context),
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.blue),
        child: FutureBuilder(
            future: getstdata(num, context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: col.wh,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data['img'].toString(),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data['name'].toString(),
                            style: GoogleFonts.poppins(
                              color: col.wh,
                              fontWeight: FontWeight.w600,
                              fontSize: AppLayout.getwidth(context) * 0.05,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.transgender,
                                color: col.wh,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                snapshot.data['gender'].toString(),
                                style: GoogleFonts.poppins(
                                  color: col.wh,
                                  fontSize: AppLayout.getwidth(context) * 0.035,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.school_outlined,
                                color: col.wh,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                snapshot.data['edu'].toString(),
                                style: GoogleFonts.poppins(
                                  color: col.wh,
                                  fontSize: AppLayout.getwidth(context) * 0.035,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return const Icon(Icons.error_outline);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  Future<Map> getstdata(String num, BuildContext context) async {
    Map sdata = await ApiHelper.getoneuserdata(context, num);
    return sdata;
  }
}

class pdfviewers extends StatelessWidget {
  pdfviewers({super.key, required this.link});
  String link;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Resume"),
        ),
        body: SfPdfViewer.network(link));
  }
}
