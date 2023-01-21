import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tailor_book/bloc/measure.bloc.dart';
import 'package:tailor_book/config/amount_formater.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/models/measurement.model.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';
import 'package:tailor_book/widgets/shared/loadingSpinner.dart';
import 'package:tailor_book/widgets/shared/measure_item_infos.widget.dart';
import 'package:tailor_book/widgets/shared/toast.dart';

class ConfirmAddMeasure extends StatelessWidget {
  final Measurement measurement;
  const ConfirmAddMeasure({
    super.key,
    required this.measurement,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double measureHeight =
        100 * double.parse("${measurement.measures!.length}");

    return Scaffold(
      backgroundColor: kGris,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Récapitulatif - Nouvelle mesure",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: BlocBuilder<MeasureBloc, MeasureStates>(
          builder: (builderContext, state) {
            if (state is MeasureLoadingState) {
              return const LoadingSpinner();
            } else if (state is MeasureErrorState) {
              showToast(builderContext, state.errorMessage, "error");
            } else if (state is SaveMeasureSuccessState) {
              showToast(builderContext, state.successMessage, "success");
              onGoBack(context, true);
            }

            return Row(
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
                    buttonFonction: () {
                      onGoBack(context, false);
                    },
                  ),
                ),
                SizedBox(
                  width: (width / 5) * 2,
                  child: CustomButton(
                    buttonText: "Confirmer",
                    buttonSize: 16,
                    pH: 24,
                    buttonColor: kGreen,
                    borderColor: kGreen,
                    btnTextColor: kWhite,
                    buttonFonction: () {
                      builderContext.read<MeasureBloc>().add(
                            SaveMeasureEvent(
                              measurement: measurement,
                            ),
                          );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MeasureItemInfos(
              title: "Informations du client",
              content:
                  "${measurement.customer?.lastName} ${measurement.customer?.firstName} - ${measurement.customer?.phoneNumber}",
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
            // const MeasureItemInfos(
            //   title: "Photo du model",
            //   titleColor: secondaryColor,
            // ),
            // Container(
            //   height: 256,
            //   width: double.infinity,
            //   padding: const EdgeInsets.all(16),
            //   margin: const EdgeInsets.fromLTRB(5, 0, 5, 16),
            //   decoration: BoxDecoration(
            //     color: kWhite,
            //     // borderRadius: BorderRadius.circular(12),
            //     border: Border.all(
            //       color: primaryColor,
            //       width: 2,
            //     ),
            //   ),
            //   child: Image.file(
            //     File(measurement.photoModel!.path),
            //     height: 256,
            //   ),
            // ),
            // const SizedBox(
            //   height: 16,
            // ),
            // const MeasureItemInfos(
            //   title: "Photo du tissu",
            //   titleColor: secondaryColor,
            // ),
            // Container(
            //   height: 256,
            //   width: double.infinity,
            //   padding: const EdgeInsets.all(16),
            //   margin: const EdgeInsets.fromLTRB(5, 0, 5, 16),
            //   decoration: BoxDecoration(
            //     color: kWhite,
            //     // borderRadius: BorderRadius.circular(12),
            //     border: Border.all(
            //       color: primaryColor,
            //       width: 2,
            //     ),
            //   ),
            //   child: Image.file(
            //     File(measurement.photoTissu!.path),
            //     height: 256,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void showToast(BuildContext context, String message, String type) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Toast.showFlutterToast(
          context,
          message,
          type,
        );
      },
    );
  }

  void onGoBack(BuildContext context, bool response) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Navigator.pop(context, response);
      },
    );
  }
}
