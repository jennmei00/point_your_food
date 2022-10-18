import 'package:flutter/material.dart';
import 'package:punkte_zaehler/auth/resetpass.dart';
import 'package:punkte_zaehler/services/firebase/auth.dart';
import 'package:punkte_zaehler/services/theme.dart';
import 'package:punkte_zaehler/widgets/signup/custom_button_signup.dart';
import 'package:punkte_zaehler/widgets/signup/custom_textfield_signup.dart';

class ResetpassPage extends StatefulWidget {
  const ResetpassPage({super.key});
  static const routeName = '/resetpass_page';

  @override
  State<ResetpassPage> createState() => _ResetpassPageState();
}

class _ResetpassPageState extends State<ResetpassPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  String? validateEmail(String? input) {
    const emailRegex =
        r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

    if (input == null || input.isEmpty) {
      return "Bitte Email eingeben";
    } else if (RegExp(emailRegex).hasMatch(input)) {
      emailController.text = input;
      return null;
    } else {
      return "Ungültige Email";
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(
              height: 80,
            ),
            Text(
              "Zurücksetzen",
              style: themeData.textTheme.headline1!.copyWith(
                  fontSize: 50, fontWeight: FontWeight.w500, letterSpacing: 4),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "E-Mail eingeben und Passwort zurücksetzen",
              style: themeData.textTheme.headline1!.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 4),
            ),
            const SizedBox(
              height: 80,
            ),
            CustomTextFieldSignUp(
              labelText: 'E-Mail',
              controller: emailController,
              validator: (val) => validateEmail(val),
              obscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 40,
            ),
            CustomButtonSignup(
              text: 'Zurücksetzen',
              onPressed: () => resetPass(),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  resetPass() async {
    if (_formKey.currentState!.validate()) {
      AuthService().resetPassword(emailController.text, context).then((value) {
        if (value != null) {
          Navigator.of(context).pop();
        }
      });
    }
  }
}
