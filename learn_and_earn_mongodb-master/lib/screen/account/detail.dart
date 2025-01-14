// ignore_for_file: must_be_immutable, camel_case_types, invalid_use_of_visible_for_testing_member, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, duplicate_ignore, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_and_earn_mongodb/monoogshelper/mongoos.dart';
import 'package:learn_and_earn_mongodb/screen/compnays/company.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../firenasedatabasehelper/firebaseuploadhelper.dart';
import '../../tools/applayout.dart';
import '../../tools/appstate.dart';
import '../../tools/col.dart';
import '../../uihelpers/genderhelper.dart';
import '../homepage.dart';
import '../instructor/instructorhome.dart';

class detail extends StatelessWidget {
  detail({Key? key, required this.phone, required this.pass}) : super(key: key);
  String phone, pass;

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  'Enter Basic Details',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: AppLayout.getwidth(context) * 0.1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Select Image',
                        style: GoogleFonts.roboto(
                            fontSize: AppLayout.getwidth(context) * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer<AppState>(builder: (context, myprovider, _) {
                            return myprovider.image == null
                                ? const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/avatar.jpg'),
                                    radius: 80.0,
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        FileImage(myprovider.image!),
                                    radius: 80.0,
                                  );
                          }),
                          InkWell(
                            onTap: () async {
                              final pickedFile = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (pickedFile != null) {
                                AppLayout.displayprogress(context);
                                provider.image = File(pickedFile.path);
                                provider.notifyListeners();

                                String url = await FirebaseHelper.uploadFile(
                                    provider.image, provider, phone);

                                provider.database
                                    .child('user')
                                    .child(phone)
                                    .child('img')
                                    .set(url);
                                provider.prefs.setString('img', url);
                                AppLayout.hideprogress(context);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: col.wh,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2, color: col.pruple)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Upload Image',
                                    style: GoogleFonts.roboto(
                                        fontSize:
                                            AppLayout.getwidth(context) * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    provider.prefs.getString('useras') == 'Company' ?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Company Bio',
                                style: GoogleFonts.roboto(
                                    fontSize: AppLayout.getwidth(context) * 0.05,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 68,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: col.gr),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        CupertinoIcons.square_stack_3d_up,
                                        color: col.pruple,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5)),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: col.gr),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          style: GoogleFonts.roboto(),
                                          onChanged: (value) {
                                            provider.edu = value;
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'Enter your company bio, projects, skills, etc.',
                                              hintStyle: GoogleFonts.roboto(),
                                              border: InputBorder.none),
                                          // keyboardType: ,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ):
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Specialisation',
                            style: GoogleFonts.roboto(
                                fontSize: AppLayout.getwidth(context) * 0.05,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Container(
                                height: 68,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: col.gr),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    CupertinoIcons.square_stack_3d_up,
                                    color: col.pruple,
                                  ),
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5)),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: col.gr),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      style: GoogleFonts.roboto(),
                                      onChanged: (value) {
                                        provider.edu = value;
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Enter your Specialisation',
                                          hintStyle: GoogleFonts.roboto(),
                                          border: InputBorder.none),
                                      // keyboardType: ,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Select Gender',
                            style: GoogleFonts.roboto(
                                fontSize: AppLayout.getwidth(context) * 0.05,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              genderhelper(
                                text2: 'Male',
                              ),
                              genderhelper(
                                text2: 'Female',
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () {
                      if( provider.prefs.getString('useras') == 'Company' ){

                        if (provider.edu == '') {
                          AppLayout.showsnakbar(
                              context, 'Please add Latest education');
                        } else if(!provider.prefs.containsKey('img')){
                          AppLayout.showsnakbar(context, 'Add a pic');
                        } else {
                          AppLayout.displayprogress(context);

                          provider.prefs.setString('edu', provider.edu);
                          var h = ApiHelper.registration(
                              provider.prefs.getString('phone'),
                              provider.prefs.getString('edu'),
                              '',
                              provider.prefs.getString('img'),
                              provider.prefs.getString('name'),
                              pass,
                              provider.prefs.getString('useras'),
                              context);

                          h.then((value) => {
                            if (value)
                              {
                                provider.prefs.setString("auth","true"),
                                AppLayout.hideprogress(context),
                                provider.cat = '',
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: const company(),
                                        type: PageTransitionType.fade))
                              }
                          });

                        }

                      } else {

                        if (provider.cat == '') {
                          AppLayout.showsnakbar(
                              context, 'Please Select a gender');
                        } else if (provider.edu == '') {
                          AppLayout.showsnakbar(
                              context, 'Please add Latest education');
                        } else if(!provider.prefs.containsKey('img')){
                          AppLayout.showsnakbar(context, 'Add a pic');
                        }else {
                          AppLayout.displayprogress(context);

                          provider.prefs.setString('edu', provider.edu);
                          provider.prefs.setString('gender', provider.cat);

                          var h = ApiHelper.registration(
                              provider.prefs.getString('phone'),
                              provider.prefs.getString('edu'),
                              provider.prefs.getString('gender'),
                              provider.prefs.getString('img'),
                              provider.prefs.getString('name'),
                              pass,
                              provider.prefs.getString('useras'),
                              context);

                          h.then((value) => {
                            if (value)
                              {
                                provider.prefs.setString("auth","true"),
                                AppLayout.hideprogress(context),
                                provider.cat = '',
                                if (provider.prefs.getString('useras') == 'Instructor'){
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: const instructorhome(),
                                          type: PageTransitionType.fade))
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: const Homepage(),
                                          type: PageTransitionType.fade))
                                }
                              }
                          });
                        }

                      }
                    },
                    child: Container(
                      height: 50,
                      width: AppLayout.getwidth(context) * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: col.pruple),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Next',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                color: col.wh,
                                fontSize: AppLayout.getwidth(context) * 0.05),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
