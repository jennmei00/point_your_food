import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:punkte_zaehler/models/enums.dart';
import 'package:validators/validators.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final Function? onChanged;
  final bool mandatory; //check for mandatory field
  final TextFieldType type;
  // final String fieldname; //substitute for an id
  // final bool noDecimal;

  const CustomTextField({
    Key? key,
    this.labelText = '',
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    required this.onChanged,
    required this.controller,
    required this.mandatory,
    required this.type,
    // required this.fieldname,
    // this.noDecimal = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        onChanged: onChanged == null ? null : (val) => onChanged!(val),
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        controller: controller,
        inputFormatters: type == TextFieldType.decimal
            ? [
                FilteringTextInputFormatter.allow(RegExp(
                    r'^(?:-?(?:[0-9]+))?(?:\,[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?')),
              ]
            : type == TextFieldType.integer
                ? [
                    FilteringTextInputFormatter.allow(RegExp(r'^([0-9]*)?')),
                  ]
                : null,
        validator: (value) {
          if ((value == null || value.isEmpty || value == '') && mandatory) {
            return 'Das ist ein Pflichtfeld';
          } else if (type == TextFieldType.decimal) {
            if (!(isFloat(value!.replaceAll(',', '.')))) {
              return 'Nur Nummern sind erlaubt';
            } else if (type == TextFieldType.integer) {
              if (!isInt(value)) {
                return 'Nur Zahlen ohne Dezimalstelle sind erlaubt';
              }
            }
          }

          return null;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          labelText: labelText,
          floatingLabelStyle: TextStyle(backgroundColor: Colors.white),
          hintText: hintText,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
