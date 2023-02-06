import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/models/personnel.model.dart';

class PersonnelItem extends StatelessWidget {
  final Personnel personnel;
  const PersonnelItem({
    super.key,
    required this.personnel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: primaryColor,
            blurRadius: 2,
            offset: Offset(2, 2), // Shadow position
          ),
          BoxShadow(
            color: primaryColor,
            blurRadius: 2,
            offset: Offset(-2, -2), // Shadow position
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: Icon(
                FontAwesomeIcons.userGear,
                color: primaryColor,
                size: 40,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${personnel.lastName}",
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "${personnel.firstName}",
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Tél : ${personnel.phoneNumber}",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                // Row(
                //   children: [
                //     Text(
                //       "Tenue :",
                //       style: GoogleFonts.montserrat(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w700,
                //         color: primaryColor,
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 4,
                //     ),
                //     Text(
                //       "(${personnel.pendingNumber})",
                //       style: GoogleFonts.montserrat(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w700,
                //         color: kRed,
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 4,
                //     ),
                //     Text(
                //       "(${personnel.progressNumber})",
                //       style: GoogleFonts.montserrat(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w700,
                //         color: tertiaryColor,
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 4,
                //     ),
                //     Text(
                //       "(${personnel.closedNumber})",
                //       style: GoogleFonts.montserrat(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w700,
                //         color: kGreen,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          const Center(
            child: Icon(
              Icons.arrow_forward_ios,
              color: secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
