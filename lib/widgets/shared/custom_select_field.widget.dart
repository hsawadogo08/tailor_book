import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:tailor_book/constants/color.dart';

class CustomSelectField extends StatefulWidget {
  final String title;
  final String placeholder;
  final List<String> items;
  final TextEditingController controller;
  final VoidCallback function;
  final String selectedValue;

  const CustomSelectField({
    super.key,
    required this.title,
    required this.placeholder,
    required this.items,
    required this.controller,
    required this.function,
    this.selectedValue = "",
  });

  @override
  // ignore: no_logic_in_create_state
  State<CustomSelectField> createState() => _CustomSelectFieldState(
        title: title,
        placeholder: placeholder,
        items: items,
        controller: controller,
        selectedValue: selectedValue,
      );
}

class _CustomSelectFieldState extends State<CustomSelectField> {
  final String title;
  final String placeholder;
  final List<String> items;
  final TextEditingController controller;
  String selectedValue;
  List<S2Choice<String>> options = [];

  _CustomSelectFieldState({
    required this.title,
    required this.placeholder,
    required this.items,
    required this.controller,
    required this.selectedValue,
  });

  @override
  void initState() {
    options = List.generate(items.length, (index) {
      return S2Choice<String>(value: items[index], title: items[index]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.fromLTRB(4, 0, 4, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor, width: 2),
      ),
      child: SmartSelect<String>.single(
        title: title,
        placeholder: placeholder,
        choiceItems: options,
        selectedValue: selectedValue,
        modalType: S2ModalType.popupDialog,
        onChange: (state) => setState(() {
          selectedValue = state.value;
          controller.text = selectedValue;
          super.widget.function.call();
        }),
        choiceStyle: const S2ChoiceStyle(
          titleStyle: TextStyle(
            color: primaryColor,
          ),
        ),
        modalConfig: S2ModalConfig(
          type: S2ModalType.popupDialog,
          barrierColor: primaryColor.withOpacity(0.2),
          headerStyle: S2ModalHeaderStyle(
            backgroundColor: Theme.of(context).primaryColor,
            textStyle: Theme.of(context).primaryTextTheme.headline6,
            centerTitle: true,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
