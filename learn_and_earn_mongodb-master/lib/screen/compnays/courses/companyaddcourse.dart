import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_and_earn_mongodb/firenasedatabasehelper/firebaseuploadhelper.dart';
import 'package:learn_and_earn_mongodb/monoogshelper/mongoos.dart';
import 'package:learn_and_earn_mongodb/tools/applayout.dart';
import 'package:learn_and_earn_mongodb/uihelpers/text_veiw_helper.dart';
import 'package:provider/provider.dart';

import '../../../tools/appstate.dart';

class companyaddcourse extends StatefulWidget {
  const companyaddcourse({super.key});

  @override
  State<companyaddcourse> createState() => _companyaddcourseState();
}

class _companyaddcourseState extends State<companyaddcourse> {

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
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
      backgroundColor: Colors.amber.shade50,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Add Course',style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold),),
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
              width: AppLayout.getwidth(context),
              margin: const EdgeInsets.all(10),
              padding:const EdgeInsets.only(left: 0,top: 0, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  text_view_helper(hint: "Enter Course Name", controller: name,
                    margin: const EdgeInsetsDirectional.all(0),
                    showicon: true,icon: const Icon(Icons.check_box_outline_blank_rounded),),
                ],
              ),
            ),
            Container(
              width: AppLayout.getwidth(context),
              margin: const EdgeInsets.all(10),
              padding:const EdgeInsets.only(left: 0,top: 0, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  text_view_helper(hint: "Enter Course Description", controller: description,
                    margin: const EdgeInsetsDirectional.all(0),
                    showicon: true,icon: const Icon(Icons.check_box_outline_blank_rounded),),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                if(name.text != "" && description.text != "" && image != null){
                  AppLayout.displayprogress(context);
                  String url = await FirebaseHelper.uploadFile(image,
                      provider, provider.prefs.getString("phone")!);
                  bool d = await ApiHelper.registercourse(url, description.text, name.text,
                      provider.prefs.getString("phone")!, provider.prefs.getString('useras'), context);
                  AppLayout.hideprogress(context);
                  Navigator.pop(context);
                } else {
                  AppLayout.showsnakbar(context, "Add All Fields");
                }
              },
              child: Container(
                width: AppLayout.getwidth(context),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text("Add Course",
                  style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
