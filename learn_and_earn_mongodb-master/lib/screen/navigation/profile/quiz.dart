// ignore_for_file: must_be_immutable, camel_case_types, use_build_context_synchronously

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/tools/applayout.dart';
import 'package:learn_and_earn_mongodb/tools/col.dart';

import '../../../monoogshelper/mongoos.dart';

class quizsolve extends StatefulWidget {
  quizsolve(
      {super.key,
      required this.couseid,
      required this.number,
      required this.cdata});
  String couseid, number;
  Map cdata;

  @override
  State<quizsolve> createState() => _quizsolveState();
}

class _quizsolveState extends State<quizsolve> {
  int current = 0;
  int correct = 0;
  List qa = [];
  List<String> cqa = [];
  List option = [];
  bool check = true;

  void first(List q) {
    qa = q;
    adddata(qa[current]);
  }

  void adddata(Map data) {
    cqa.clear();
    option.clear();
    if (data['a1'] != "") {
      cqa.add(data['a1']);
      option.add("A");
    }
    if (data['a2'] != "") {
      cqa.add(data['a2']);
      option.add("B");
    }
    if (data['a3'] != "") {
      cqa.add(data['a3']);
      option.add("C");
    }
    if (data['a4'] != "") {
      cqa.add(data['a4']);
      option.add("D");
    }
    if (data['a5'] != "") {
      cqa.add(data['a5']);
      option.add("E");
    }
  }

  Future<void> updateindex(String value, BuildContext context) async {
    if (value == qa[current]['correct']) {
      correct = correct + 1;
    }
    if (current < qa.length - 1) {
      check = false;
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {});
      await Future.delayed(const Duration(seconds: 1));
      check = true;
      current = current + 1;
      adddata(qa[current]);
      setState(() {});
    } else {
      back(context);
    }
  }

  Future<void> back(BuildContext context) async {
    check = false;
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 500));
    if (correct / qa.length > 0.7) {
      bool checkf = await ApiHelper.addtoqlist(
          context, widget.number, widget.couseid, widget.cdata['qid']);
      if (checkf) {
        AppLayout.showsnakbar(context, "Watch next video");
        Navigator.pop(context);
      } else {
        AppLayout.showsnakbar(context, "try again later");
        Navigator.pop(context);
      }
    } else {
      AppLayout.showsnakbar(context, "you are fail give quiz again");
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: FutureBuilder(
                future: ApiHelper.getonequizdata(widget.cdata['qid']),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    first(snapshot.data['questionanswer']);
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: FAProgressBar(
                                  currentValue: current.toDouble() + 1,
                                  displayText: "",
                                  maxValue: qa.length.toDouble() + 1,
                                  displayTextStyle: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  progressColor: col.pruple,
                                ),
                              ),
                              TimerCountdown(
                                format: CountDownTimerFormat.minutesSeconds,
                                enableDescriptions: false,
                                spacerWidth: 3,
                                timeTextStyle:
                                    GoogleFonts.montserrat(color: Colors.black),
                                endTime: DateTime.now().add(
                                  Duration(
                                    minutes:
                                        int.parse(snapshot.data['duration']),
                                    seconds: 0,
                                  ),
                                ),
                                onEnd: () => back(context),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          check
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      qa[current]['q'].toString().toUpperCase(),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: col.pruple),
                                      textAlign: TextAlign.start,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomRadioButton(
                                          elevation: 5,
                                          unSelectedBorderColor: col.pruple,
                                          selectedBorderColor: col.pruple,
                                          horizontal: true,
                                          width: AppLayout.getwidth(context),
                                          unSelectedColor: Colors.white,
                                          buttonLables: cqa,
                                          buttonValues: option,
                                          buttonTextStyle: ButtonTextStyle(
                                              selectedColor: Colors.white,
                                              unSelectedColor: Colors.black,
                                              selectedTextStyle:
                                                  GoogleFonts.poppins(
                                                      fontSize:
                                                          AppLayout.getwidth(
                                                                  context) *
                                                              0.05),
                                              textStyle: GoogleFonts.poppins(
                                                  fontSize: AppLayout
                                                          .getwidth(context) *
                                                      0.04)),
                                          radioButtonValue: (value) =>
                                              updateindex(value, context),
                                          selectedColor: col.pruple),
                                    ),
                                  ],
                                )
                              : Expanded(
                                  child:
                                      AppLayout.displaysimpleprogress(context)),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.error_outline);
                  } else {
                    return AppLayout.displaysimpleprogress(context);
                  }
                }),
          )),
    );
  }
}
