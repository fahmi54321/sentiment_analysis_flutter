import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleSentiment extends StatelessWidget {
  const TitleSentiment({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Text Analyzer',
      style: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
