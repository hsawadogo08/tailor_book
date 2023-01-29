import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/models/personnel.model.dart';
import 'package:tailor_book/services/personnel.service.dart';

class SelectPersonnel extends StatefulWidget {
  final ValueSetter<Personnel> onPressed;
  const SelectPersonnel({
    super.key,
    required this.onPressed,
  });

  @override
  State<SelectPersonnel> createState() => _SelectPersonnelState();
}

class _SelectPersonnelState extends State<SelectPersonnel> {
  String currentPersonnel = "";
  Personnel selectedPersonnel = Personnel();
  List<Personnel> personnels = [];

  @override
  void initState() {
    super.initState();
    getPersonnels();
  }

  void getPersonnels() async {
    QuerySnapshot<Object?> response = await PersonnelService.getAll();
    personnels = response.docs
        .map(
          (e) => Personnel.fromDocumentSnapshot(e),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showPersonnelModal,
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                currentPersonnel == ""
                    ? "Sélectionner un personnel"
                    : currentPersonnel,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_drop_down_sharp,
              color: primaryColor,
              size: 35,
            )
          ],
        ),
      ),
    );
  }

  void showPersonnelModal() {
    SelectDialog.showModal<String>(
      context,
      label: "Mon Personnel",
      selectedValue: currentPersonnel,
      items: List.generate(
        personnels.length,
        (index) =>
            "${personnels[index].lastName} ${personnels[index].firstName} - ${personnels[index].phoneNumber}",
      ),
      onChange: (String selected) {
        setState(() {
          currentPersonnel = selected;
          for (Personnel value in personnels) {
            String name =
                "${value.lastName} ${value.firstName} - ${value.phoneNumber}";
            if (name == selected) {
              selectedPersonnel = value;
            }
          }
          widget.onPressed(selectedPersonnel);
        });
      },
      searchBoxDecoration: InputDecoration(
        hintText: "Rechercher un personnel...",
        hintStyle: GoogleFonts.montserrat(
          fontSize: 14,
          color: primaryColor,
          fontWeight: FontWeight.w300,
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
            width: 4,
          ),
        ),
      ),
      titleStyle: GoogleFonts.montserrat(
        fontSize: 16,
        color: primaryColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
