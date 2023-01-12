// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonFonction;
  final Color buttonColor;
  final double buttonSize;
  final Color borderColor;
  final Color btnTextColor;
  final double pH;
  final double pV;
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.buttonFonction,
    this.buttonColor = primaryColor,
    this.buttonSize = 24,
    this.borderColor = primaryColor,
    this.btnTextColor = primaryColor,
    this.pH = 70,
    this.pV = 15,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: (width / 10) * 9,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          padding: EdgeInsets.symmetric(horizontal: pH, vertical: pV),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(
            color: borderColor,
            width: 2,
          ),
        ),
        onPressed: buttonFonction,
        child: Text(
          buttonText,
          style: GoogleFonts.montserrat(
            fontSize: buttonSize,
            color: btnTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
