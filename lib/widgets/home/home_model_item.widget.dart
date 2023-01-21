import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';

class HomeModelItem extends StatelessWidget {
  final Color borderColor;
  final Color iconColor;
  final IconData icon;
  final String modelTitle;
  final String modelNumber;
  const HomeModelItem({
    super.key,
    this.borderColor = kGris,
    this.iconColor = primaryColor,
    required this.icon,
    this.modelTitle = "",
    this.modelNumber = "0",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: borderColor,
            blurRadius: 2,
            offset: const Offset(2, 2), // Shadow position
          ),
          BoxShadow(
            color: borderColor,
            blurRadius: 2,
            offset: const Offset(-2, -2), // Shadow position
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 35,
          ),
          Text(
            modelTitle,
            style: GoogleFonts.exo2(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
          Text(
            modelNumber,
            style: GoogleFonts.exo2(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
