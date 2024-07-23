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
        textStyle: WidgetStateProperty.resolveWith(
            (states) => const TextStyle(letterSpacing: 5)),
        foregroundColor:
            WidgetStateProperty.resolveWith((states) => Colors.black),
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) =>
              // Theme.of(context).colorScheme.secondary
              const Color.fromRGBO(74, 217, 217, 1),
        
        ),
      ),
      child: Text(text),
    );
  }
}
