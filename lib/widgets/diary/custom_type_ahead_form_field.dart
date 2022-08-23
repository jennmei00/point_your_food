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
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<Food>(
      hideSuggestionsOnKeyboardHide: true,
      debounceDuration: const Duration(milliseconds: 500),
      // animationDuration: Duration(milliseconds: 100),
      suggestionsCallback: (textEditingValue) {
        if (textEditingValue == '') {
          return [];
        }
        return AllData.foods
            .where((Food option) => option.title!.startsWith(textEditingValue));
      },
      hideOnEmpty: true,
      validator: (value) {
        if ((value == null || value.isEmpty || value == '')) {
          return 'Das ist ein Pflichtfeld';
        }

        return null;
      },
      itemBuilder: (context, Food suggestion) {
        return ListTile(
          title: Text(suggestion.title!),
          trailing: Text('${decimalFormat(suggestion.points!)} P.'),
        );
      },
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        textInputAction: TextInputAction.next,
      ),
      onSuggestionSelected: (val) => onSelected(val),
    );
  }
}
