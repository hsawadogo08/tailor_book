import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/models/customer.model.dart';

class CustomerItem extends StatelessWidget {
  final Customer customer;
  const CustomerItem({
    super.key,
    required this.customer,
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
                FontAwesomeIcons.userTie,
                color: primaryColor,
                size: 40,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${customer.lastName}",
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
                      "${customer.firstName} - ",
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "(${customer.pointFidelite})",
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Tél : ${customer.phoneNumber}",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const Center(
            child: Icon(
              Icons.arrow_forward_ios,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
