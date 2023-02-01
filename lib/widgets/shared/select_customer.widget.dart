import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/models/customer.model.dart';
import 'package:tailor_book/services/customer.service.dart';

class SelectCustomer extends StatefulWidget {
  final ValueSetter<Customer> onPressed;
  final String selectedClient;
  const SelectCustomer({
    super.key,
    required this.onPressed,
    this.selectedClient = "Sélectionner un client",
  });

  @override
  State<SelectCustomer> createState() => _SelectCustomerState();
}

class _SelectCustomerState extends State<SelectCustomer> {
  String selectedClient = "";
  Customer selectedCustomer = Customer();
  List<Customer> customers = [];
  

  @override
  void initState() {
    super.initState();
    getCustomers();
  }

  void getCustomers() async {
    QuerySnapshot<Object?> response = await CustomerService.getAll();
    customers = response.docs
        .map(
          (e) => Customer.fromDocumentSnapshot(e),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showClientModal,
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
                selectedClient == "" ? widget.selectedClient : selectedClient,
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

  void showClientModal() {
    SelectDialog.showModal<String>(
      context,
      label: "Mes Clients",
      selectedValue: selectedClient,
      emptyBuilder: (context) {
        return Center(
          child: Text(
            "Aucun client trouvé !",
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: primaryColor,
              fontWeight: FontWeight.w300,
            ),
          ),
        );
      },
      items: List.generate(
        customers.length,
        (index) =>
            "${customers[index].lastName} ${customers[index].firstName} - ${customers[index].phoneNumber}",
      ),
      onChange: (String selected) {
        setState(() {
          selectedClient = selected;
          for (Customer value in customers) {
            String name =
                "${value.lastName} ${value.firstName} - ${value.phoneNumber}";
            if (name == selected) {
              selectedCustomer = value;
            }
          }
          widget.onPressed(selectedCustomer);
        });
      },
      searchBoxDecoration: InputDecoration(
        hintText: "Rechercher un client...",
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
