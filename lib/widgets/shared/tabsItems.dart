// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tailor_book/pages/customers/customer.page.dart';
import 'package:tailor_book/pages/utilities/home.page.dart';
import 'package:tailor_book/pages/measures/measure.page.dart';
import 'package:tailor_book/pages/personnels/personnel.page.dart';
import 'package:tailor_book/pages/profil/profil.page.dart';

const List<Widget> tabsItems = [
  MeasurePage(),
  CustomerPage(),
  HomePage(),
  PersonnelPage(),
  ProfilPage(),
];
