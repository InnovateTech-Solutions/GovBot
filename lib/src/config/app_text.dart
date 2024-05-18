import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

headerText(String title) {
  return Text(
    title,
    style: GoogleFonts.poppins(
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
  );
}

secText(String title) {
  return Text(
    title,
    style: GoogleFonts.poppins(
        textStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
    )),
  );
}

thirdText(String title) {
  return Text(
    title,
    style: GoogleFonts.poppins(
        textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    )),
  );
}
