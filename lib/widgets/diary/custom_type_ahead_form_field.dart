import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/models/food.dart';
import 'package:punkte_zaehler/services/help_methods.dart';

class CustomTypeAheadFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Function onSelected;
  const CustomTypeAheadFormField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Food>(
      itemBuilder: (context, Food suggestion) {
        return ListTile(
          title: Text(suggestion.title!),
          trailing: Text('${decimalFormat(suggestion.points!)} P.'),
        );
      },
      onSelected: (val) => onSelected(val),
      suggestionsCallback: (textEditingValue) {
        if (textEditingValue == '') {
          return [];
        }
        return AllData.foods
            .where((Food food) => food.title!.toLowerCase().startsWith((textEditingValue.toLowerCase())))
            .toList();
      },
      debounceDuration: const Duration(milliseconds: 500),
      hideWithKeyboard: true,
      hideOnEmpty: true,
      builder: (context, controller, focusNode) {
        return TextFormField(
          focusNode: focusNode,
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          textInputAction: TextInputAction.next,
          validator: (value) {
            if ((value == null || value.isEmpty || value == '')) {
              return 'Das ist ein Pflichtfeld';
            }

            return null;
          },
          onChanged: (value) => this.controller.text = value,
        );
      },
    );
  }
}
