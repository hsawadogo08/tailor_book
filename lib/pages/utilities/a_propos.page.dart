import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/widgets/shared/AproposInfos.dart';
import 'package:tailor_book/widgets/shared/app_logo.widget.dart';

class AProposPage extends StatelessWidget {
  const AProposPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kGris,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "A propos !",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AppLogo(),
              // const SizedBox(
              //   width: 16,
              // ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 16, 10, 0),
                child: Text(
                  """Cette application est destinée aux couturiers, aux stylistes, aux tailleurs.
    Elle permet de faciliter la gestion des mesures des clients, le suivi des rendez-vous, la gestion du personnels et la gestion du portefeuille.""",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(),
                ),
              ),
              const AProposInfos(
                icon: Icons.phone,
                title: "Téléphone",
                content: "+226 73 88 39 40 / 65 96 08 79",
              ),
              const AProposInfos(
                icon: Icons.mail_outline,
                title: "Email",
                content: "hubertsawadogohubert87@gmail.com",
              ),
              const AProposInfos(
                icon: Icons.whatsapp,
                title: "Whatsapp",
                content: "+226 73 88 39 40 / 65 96 08 79",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
