import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/pages/profil/signin.page.dart';
import 'package:tailor_book/pages/signup/signup.page.dart';
import 'package:tailor_book/widgets/shared/app_logo.widget.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kWhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          color: primaryColor,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: (height / 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SlideInDown(
                      child: const AppLogo(),
                    ),
                    SlideInDown(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Connectez-vous pour acceder à votre compte ou vous inscrire si vous n'avez pas de compte !",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            // fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SlideInUp(
                child: SizedBox(
                  height: (height / 5) * 2,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          buttonText: "Se connecter",
                          btnTextColor: kWhite,
                          buttonSize: 16,
                          buttonFonction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SigninPage();
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomButton(
                          buttonText: "S'inscrire",
                          buttonColor: secondaryColor,
                          borderColor: secondaryColor,
                          btnTextColor: kWhite,
                          buttonSize: 16,
                          buttonFonction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SignupPage();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
