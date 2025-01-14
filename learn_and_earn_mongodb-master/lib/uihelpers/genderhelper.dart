// ignore_for_file: must_be_immutable, camel_case_types, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../tools/col.dart';
import '../tools/applayout.dart';
import '../tools/appstate.dart';

class genderhelper extends StatelessWidget {
  genderhelper({Key? key, required this.text2}) : super(key: key);
  String text2;

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);

    return AnimatedContainer(
      width: AppLayout.getwidth(context) * 0.4,
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: col.wh,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            width: 2, color: provider.cat == text2 ? col.pruple : col.gr),
      ),
      child: InkWell(
        onTap: () {
          provider.cat = text2;
          provider.notifyListeners();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text2,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: AppLayout.getwidth(context) * 0.05,
                color: col.pruple),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
