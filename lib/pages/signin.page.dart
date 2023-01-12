import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/widgets/shared/app_logo.widget.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';
import 'package:tailor_book/widgets/shared/custom_form_field.widget.dart';
import 'package:tailor_book/widgets/shared/custom_phone_number_input.widget.dart';
import 'package:tailor_book/widgets/signin/forgot_password.widget.dart';
import 'package:tailor_book/widgets/signin/not_signup.widget.dart';
import 'package:tailor_book/widgets/signin/socail_login_section.widget.dart';

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
                        hint: 'Numéro de téléphone',
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
                      delay: Duration(milliseconds: delayedDuration * 7),
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
                    CustomButton(
                      buttonText: "Se connecter",
                      buttonSize: 16,
                      buttonColor: primaryColor,
                      btnTextColor: kWhite,
                      buttonFonction: () {},
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    DelayedDisplay(
                      delay: Duration(milliseconds: delayedDuration * 5),
                      child: const SocialLoginSection(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
