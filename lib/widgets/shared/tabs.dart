// ignore_for_file: unnecessary_new
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/widgets/shared/app_logo.widget.dart';
import 'package:tailor_book/widgets/shared/tabsItems.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => new AlertDialog(
            title: const AppLogo(
              width: 128,
              height: 128,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            content: Text(
              "Souhaitez-vous quitter l'application ?",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'Non',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text(
                  'Oui',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          child: tabsItems.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: ConvexAppBar(
          items: <TabItem>[
            TabItem(
              icon: Icon(
                FontAwesomeIcons.folderOpen,
                size: _selectedIndex == 0 ? 28 : 24,
                color: _selectedIndex == 0 ? primaryColor : kWhite,
              ),
              title: 'Mesures',
            ),
            TabItem(
              icon: Icon(
                FontAwesomeIcons.peopleGroup,
                size: _selectedIndex == 1 ? 28 : 24,
                color: _selectedIndex == 1 ? primaryColor : kWhite,
              ),
              title: 'Clients',
            ),
            TabItem(
              icon: Icon(
                Icons.home,
                size: _selectedIndex == 2 ? 28 : 24,
                color: _selectedIndex == 2 ? primaryColor : kWhite,
              ),
              title: 'Accueil',
            ),
            TabItem(
              icon: Icon(
                FontAwesomeIcons.peopleCarryBox,
                size: _selectedIndex == 3 ? 28 : 24,
                color: _selectedIndex == 3 ? primaryColor : kWhite,
              ),
              title: 'Personnels',
            ),
            TabItem(
              icon: Icon(
                FontAwesomeIcons.userTie,
                size: _selectedIndex == 4 ? 28 : 24,
                color: _selectedIndex == 4 ? primaryColor : kWhite,
              ),
              title: 'Profil',
            ),
          ],
          initialActiveIndex: _selectedIndex,
          activeColor: kWhite,
          color: kWhite,
          backgroundColor: primaryColor,
          elevation: 0,
          style: TabStyle.reactCircle,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
