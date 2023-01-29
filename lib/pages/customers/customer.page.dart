import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:tailor_book/bloc/customer.bloc.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/pages/customers/detail_customer.page.dart';
import 'package:tailor_book/widgets/customer/customer_item.widget.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';
import 'package:tailor_book/widgets/shared/custom_search_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_book/widgets/shared/loadingSpinner.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  void initState() {
    super.initState();
    context.read<CustomerBloc>().add(SearchCustomerEvent());
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
                    "Mes Clients",
                    style: GoogleFonts.exo2(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kWhite,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const CustomSearchTextField(),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<CustomerBloc, CustomerStates>(
                builder: (context, state) {
                  if (state is CustomerLoadingState) {
                    return const LoadingSpinner();
                  } else if (state is CustomerErrorState) {
                    return errorSection(state.errorMessage, context);
                  } else if (state is SearchCustomerSuccessState) {
                    if (state.customers.isEmpty) {
                      return emptySection(
                        "Vous n'avez pas enregistré un client !",
                      );
                    }

                    return LazyLoadScrollView(
                      onEndOfPage: () {},
                      child: ListView.builder(
                        itemCount: state.customers.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DetailCustomerPage(
                                      customer: state.customers[index],
                                    );
                                  },
                                ),
                              );
                            },
                            child: CustomerItem(
                              customer: state.customers[index],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    log("NULLL");
                    return Container();
                  }
                },
              ),
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
              context.read<CustomerBloc>().add(SearchCustomerEvent());
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
