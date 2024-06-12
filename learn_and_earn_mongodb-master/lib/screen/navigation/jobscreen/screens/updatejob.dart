import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/tools/col.dart';
import 'package:provider/provider.dart';

import '../../../../monoogshelper/mongoos.dart';
import '../../../../tools/applayout.dart';
import '../../../../tools/appstate.dart';
import '../../../../tools/top.dart';

class updatejob extends StatefulWidget {
  updatejob({super.key, required this.data});
  Map data;

  @override
  State<updatejob> createState() => _updatejobState();
}

class _updatejobState extends State<updatejob> {
  bool g = true;

  TextEditingController title = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController salary = TextEditingController();

  @override
  void initState() {
    if (g) {
      title.text = widget.data['title'];
      des.text = widget.data['des'];
      salary.text = widget.data['salary'];
      g = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              top(title: "Update Job"),
              Container(
                width: AppLayout.getwidth(context),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Job Title',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: AppLayout.getwidth(context) * 0.04),
                    ),
                    TextFormField(
                      controller: title,
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.roboto(),
                          hintText: "Job Title"),
                      style: GoogleFonts.roboto(),
                    )
                  ],
                ),
              ),
              Container(
                width: AppLayout.getwidth(context),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Description',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: AppLayout.getwidth(context) * 0.04),
                    ),
                    TextFormField(
                      maxLines: null,
                      controller: des,
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.roboto(),
                          hintText: "Description"),
                      style: GoogleFonts.roboto(),
                    )
                  ],
                ),
              ),
              Container(
                width: AppLayout.getwidth(context),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Salary',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: AppLayout.getwidth(context) * 0.04),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: salary,
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.roboto(), hintText: "Salary"),
                      style: GoogleFonts.roboto(),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  if (title.text.isEmpty ||
                      des.text.isEmpty ||
                      salary.text.isEmpty) {
                    AppLayout.showsnakbar(context, "Fill all fields");
                  } else {
                    AppLayout.displayprogress(context);
                    bool check = await ApiHelper.updatejob(widget.data['_id'],
                        title.text, des.text, salary.text, context);
                    if (check) {
                      AppLayout.hideprogress(context);
                      AppLayout.showsnakbar(context, "Added");
                      provider.notifyListeners();
                      Navigator.pop(context);
                    } else {
                      AppLayout.hideprogress(context);
                      AppLayout.showsnakbar(context, "Try again later");
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
                    'Update',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: AppLayout.getwidth(context) * 0.04,
                        color: Colors.white),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
