import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/monoogshelper/mongoos.dart';
import 'package:learn_and_earn_mongodb/tools/applayout.dart';
import 'package:learn_and_earn_mongodb/tools/col.dart';
import 'package:learn_and_earn_mongodb/tools/top.dart';
import 'package:intl/intl.dart';
import 'package:learn_and_earn_mongodb/uihelpers/button_helper.dart';
import 'package:learn_and_earn_mongodb/uihelpers/text_veiw_helper.dart';
import 'package:provider/provider.dart';

import '../../../tools/appstate.dart';

class addnewclass extends StatefulWidget {
  const addnewclass({super.key});

  @override
  State<addnewclass> createState() => _addnewclassState();
}

class _addnewclassState extends State<addnewclass> {
  TextEditingController name = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            top(title: "Add New Class"),
            text_view_helper(
              hint: "Enter Class Name",
              controller: name,
              showicon: true,
              icon: const Icon(Icons.add),
            ),
            text_view_helper(
              hint: "Enter Class Description",
              controller: des,
              showicon: true,
              icon: const Icon(Icons.add),
            ),
            InkWell(
              onTap: () async {
                DateTime? pickeddate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 2));
                if (pickeddate != null) {
                  setState(() {
                    date.text = DateFormat('dd-MM-yyyy').format(pickeddate);
                  });
                }
              },
              child: Container(
                width: AppLayout.getwidth(context),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  children: [
                    const Icon(Icons.date_range),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      date.text.isEmpty ? "Enter Class Date" : date.text,
                      style: GoogleFonts.roboto(),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                var pickedtime = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                if (pickedtime != null) {
                  setState(() {
                    time.text += " ${pickedtime.format(context)}";
                  });
                }
              },
              child: Container(
                width: AppLayout.getwidth(context),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  children: [
                    const Icon(Icons.date_range),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      time.text.isEmpty ? "Enter Class Time" : time.text,
                      style: GoogleFonts.roboto(),
                    ),
                  ],
                ),
              ),
            ),
            button_helper(
                onpress: () async {
                  if (name.text.isEmpty || des.text.isEmpty || date.text.isEmpty || time.text.isEmpty) {
                    AppLayout.showsnakbar(context, "Fill all fields");
                  } else {
                    bool status = await ApiHelper.registerclass(name.text,
                        des.text, date.text, time.text, provider.prefs.getString("phone"), context);
                    if (status) {
                      Navigator.pop(context);
                    }
                  }
                },
                color: col.pruple,
                width: AppLayout.getwidth(context),
                child: Center(
                    child: Text(
                  "Add Class",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, color: col.wh, fontSize: 24),
                )))
          ],
        ),
      ),
    );
  }
}
