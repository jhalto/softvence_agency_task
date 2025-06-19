
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle globalTextStyle({
  double fs = 14,
  FontWeight fw = FontWeight.normal,
  double lh = 1.5,
  TextAlign ta = TextAlign.center,
  Color clr = Colors.white
  

}){
  return GoogleFonts.oxygen(
    fontSize: fs,
    fontWeight: fw,
    height: lh,
    color: clr,
  
  );
}
TextStyle globalPoppinStyle({
  
  double fs = 14,
  FontWeight fw = FontWeight.normal,
  double lh = 1.2,
  TextAlign ta = TextAlign.center,
  Color clr = Colors.white,
  List<Shadow>? shadows,
  

}){
  return GoogleFonts.poppins(
    fontSize: fs,
    fontWeight: fw,
    height: lh,
    color: clr,
    shadows: shadows
  );
}