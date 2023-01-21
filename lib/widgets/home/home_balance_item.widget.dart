import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';

class HomeBalanceItem extends StatelessWidget {
  final double? width;
  final Color backgroundColor;
  final String balanceLabel;
  final String balanceValue;
  const HomeBalanceItem({
    super.key,
    this.width,
    this.backgroundColor = primaryColor,
    this.balanceLabel = "",
    this.balanceValue = "",
  });

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double currentWidth = width == null ? (mediaQueryWidth / 7) * 3 : width!;
    return Container(
      width: currentWidth,
      height: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            balanceLabel,
            textAlign: TextAlign.start,
            style: GoogleFonts.exo2(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: kWhite,
            ),
          ),
          Text(
            balanceValue,
            textAlign: TextAlign.start,
            style: GoogleFonts.exo2(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kWhite,
            ),
          ),
        ],
      ),
    );
  }
}
