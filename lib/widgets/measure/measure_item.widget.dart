import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tailor_book/config/amount_formater.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/models/measurement.model.dart';

class MeasureItem extends StatelessWidget {
  final Measurement measurement;
  const MeasureItem({
    super.key,
    required this.measurement,
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${measurement.customerName}",
                  style: GoogleFonts.exo2(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Type de tenue : ${measurement.model}",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: primaryColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Montant : ${AmountFormater.format(measurement.totalPrice!)}",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                      ),
                    ),
                    Text(
                      "|",
                      style: GoogleFonts.exo2(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Avance : ${AmountFormater.format(measurement.advancedPrice!)}",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kGreen,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                ),
                Text(
                  "Couturier : ${measurement.couturierName == '' ? 'Non Affectée' : measurement.couturierName}",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Rendez-vous : ${DateFormat("dd/MM/yyyy").format(measurement.removedDate!)}",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: getStatusBgColor(),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  width: double.infinity,
                  child: Text(
                    getStatusLibelle(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kWhite,
                    ),
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

  Color getStatusBgColor() {
    switch (measurement.status) {
      case "PENDING":
        return secondaryColor;
      case "PROGRESS":
        return tertiaryColor;
      case "CLOSED":
        return kGreen;
      default:
        return tertiaryColor;
    }
  }

  String getStatusLibelle() {
    switch (measurement.status) {
      case "PENDING":
        return "Couture en attente";
      case "PROGRESS":
        return "Couture en cours";
      case "CLOSED":
        return "Couture terminée";
      default:
        return "Couture en cours";
    }
  }
}
