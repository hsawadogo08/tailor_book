import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/models/customer.model.dart';
import 'package:tailor_book/widgets/shared/measure_item_infos.widget.dart';

class DetailCustomerPage extends StatelessWidget {
  final Customer customer;
  const DetailCustomerPage({
    super.key,
    required this.customer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGris,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Détail d'un client",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          MeasureItemInfos(
            title: "Nom",
            content: "${customer.lastName}",
          ),
          MeasureItemInfos(
            title: "Prénom(s)",
            content: "${customer.lastName}",
          ),
          MeasureItemInfos(
            title: "Nombre de tenue",
            content: "${customer.pointFidelite}",
          ),
          MeasureItemInfos(
            title: "Date de création",
            content: DateFormat("dd/MM/yyyy à HH:mm:ss")
                .format(customer.createdDate!),
          ),
        ],
      ),
    );
  }
}
