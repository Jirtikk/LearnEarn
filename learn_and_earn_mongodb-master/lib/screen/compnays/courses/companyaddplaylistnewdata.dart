import 'dart:io';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../firenasedatabasehelper/firebaseuploadhelper.dart';
import '../../../monoogshelper/mongoos.dart';
import '../../../tools/applayout.dart';
import '../../../tools/appstate.dart';
import '../../../uihelpers/button_helper.dart';
import '../../../uihelpers/text_veiw_helper.dart';

class companyaddplaylistnewdata extends StatefulWidget {
  companyaddplaylistnewdata({super.key, required this.courseid});
  String courseid;

  @override
  State<companyaddplaylistnewdata> createState() => _companyaddplaylistnewdataState();
}

class _companyaddplaylistnewdataState extends State<companyaddplaylistnewdata> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController vid = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController question = TextEditingController();
  TextEditingController answer01 = TextEditingController();
  TextEditingController answer02 = TextEditingController();
  TextEditingController answer03 = TextEditingController();
  TextEditingController answer04 = TextEditingController();
  TextEditingController answer05 = TextEditingController();

  int tag = 0;
  int subject = 0;
  List<String> options = ['A', 'B', 'C', 'D', 'E'];

  List qa = [];

  File? image;

  Future<void> pic() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Add New Data',style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  width: AppLayout.getwidth(context),
                  height: 280,
                  margin: const EdgeInsets.only(left: 20,top: 20, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                Container(
                  width: AppLayout.getwidth(context),
                  height: 280,
                  margin: const EdgeInsets.only(left: 10,top: 10, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ]
                  ),
                  child: InkWell(
                    onTap: ()=>pic(),
                    child: image == null ?
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add,size: 80,),
                        Text("Click here to add course picture",style: GoogleFonts.roboto(),),
                      ],
                    ):
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        image!,
                        width: AppLayout.getwidth(context),
                        fit: BoxFit.cover,
                        height: 280,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.grey)),
              child: text_view_helper(hint: "Enter Video Name", controller: name,
                inputBorder: InputBorder.none,
                padding: const EdgeInsetsDirectional.all(0),
                margin: const EdgeInsetsDirectional.all(0),
                showicon: true,icon: const Icon(Icons.check_box_outline_blank_rounded),),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.grey)),
              child: text_view_helper(hint: "Enter Video Description", controller: description,
                inputBorder: InputBorder.none,
                padding: const EdgeInsetsDirectional.all(0),
                margin: const EdgeInsetsDirectional.all(0),
                showicon: true,icon: const Icon(Icons.check_box_outline_blank_rounded),),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.grey)),
              child: text_view_helper(hint: "Enter Video Id", controller: vid,
                inputBorder: InputBorder.none,
                padding: const EdgeInsetsDirectional.all(0),
                margin: const EdgeInsetsDirectional.all(0),
                showicon: true,icon: const Icon(Icons.check_box_outline_blank_rounded),),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text("Enter Details For Quiz",style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20),),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.grey)),
              child: text_view_helper(
                hint: "Enter Duration in minutes",
                width: AppLayout.getwidth(context),
                controller: duration,
                textInputType: TextInputType.number,
                formatter: [
                  FilteringTextInputFormatter.allow(AppLayout.getRegExpint())
                ],
                showicon: true,
                padding: const EdgeInsetsDirectional.all(0),
                margin: const EdgeInsetsDirectional.all(0),
                inputBorder: InputBorder.none,
                icon: const Icon(
                  Icons.punch_clock_outlined,
                  color: Colors.black,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              child: Text("Question No. ${qa.length}",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14),),
            ),
            texthelper(
                question,
                "Enter Question No ${qa.length}",
                Icons.question_mark,
                1),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 10,),
                Container(
                  height: 350,
                  width: 1,
                  color: Colors.amber,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      texthelper(answer01, "Enter Answer 01",
                          Icons.question_answer_outlined, 0.4),
                      texthelper(answer02, "Enter Answer 02",
                          Icons.question_answer_outlined, 0.4),
                      texthelper(answer03, "Enter Answer 03",
                          Icons.question_answer_outlined, 0.4),
                      texthelper(answer04, "Enter Answer 04",
                          Icons.question_answer_outlined, 0.4),
                      texthelper(answer05, "Enter Answer 05",
                          Icons.question_answer_outlined, 0.4),
                    ],
                  ),
                ),
              ],
            ),
            ChipsChoice<int>.single(
              value: tag,
              onChanged: (val) {
                tag = val;
                setState(() {});
              },
              choiceStyle: const C2ChipStyle(
                foregroundColor: Colors.black,
              ),
              choiceItems: C2Choice.listFrom<int, String>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: button_helper(
                  onpress: () => addtolist(context),
                  color: Colors.amber,
                  width: AppLayout.getwidth(context)+0.4,
                  raduis: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 10,),
                      Text("Add Another",
                          style: GoogleFonts.poppins(
                           fontSize:12
                          )),
                    ],
                  )),
            ),
            const SizedBox(height: 10,),
            Column(
              children: qa.map((e) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade50,
                  ),
                  child: Column(
                    children: [
                      qlist('q', e['q'], e['correct'], context),
                      Row(
                        children: [
                          const SizedBox(width: 20,),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                qlist("A", e['a1'], e['correct'], context),
                                qlist("B", e['a2'], e['correct'], context),
                                qlist("C", e['a3'], e['correct'], context),
                                qlist("D", e['a4'], e['correct'], context),
                                qlist("E", e['a5'], e['correct'], context),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          button_helper(
                              onpress: () => update(e),
                              color: Colors.amber.shade100,
                              width: AppLayout.getwidth(context)*0.3,
                              child: Center(
                                child: Text("update",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                    )),
                              )),
                          button_helper(
                              onpress: () => delete(e['q']),
                              color: Colors.amber.shade100,
                              width: AppLayout.getwidth(context)*0.3,
                              child: Center(
                                child: Text("delete",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                    )),
                              ))
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
            button_helper(
                onpress: () => createlist(context,provider),
                color: Colors.amber,
                width: AppLayout.getwidth(context),
                raduis: 10,
                child: Center(
                  child: Text("Create Quiz",
                      style: GoogleFonts.poppins(
                      fontSize: 20,
                        fontWeight: FontWeight.bold
                      )),
                )),
          ],
        ),
      ),
    );
  }

  Widget texthelper(TextEditingController controller, String title,
      IconData iconData, double width) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.grey.shade500)),
      child: text_view_helper(
        hint: title,
        width: width,
        controller: controller,
        showicon: true,
        padding: const EdgeInsetsDirectional.all(0),
        margin: const EdgeInsetsDirectional.all(0),
        inputBorder: InputBorder.none,
        icon: Icon(
          iconData,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget qlist(String a, String b, String c, BuildContext context) {
    return b != ''
        ? Row(
      children: [
        Text(a.toUpperCase(),
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          )
        ),
        const SizedBox(width: 10,),
        a == c
            ? const Row(
          children: [
            Icon(
              Icons.check,
              color: Colors.black,
            ),
            SizedBox(width: 10,)
          ],
        )
            : const SizedBox.shrink(),
        Expanded(
          child: Text(b,
              style: GoogleFonts.poppins(
                fontSize: 14,
              )),
        ),
      ],
    )
        : const SizedBox.shrink();
  }

  void addtolist(BuildContext context) {
    if (question.text.isEmpty) {
      AppLayout.showsnakbar(context, "Add a Question");
    } else if (answer01.text.isEmpty || answer02.text.isEmpty) {
      AppLayout.showsnakbar(context, "Add At least first 2 answers");
    } else if ((answer03.text.isEmpty && tag == 2) ||
        (answer04.text.isEmpty && tag == 3) ||
        (answer05.text.isEmpty && tag == 4)) {
      AppLayout.showsnakbar(context, "correct option chosen with filled answer");
    } else {
      qa.add({
        'q': question.text,
        'a1': answer01.text,
        'a2': answer02.text,
        'a3': answer03.text,
        'a4': answer04.text,
        'a5': answer05.text,
        'correct': options[tag]
      });
      clearqa();
    }
  }

  void update(Map e) {
    question.text = e['q'];
    answer01.text = e['a1'];
    answer02.text = e['a2'];
    answer03.text = e['a3'];
    answer04.text = e['a4'];
    answer05.text = e['a5'];
    tag = options.indexOf(e['correct']);
    delete(e['q']);
    setState(() {});
  }

  void delete(String q) {
    for (int i = 0; i < qa.length; i++) {
      if (qa[i]['q'] == q) {
        qa.removeAt(i);
        setState(() {});
        break;
      }
    }
  }

  Future<void> createlist(BuildContext context, AppState provider) async {
    if (name.text.isEmpty ||
        description.text.isEmpty ||
        duration.text.isEmpty || vid.text.isEmpty) {
      AppLayout.showsnakbar(context, "Fill all details");
    } else if (qa.isEmpty) {
      AppLayout.showsnakbar(context, "Enter at least one question");
    } else if (image == null) {
      AppLayout.showsnakbar(context, "Add a thumbnail");
    } else {
      AppLayout.displayprogress(context);
      var data = await ApiHelper.registerquiz(widget.courseid, duration.text, qa, context);
      if (data['status']) {
        String url = await FirebaseHelper.uploadFile(image, provider, provider.prefs.getString("phone"));
        var data2 = await ApiHelper.registerplaylist(widget.courseid, url,
            description.text, name.text, vid.text, data['id'], context);
        if (data2['status']) {
          AppLayout.hideprogress(context);
          Navigator.pop(context);
          AppLayout.showsnakbar(context, data['sucess']);
        } else {
          AppLayout.hideprogress(context);
          AppLayout.showsnakbar(context, data['sucess']);
        }
      } else {
        AppLayout.hideprogress(context);
        AppLayout.showsnakbar(context, data['sucess']);
      }
    }
  }

  void clearqa() {
    question.clear();
    answer01.clear();
    answer02.clear();
    answer03.clear();
    answer04.clear();
    answer05.clear();
    tag = 0;
    setState(() {});
  }
}
