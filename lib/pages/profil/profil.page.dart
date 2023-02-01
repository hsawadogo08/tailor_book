import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/bloc/user.bloc.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/pages/profil/update_password.page.dart';
import 'package:tailor_book/pages/profil/update_profil.page.dart';
import 'package:tailor_book/pages/utilities/a_propos.page.dart';
import 'package:tailor_book/widgets/shared/parameter.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGris,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          color: primaryColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 16),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/images/profil.png",
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        heroTag: null,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const UpdateProfilPage();
                              },
                            ),
                          ).then((value) {
                            if (value == true) {
                              context.read<UserBloc>().add(UserInfosEvent());
                            }
                          });
                        },
                        backgroundColor: secondaryColor,
                        elevation: 0,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        child: const Icon(
                          FontAwesomeIcons.pencil,
                          size: 25.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            BlocConsumer<UserBloc, UserStates>(
              builder: (context, state) {
                if (state is GetUserInfosState) {
                  return Column(
                    children: [
                      Text(
                        "${state.user.lastName} ${state.user.firstName}",
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${state.user.phoneNumber} ${state.user.email}",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Entreprise : ${state.user.companyName}",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                    ],
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
            Column(
              children: [
                Parameter(
                  icon: Icons.lock,
                  title: 'Modifier le mot de passe',
                  subTitle: '',
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const UpdatePasswordPage();
                        },
                      ),
                    ).then((value) {
                      if (value == true) {
                        context.read<UserBloc>().add(UserInfosEvent());
                      }
                    });
                  },
                ),
                // Parameter(
                //   icon: Icons.share,
                //   title: 'Partager l\'application',
                //   subTitle: '',
                //   function: () {
                //     // Share.share('https://www.openburkina.bf/');
                //   },
                // ),
                Parameter(
                  icon: Icons.info,
                  title: 'A propos',
                  subTitle: 'A propos de l\'application',
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const AProposPage();
                        },
                      ),
                    );
                  },
                ),
                Parameter(
                  icon: Icons.logout,
                  title: 'Se déconnecter',
                  subTitle: 'Se déconnecter de l\'application',
                  function: () {},
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
