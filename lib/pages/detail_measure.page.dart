import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tailor_book/config/amount_formater.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/models/measurement.model.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';
import 'package:tailor_book/widgets/shared/measure_item_infos.widget.dart';

class DetailMeasurePage extends StatelessWidget {
  final Measurement measurement;
  const DetailMeasurePage({
    super.key,
    required this.measurement,
  });

  @override
  Widget build(BuildContext context) {
    log("${measurement.photoModelUrl}");
    log("${measurement.photoTissuUrl}");
    double width = MediaQuery.of(context).size.width;
    double measureHeight =
        100 * double.parse("${measurement.measures!.length}");
    return Scaffold(
      backgroundColor: kGris,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Détail d'une mesure",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.delete,
              color: secondaryColor,
              size: 30,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: (width / 5) * 2,
              child: CustomButton(
                buttonText: "Modifier",
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
                buttonText: "Commencer",
                buttonSize: 16,
                pH: 24,
                buttonColor: kGreen,
                borderColor: kGreen,
                btnTextColor: kWhite,
                buttonFonction: () {},
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: getStatusBgColor(),
                borderRadius: BorderRadius.circular(4),
              ),
              width: double.infinity,
              child: Text(
                getStatusLibelle(),
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kWhite,
                ),
              ),
            ),
            MeasureItemInfos(
              title: "Client",
              content: "${measurement.customerName}",
            ),
            MeasureItemInfos(
              title: "Prix total",
              content: AmountFormater.format(measurement.totalPrice!),
            ),
            MeasureItemInfos(
              title: "Montant de l'avance",
              content: AmountFormater.format(measurement.advancedPrice!),
            ),
            MeasureItemInfos(
              title: "Date de remise",
              content: DateFormat("dd/MM/yyyy à HH:mm:ss")
                  .format(measurement.createdDate!),
            ),
            MeasureItemInfos(
              title: "Date du rendez vous",
              content:
                  DateFormat("dd/MM/yyyy").format(measurement.removedDate!),
            ),
            const MeasureItemInfos(
              title: "Mesures de la tenue",
              titleColor: secondaryColor,
            ),
            MeasureItemInfos(
              title: "Type de tenue",
              content: "${measurement.model}",
            ),
            SizedBox(
              height: measureHeight,
              child: ListView.builder(
                itemCount: measurement.measures?.length,
                itemBuilder: (BuildContext context, int index) {
                  String key = measurement.measures!.keys.elementAt(index);
                  return MeasureItemInfos(
                    title: key,
                    content: measurement.measures![key],
                  );
                },
              ),
            ),
            const MeasureItemInfos(
              title: "Photo du model",
              titleColor: primaryColor,
            ),
            measurement.photoModelUrl != null && measurement.photoModelUrl != ""
                ? Container(
                    height: 256,
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 16),
                    decoration: BoxDecoration(
                      color: kWhite,
                      border: Border.all(
                        color: primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Image.network(
                      measurement.photoModelUrl!,
                      height: 256,
                    ),
                  )
                : const MeasureItemInfos(
                    title: "",
                    content: "Aucune photo du model ajoutee !",
                    contentColor: secondaryColor,
                  ),
            const SizedBox(
              height: 16,
            ),
            const MeasureItemInfos(
              title: "Photo du tissu",
              titleColor: primaryColor,
            ),
            measurement.photoTissuUrl != null && measurement.photoTissuUrl != ""
                ? Container(
                    height: 256,
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 16),
                    decoration: BoxDecoration(
                      color: kWhite,
                      border: Border.all(
                        color: primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Image.network(
                      measurement.photoTissuUrl!,
                      height: 256,
                    ),
                  )
                : const MeasureItemInfos(
                    title: "",
                    content: "Aucune photo du tissu ajoutee !",
                    contentColor: secondaryColor,
                  ),
          ],
        ),
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
