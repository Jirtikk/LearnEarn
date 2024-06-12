import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/tools/top.dart';

import 'applayout.dart';

class CertificatePainter extends StatelessWidget {
  final String? studentName;
  final String? courseName;

  const CertificatePainter({
    super.key,
    required this.studentName,
    required this.courseName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              top(title: "Certificate"),
              SizedBox(
                height: AppLayout.getheight(context) * 0.1,
              ),
              Stack(
                children: [
                  SizedBox(
                    height: 270,
                    child: Image.asset(
                      'assets/certificate_template.png',
                      fit: BoxFit.cover,
                      width: 800,
                      height: 1200,
                    ),
                  ),
                  const Positioned(
                    top: 120,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'This certificate is proudly presented for honorable achievement to',
                        style: TextStyle(
                            fontFamily: 'garet',
                            fontSize: 8,
                            color: Color(0xFF7C7C7C)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        '$studentName',
                        style: GoogleFonts.greatVibes(
                          fontSize: 20,
                          color: const Color(0xFF1F2B5B),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 170,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'For successfully completing the course "$courseName"',
                        style: const TextStyle(
                            fontFamily: 'garet',
                            fontSize: 8,
                            color: Color(0xFF7C7C7C)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
