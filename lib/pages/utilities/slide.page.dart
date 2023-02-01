import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/pages/utilities/welcome.page.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';

class SlidePage extends StatelessWidget {
  final PageController _pageController = PageController();

  SlidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          color: primaryColor,
        ),
      ),
      body: OnBoard(
        pageController: _pageController,
        onSkip: () {
          log('onSkip tapped');
        },
        onDone: () {
          log('done tapped');
        },
        onBoardData: onBoardData,
        titleStyles: GoogleFonts.montserrat(
          color: secondaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        descriptionStyles: GoogleFonts.montserrat(
          fontSize: 14,
          color: primaryColor,
          // fontWeight: FontWeight.w500,
        ),
        pageIndicatorStyle: const PageIndicatorStyle(
          width: 100,
          inactiveColor: primaryColor,
          activeColor: secondaryColor,
          inactiveSize: Size(8, 8),
          activeSize: Size(16, 16),
        ),
        skipButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return !state.isLastPage
                ? TextButton(
                    onPressed: () => _onNextTap(state),
                    child: Text(
                      "Ignorer",
                      style: GoogleFonts.montserrat(
                        color: secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : const SizedBox();
          },
        ),
        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return CustomButton(
              buttonText: state.isLastPage ? "Commencer" : "Suivant",
              btnTextColor: kWhite,
              buttonColor: primaryColor,
              borderColor: primaryColor,
              buttonSize: 14,
              buttonFonction: () => state.isLastPage
                  ? _onGoToWelcomePage(context)
                  : _onNextTap(state),
            );
          },
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      log("Finished pressed");
    }
  }

  void _onGoToWelcomePage(BuildContext context) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) {
        return const WelcomePage();
      },
    );
    Navigator.pushReplacement(context, route);
  }
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Enregistrement des mesures",
    description: "Gérer l'enregistrement de vos mesures ainsi leurs status",
    imgUrl: "assets/images/save.png",
  ),
  const OnBoardModel(
    title: "Gestion du portefeuille",
    description:
        "Gérer en toute éfficacité les entrées d'argent, les avances de paiement des clients ainsi que leurs crédits !",
    imgUrl: 'assets/images/money.png',
  ),
  const OnBoardModel(
    title: "Gestion des statistiques",
    description:
        "Avoir des statistiques telles que les commandes en attente, le nombre de tenue cousues par client",
    imgUrl: 'assets/images/graph.png',
  ),
];
