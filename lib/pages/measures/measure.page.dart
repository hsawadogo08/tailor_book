// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:tailor_book/bloc/filter/filter_bloc.dart';
import 'package:tailor_book/bloc/measure/measure.bloc.dart';
import 'package:tailor_book/bloc/measure/measure_event.dart';
import 'package:tailor_book/bloc/measure/measure_state.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/models/measurement.model.dart';
import 'package:tailor_book/pages/measures/add_measure.page.dart';
import 'package:tailor_book/pages/measures/detail_measure.page.dart';
import 'package:tailor_book/widgets/measure/measure_item.widget.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';
import 'package:tailor_book/widgets/shared/custom_search_text_field.dart';
import 'package:tailor_book/widgets/shared/loadingSpinner.dart';

class MeasurePage extends StatefulWidget {
  const MeasurePage({super.key});

  @override
  State<MeasurePage> createState() => _MeasurePageState();
}

class _MeasurePageState extends State<MeasurePage> {
  String searchkeyValue = '';

  @override
  void initState() {
    super.initState();
    context.read<MeasureBloc>().add(SearchMeasuresEvent());
    context.read<FilterBloc>().add(SearchFilterkeyEvent(searchKey: ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          color: primaryColor,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) {
              return const AddMeasure();
            },
            fullscreenDialog: true,
          );
          Navigator.push(context, route).then(
            (value) => context.read<MeasureBloc>().add(
                  SearchMeasuresEvent(),
                ),
          );
        },
        backgroundColor: secondaryColor,
        tooltip: 'Nouvelle mesure',
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mes Mesures",
                    style: GoogleFonts.exo2(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kWhite,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomSearchTextField(
                    onSearch: (searchKey) {
                      log("searchKey ==> $searchKey");
                      context.read<FilterBloc>().add(
                            SearchFilterkeyEvent(
                              searchKey: searchKey,
                            ),
                          );
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<FilterBloc, FilterState>(
              builder: (filterContext, filterState) {
                String filterKey = "";
                if (filterState is SearchFilterkeyState) {
                  filterKey = filterState.searchKey;
                }

                log("filterState ==> $filterState");
                log("filterKey ==> $filterKey");
                return Expanded(
                  child: BlocBuilder<MeasureBloc, MeasureStates>(
                    builder: (context, state) {
                      if (state is MeasureLoadingState) {
                        return const LoadingSpinner();
                      } else if (state is MeasureErrorState) {
                        return errorSection(state.errorMessage, context);
                      } else if (state is SearchMeasureSuccessState) {
                        if (state.measures.isEmpty) {
                          return emptySection(
                            "Vous n'avez pas enregistré une mesure !",
                          );
                        }

                        List<Measurement> measures = state.measures.where(
                          (element) {
                            return element.customerName!
                                .toUpperCase()
                                .contains(filterKey.toUpperCase());
                          },
                        ).toList();

                        if (measures.isEmpty) {
                          return emptySection(
                            "Aucune mesure trouvée !",
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
                                  dynamic value = await Navigator.push(
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
                );
              },
            ),
          ],
        ),
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
