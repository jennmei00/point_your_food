import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final Function? onChanged;
  final bool mandatory; //check for mandatory field
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
    // required this.fieldname,
    // this.noDecimal = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // print(onChanged);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        onChanged: onChanged == null ? null : (val) => onChanged!(val),
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        controller: controller,
        // inputFormatters: 
        // keyboardType == TextInputType.number
        //     ? 
            // [
            //     FilteringTextInputFormatter.allow(RegExp(
            //         r'^(?:-?(?:[0-9]+))?(?:\,[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?')),
            //   ]
            // : [
            //     FilteringTextInputFormatter.allow(RegExp(r'^([0-9]*)?')),
            //   ]
            // : null,
            // ,
        validator: (value) {
          if ((value == null || value.isEmpty) && mandatory) {
            return 'Das ist ein Pflichtfeld';
          } else if (keyboardType == TextInputType.number) {
            if (!(isFloat(value!.replaceAll(',', '.')))) {
              return 'Nur Nummern sind erlaubt';
            }
          }

          return null;
        },
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
    );
  }
}
