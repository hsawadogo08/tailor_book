import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/models/personnel.model.dart';
import 'package:tailor_book/pages/personnels/add_personnel.page.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';
import 'package:tailor_book/widgets/shared/measure_item_infos.widget.dart';

class DetailPersonnelPage extends StatelessWidget {
  final Personnel personnel;
  const DetailPersonnelPage({
    super.key,
    required this.personnel,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    log("ID ${personnel.id}");
    return Scaffold(
      backgroundColor: kGris,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Détail d'un personnel",
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
            content: "${personnel.lastName}",
          ),
          MeasureItemInfos(
            title: "Prénom(s)",
            content: "${personnel.firstName}",
          ),
          MeasureItemInfos(
            title: "Date de création",
            content: DateFormat("dd/MM/yyyy à HH:mm:ss")
                .format(personnel.createdDate!),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: kWhite,
        height: 75,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: (width / 5) * 2,
              child: CustomButton(
                buttonText: "Supprimer",
                buttonSize: 16,
                pH: 24,
                buttonColor: secondaryColor,
                borderColor: secondaryColor,
                btnTextColor: kWhite,
                buttonFonction: () {},
              ),
            ),
            SizedBox(
              width: (width / 5) * 2,
              child: CustomButton(
                buttonText: "Modifier",
                buttonSize: 16,
                pH: 24,
                buttonColor: primaryColor,
                btnTextColor: kWhite,
                buttonFonction: () {
                  MaterialPageRoute route = MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) {
                      return AddPersonnelPage(
                        personnel: personnel,
                      );
                    },
                  );
                  Navigator.push(context, route).then((value) {
                    if (value == true) {
                      Navigator.pop(context, true);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
