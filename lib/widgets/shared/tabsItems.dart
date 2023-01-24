// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tailor_book/pages/customer.page.dart';
import 'package:tailor_book/pages/home.page.dart';
import 'package:tailor_book/pages/measure.page.dart';
import 'package:tailor_book/pages/profil.page.dart';

const List<Widget> tabsItems = [
  MeasurePage(),
  CustomerPage(),
  HomePage(),
  Center(),
  ProfilPage(),
];
