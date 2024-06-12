// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/tools/applayout.dart';


class text_view_helper extends StatelessWidget {
  text_view_helper(
      {super.key,
        required this.hint,
        required this.controller,
        this.background = Colors.white,
        this.hintcol = Colors.grey,
        this.textcolor = Colors.black,
        this.size = 14,
        this.bold = false,
        this.obsecure = false,
        this.textInputType = TextInputType.text,
        this.maxline = 1,
        this.maxlength = 10000,
        this.width = 0.8,
        this.padding = const EdgeInsetsDirectional.all(5),
        this.margin = const EdgeInsetsDirectional.all(5),
        this.icon = const Icon(Icons.person),
        this.showicon = false,
        this.onchange,
        this.readonly = false,
        this.formatter = const [],
        this.inputBorder});
  String hint;
  Color background, hintcol, textcolor;
  double size, width;
  bool bold, obsecure, showicon, readonly;
  int maxline, maxlength;
  TextInputType textInputType;
  TextEditingController controller;
  EdgeInsetsDirectional padding, margin;
  Icon icon;
  final Function(String)? onchange;
  InputBorder? inputBorder;
  List<TextInputFormatter> formatter;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: AppLayout.getwidth(context),
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: background),
        child: TextFormField(
          controller: controller,
          keyboardType: textInputType,
          readOnly: readonly,
          decoration: InputDecoration(
            border: inputBorder,
            counterText: "",
            hintStyle: GoogleFonts.poppins(color: hintcol, fontSize: 14),
            hintText: hint,
            prefixIcon: showicon ? icon : const SizedBox.shrink(),
          ),
          inputFormatters: formatter,
          obscureText: obsecure,
          maxLines: maxline,
          maxLength: maxlength,
          onChanged: onchange != null ? (value) => onchange!(value) : null,
          style: GoogleFonts.poppins(color: textcolor, fontSize: 14),
        ));
  }
}