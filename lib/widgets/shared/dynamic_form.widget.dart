import 'dart:developer';

import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';


class DynamicForm extends StatefulWidget {
  final FormController formController;
  final List<Map<String, dynamic>> fields;
  const DynamicForm({
    super.key,
    required this.formController,
    required this.fields,
  });

  @override
  // ignore: no_logic_in_create_state
  State<DynamicForm> createState() => _DynamicFormState(
        fields: fields,
        formController: formController,
      );
}

class _DynamicFormState extends State<DynamicForm> {
  List<TextElement> textElements = [];
  final FormController formController;
  final List<Map<String, dynamic>> fields;
  _DynamicFormState({
    required this.formController,
    required this.fields,
  });

  @override
  void initState() {
    for (var element in fields) {
      textElements.add(
        TextElement(
          id: element["title"],
          label: element["title"],
          typeInput:
              element["type"] == "NUMBER" ? TypeInput.Numeric : TypeInput.Text,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
        ),
      );
    }
    log("$fields");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDynamicForm(
      controller: widget.formController,
      groupElements: [
        GroupElement(
          directionGroup: DirectionGroup.Vertical,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
          commonDecorationElements: OutlineDecorationElement(
            borderColor: primaryColor,
            radius: const BorderRadius.all(Radius.circular(12)),
            widthSide: 2,
            focusWidthSide: 2,
            focusColor: secondaryColor,
            textStyle: GoogleFonts.montserrat(
              fontSize: 20,
              color: primaryColor,
              fontWeight: FontWeight.w500,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            hintStyle: GoogleFonts.montserrat(
              fontSize: 16,
              color: primaryColor,
              fontWeight: FontWeight.w300,
            ),
            labelStyle: GoogleFonts.montserrat(
              fontSize: 20,
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          textElements: [...textElements],
        )
      ],
    );
  }
}
