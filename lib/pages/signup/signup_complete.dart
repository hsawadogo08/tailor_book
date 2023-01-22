import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/bloc/signup.bloc.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/models/utilisateur.model.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';
import 'package:tailor_book/widgets/shared/custom_form_field.widget.dart';
import 'package:tailor_book/widgets/shared/loadingSpinner.dart';
import 'package:tailor_book/widgets/shared/slidepage.dart';
import 'package:tailor_book/widgets/shared/tabs.dart';
import 'package:tailor_book/widgets/shared/toast.dart';

class SignupCompletePage extends StatelessWidget {
  final String phoneNumber;
  final String userUID;
  const SignupCompletePage({
    super.key,
    required this.phoneNumber,
    required this.userUID,
  });

  @override
  Widget build(BuildContext context) {
    int delayedDuration = 150;
    final companyController = TextEditingController();
    final nomController = TextEditingController();
    final prenomController = TextEditingController();
    final pwdController = TextEditingController();
    final confirmPwdController = TextEditingController();

    void onPushEvent(BuildContext builderContext) {
      Utilisateur utilisateur = Utilisateur();
      utilisateur.userUID = userUID;
      utilisateur.phoneNumber = phoneNumber;
      utilisateur.lastName = nomController.text.trim();
      utilisateur.firstName = prenomController.text.trim();
      utilisateur.password = pwdController.text.trim();
      utilisateur.confirmPassword = confirmPwdController.text.trim();
      utilisateur.companyName = companyController.text.trim();
      builderContext.read<SignUpBloc>().add(
            SignupCompeletEvent(
              utilisateur: utilisateur,
            ),
          );
    }

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          textAlign: TextAlign.center,
          "Finalisation",
          style: GoogleFonts.exo2(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: kWhite,
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: BlocBuilder<SignUpBloc, SignUpStates>(
          builder: (builderContext, state) {
            if (state is SignUpLoadingState) {
              return const LoadingSpinner();
            } else if (state is SignUpErrorState) {
              showToast(builderContext, state.errorMessage, "error");
            } else if (state is SignUpSuccessState) {
              showToast(builderContext, state.successMessage, "success");
              onNavigateToHomePage(context);
            }
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: CustomButton(
                buttonText: "Terminer",
                buttonSize: 16,
                buttonColor: primaryColor,
                btnTextColor: kWhite,
                buttonFonction: () {
                  onPushEvent(builderContext);
                },
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 32,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: delayedDuration * 2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Veuillez completer les informations suivantes",
                      style: GoogleFonts.exo2(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: delayedDuration * 3),
                  child: CustomFormField(
                    icon: Icons.home_repair_service,
                    hint: "Entrez le nom de votre entreprise",
                    obscureText: false,
                    controller: companyController,
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: delayedDuration * 3),
                  child: CustomFormField(
                    icon: Icons.person,
                    hint: 'Entrez votre nom',
                    obscureText: false,
                    controller: nomController,
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: delayedDuration * 4),
                  child: CustomFormField(
                    icon: Icons.person,
                    hint: 'Entrez votre prénom(s)',
                    obscureText: false,
                    controller: prenomController,
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: delayedDuration * 6),
                  child: CustomFormField(
                    icon: Icons.lock_outline,
                    hint: 'Entrez votre mot de passe',
                    obscureText: true,
                    controller: pwdController,
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: delayedDuration * 7),
                  child: CustomFormField(
                    icon: Icons.lock_outline,
                    hint: 'Confirmez le mot de passe',
                    obscureText: true,
                    controller: confirmPwdController,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onNavigateToHomePage(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Navigator.of(context).pushReplacement(
          SlideRightRoute(
            child: const Tabs(),
            page: const Tabs(),
            direction: AxisDirection.left,
          ),
        );
      },
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
}
