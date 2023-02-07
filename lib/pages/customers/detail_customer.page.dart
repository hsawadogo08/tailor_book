import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:tailor_book/bloc/measure/measure.bloc.dart';
import 'package:tailor_book/bloc/measure/measure_event.dart';
import 'package:tailor_book/bloc/measure/measure_state.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/models/customer.model.dart';
import 'package:tailor_book/models/measurement.model.dart';
import 'package:tailor_book/pages/measures/detail_measure.page.dart';
import 'package:tailor_book/widgets/measure/measure_item.widget.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';
import 'package:tailor_book/widgets/shared/loadingSpinner.dart';
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
            title: "Nom & Prénom(s)",
            content: "${customer.lastName} ${customer.firstName}",
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
          const MeasureItemInfos(
            title: "Liste des tenues",
          ),
          Expanded(
            child: BlocBuilder<MeasureBloc, MeasureStates>(
              builder: (context, state) {
                if (state is MeasureLoadingState) {
                  return const LoadingSpinner();
                } else if (state is MeasureErrorState) {
                  return errorSection(state.errorMessage, context);
                } else if (state is SearchMeasureSuccessState) {
                  List<Measurement> measures = state.measures.where(
                    (element) {
                      return element.customerId == customer.id;
                    },
                  ).toList();

                  if (measures.isEmpty) {
                    return emptySection(
                      "Ce client n'a pas de mesures !",
                    );
                  }

                  return LazyLoadScrollView(
                    onEndOfPage: () {},
                    child: ListView.builder(
                      itemCount: measures.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) {
                                return DetailMeasurePage(
                                  measurement: measures[index],
                                );
                              },
                            );
                            await Navigator.push(
                              context,
                              route,
                            );
                          },
                          child: MeasureItem(
                            measurement: measures[index],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget errorSection(String errorMessage, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 75,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                errorMessage,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: kWhite,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          CustomButton(
            buttonText: "Réessayer",
            btnTextColor: kWhite,
            buttonSize: 18,
            buttonColor: secondaryColor,
            borderColor: secondaryColor,
            buttonFonction: () {
              context.read<MeasureBloc>().add(SearchMeasuresEvent());
            },
          ),
        ],
      ),
    );
  }

  Widget emptySection(String message) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 75,
            decoration: BoxDecoration(
              color: tertiaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                message,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: kWhite,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
