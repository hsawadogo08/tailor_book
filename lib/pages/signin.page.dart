import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/bloc/signin.bloc.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/widgets/shared/app_logo.widget.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';
import 'package:tailor_book/widgets/shared/custom_form_field.widget.dart';
import 'package:tailor_book/widgets/shared/custom_phone_number_input.widget.dart';
import 'package:tailor_book/widgets/shared/loadingSpinner.dart';
import 'package:tailor_book/widgets/shared/slidepage.dart';
import 'package:tailor_book/widgets/shared/tabs.dart';
import 'package:tailor_book/widgets/shared/toast.dart';
import 'package:tailor_book/widgets/signin/forgot_password.widget.dart';
import 'package:tailor_book/widgets/signin/not_signup.widget.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    int delayedDuration = 150;

    final normalPhoneNumberController = TextEditingController();
    final formatPhoneNumberController = TextEditingController();
    final pwdController = TextEditingController();

    return Scaffold(
      backgroundColor: kWhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          color: primaryColor,
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: const NotSignup(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DelayedDisplay(
                      delay: Duration(milliseconds: delayedDuration),
                      child: const AppLogo(
                        width: 200,
                        height: 200,
                      ),
                    ),
                    DelayedDisplay(
                      delay: Duration(milliseconds: delayedDuration * 2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Connexion",
                          style: GoogleFonts.exo2(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
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
                      child: CustomPhoneNumberInput(
                        icon: Icons.add,
                        hint: 'Numéro de téléphone du client',
                        normalPhoneNumberController:
                            normalPhoneNumberController,
                        formatPhoneNumberController:
                            formatPhoneNumberController,
                        required: false,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DelayedDisplay(
                      delay: Duration(milliseconds: delayedDuration * 4),
                      child: CustomFormField(
                        icon: Icons.lock_outline,
                        hint: 'Entrez votre mot de passe',
                        obscureText: true,
                        controller: pwdController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    DelayedDisplay(
                      delay: Duration(milliseconds: delayedDuration * 5),
                      child: const ForgotPassword(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DelayedDisplay(
                      delay: Duration(milliseconds: delayedDuration * 6),
                      child: BlocBuilder<SignInBloc, SignInStates>(
                        builder: (builderContext, state) {
                          if (state is SignInLoadingState) {
                            return const LoadingSpinner();
                          } else if (state is SignInErrorState) {
                            showToast(
                              builderContext,
                              state.errorMessage,
                              "error",
                            );
                          } else if (state is SignInSuccessState) {
                            showToast(
                              builderContext,
                              state.successMessage,
                              "success",
                            );
                            onNavigateToHomePage(context);
                          }
                          return CustomButton(
                            buttonText: "Se connecter",
                            buttonSize: 16,
                            buttonColor: primaryColor,
                            btnTextColor: kWhite,
                            buttonFonction: () => builderContext
                                .read<SignInBloc>()
                                .add(
                                  SignInWithPhoneNumberEvent(
                                    phoneNumber:
                                        normalPhoneNumberController.text.trim(),
                                    password: pwdController.text.trim(),
                                  ),
                                ),
                          );
                        },
                      ),
                    ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // CustomButton(
                    //   buttonText: "Ajouter une photo",
                    //   buttonSize: 16,
                    //   buttonColor: primaryColor,
                    //   btnTextColor: kWhite,
                    //   buttonFonction: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) {
                    //           return const AddPhoto(title: "Ma photo");
                    //         },
                    //       ),
                    //     );
                    //   },
                    // )
                    // const SizedBox(
                    //   height: 32,
                    // ),
                    // DelayedDisplay(
                    //   delay: Duration(milliseconds: delayedDuration * 7),
                    //   child: const SocialLoginSection(),
                    // ),
                  ],
                ),
              ],
            ),
          ),
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

  void onNavigateToHomePage(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Navigator.of(context).pushReplacement(
          SlideRightRoute(
            child: const Tabs(),
            page: const Tabs(),
            direction: AxisDirection.down,
          ),
        );
      },
    );
  }
}
