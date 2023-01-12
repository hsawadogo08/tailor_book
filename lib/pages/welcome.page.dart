import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/pages/signin.page.dart';
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
                    const AppLogo(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Sauvegarder vos mesures en toute sécurité !",
                        style: GoogleFonts.exo2(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: (height / 5) * 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        buttonText: "Se connecter",
                        btnTextColor: kWhite,
                        buttonSize: 18,
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
                        buttonSize: 18,
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
                    ],
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
