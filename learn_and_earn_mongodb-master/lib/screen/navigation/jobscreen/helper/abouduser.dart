// ignore_for_file: must_be_immutable, camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../tools/col.dart';
import '../../../../tools/applayout.dart';
import '../../../../tools/appstate.dart';

class abouduser extends StatelessWidget {
  abouduser({Key? key, required this.num}) : super(key: key);
  String num;

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);

    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: AppLayout.getwidth(context),
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.blue),
        child: Row(
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
                  imageUrl: provider.prefs.getString('img'),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                    provider.prefs.getString('name'),
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
                        provider.prefs.getString('gender'),
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
                        provider.prefs.getString('edu'),
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
        ));
  }
}
