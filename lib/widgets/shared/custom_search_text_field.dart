// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tailor_book/constants/color.dart';

class CustomSearchTextField extends StatelessWidget {
  final VoidCallback? function;
  final String Function(String)? onSearch;
  const CustomSearchTextField({
    super.key,
    this.function,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: primaryColor,
            size: 30,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              onChanged: onSearch,
              decoration: const InputDecoration(
                hintText: "Rechercher par mot clé...",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
