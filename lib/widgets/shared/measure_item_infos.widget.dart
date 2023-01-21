import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';

// Commission Contraventions infos
class MeasureItemInfos extends StatelessWidget {
  final String title;
  final String content;
  final Color? titleColor;
  final Color? contentColor;

  const MeasureItemInfos({
    super.key,
    required this.title,
    this.content = '',
    this.titleColor = primaryColor,
    this.contentColor = kDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: kWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != ''
              ? Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                )
              : const SizedBox.shrink(),
          content != '' ? const SizedBox(height: 5) : const SizedBox.shrink(),
          content != ''
              ? Text(
                  content,
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    color: contentColor,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
