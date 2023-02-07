// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';

class AProposInfos extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  const AProposInfos({
    Key? key,
    required this.icon,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(20, 16, 10, 0),
      decoration: const BoxDecoration(
        color: kWhite,
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              icon,
              color: kWhite,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    content,
                    style: GoogleFonts.montserrat(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
