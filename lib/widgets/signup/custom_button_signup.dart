import 'package:flutter/material.dart';

class CustomButtonSignup extends StatelessWidget {
  final String text;
  final Function onPressed;

  const CustomButtonSignup({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
        textStyle: MaterialStateTextStyle.resolveWith(
            (states) => TextStyle(letterSpacing: 5)),
        foregroundColor:
            MaterialStateColor.resolveWith((states) => Colors.black),
        backgroundColor: MaterialStateColor.resolveWith(
          (states) =>
              // Theme.of(context).colorScheme.secondary
              Color.fromRGBO(74, 217, 217, 1),
        
        ),
      ),
      child: Text(text),
    );
  }
}
