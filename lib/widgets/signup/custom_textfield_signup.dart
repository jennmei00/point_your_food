import 'package:flutter/material.dart';

class CustomTextFieldSignUp extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final Function validator;
  final bool obscureText;

  const CustomTextFieldSignUp({
    Key? key,
    this.labelText = '',
    this.hintText = '',
    required this.controller,
    required this.validator,
    required this.obscureText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white),
          floatingLabelStyle: const TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                // color: Theme.of(context).colorScheme.secondary,
                color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.3))),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        controller: controller,
        validator: (val) => validator(val),
      ),
    );
  }
}
