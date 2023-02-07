
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:tailor_book/bloc/measure/measure.bloc.dart';
import 'package:tailor_book/bloc/measure/measure_state.dart';
import 'package:tailor_book/bloc/user/user.bloc.dart';
import 'package:tailor_book/config/amount_formater.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/pages/measures/add_measure.page.dart';
import 'package:tailor_book/pages/measures/detail_measure.page.dart';
import 'package:tailor_book/widgets/home/home_balance_item.widget.dart';
import 'package:tailor_book/widgets/measure/measure_item.widget.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';
import 'package:tailor_book/widgets/shared/loadingSpinner.dart';

import '../../bloc/measure/measure_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<MeasureBloc>().add(
          SearchMeasuresEvent(size: 10, status: "PENDING"),
        );
    context.read<UserBloc>().add(UserInfosEvent());
    context.read<MeasureAmountBloc>().add(MeasureAmoutEvent());
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
              decoration: const BoxDecoration(
                color: primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bienvenue,',
                        style: GoogleFonts.exo2(
                          fontSize: 20,
                          color: kWhite,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: kWhite.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Icon(
                            Icons.notifications_outlined,
                            color: kWhite,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(),
                  BlocConsumer<UserBloc, UserStates>(
                    builder: (context, state) {
                      if (state is GetUserInfosState) {
                        return Text(
                          "${state.user.lastName} ${state.user.firstName}",
                          style: GoogleFonts.exo2(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: kWhite,
                          ),
                        );
                      }
                      return Text(
                        "--",
                        style: GoogleFonts.exo2(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kWhite,
                        ),
                      );
                    },
                    listener: (context, state) {
                      if (state is UserErrorState) {
                        context.read<UserBloc>().add(UserInfosEvent());
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            BlocConsumer<MeasureAmountBloc, MeasureStates>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is MeasureLoadingState) {
                  return const LoadingSpinner();
                } else if (state is MeasureAmoutSuccessState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HomeBalanceItem(
                        balanceLabel: "Solde",
                        balanceValue:
                            AmountFormater.format(state.amount['amount']),
                        icon: FontAwesomeIcons.moneyCheckDollar,
                      ),
                      HomeBalanceItem(
                        balanceLabel: "Crédit",
                        balanceValue:
                            "- ${AmountFormater.format(state.amount['credit'])}",
                        backgroundColor: secondaryColor,
                        icon: Icons.money_off,
                      ),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      HomeBalanceItem(
                        balanceLabel: "Solde",
                        balanceValue: "--",
                        icon: FontAwesomeIcons.moneyCheckDollar,
                      ),
                      HomeBalanceItem(
                        balanceLabel: "Crédit",
                        balanceValue: "--",
                        backgroundColor: secondaryColor,
                        icon: Icons.money_off,
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Text(
                "Mesures en attente",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: primaryColor,
                ),
              ),
            ),
            const SizedBox(
                // height: 2,
                ),
            Expanded(
              child: BlocConsumer<MeasureBloc, MeasureStates>(
                listener: (context, state) {},
                builder: (builderContext, state) {
                  if (state is MeasureLoadingState) {
                    return const LoadingSpinner();
                  } else if (state is MeasureErrorState) {
                    return errorSection(state.errorMessage, builderContext);
                  } else if (state is SearchMeasureSuccessState) {
                    if (state.measures.isEmpty) {
                      return emptySection(
                        "Vous n'avez pas mesures en attente !",
                      );
                    }

                    return LazyLoadScrollView(
                      onEndOfPage: () {},
                      child: ListView.builder(
                        itemCount: state.measures.length,
                        itemBuilder: (itemContext, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DetailMeasurePage(
                                        measurement: state.measures[index]);
                                  },
                                ),
                              ).then((value) {
                                context.read<MeasureBloc>().add(
                                      SearchMeasuresEvent(
                                        size: 10,
                                        status: "PENDING",
                                      ),
                                    );
                                context
                                    .read<MeasureAmountBloc>()
                                    .add(MeasureAmoutEvent());
                              });
                            },
                            child: MeasureItem(
                              measurement: state.measures[index],
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
