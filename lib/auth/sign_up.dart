import 'package:flutter/material.dart';
import 'package:punkte_zaehler/auth/resetpass.dart';
import 'package:punkte_zaehler/auth/resetpass_page.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/services/firebase/auth.dart';
import 'package:punkte_zaehler/services/db_helper.dart';
import 'package:punkte_zaehler/services/theme.dart';
import 'package:punkte_zaehler/widgets/signup/custom_button_signup.dart';
import 'package:punkte_zaehler/widgets/signup/custom_textfield_signup.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> fieldKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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

  String? validatePassword(String? input) {
    if (input == null || input.isEmpty) {
      return "Bitte Passwort eingeben";
    } else if (input.length >= 6) {
      passwordController.text = input;
      return null;
    } else {
      return "Passwort ist zu kurz";
    }
  }

  String? validateName(String? input) {
    if (input == null || input.isEmpty) {
      return "Bitte Name eingeben";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      // backgroundColor: themeData.primaryColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            "Wilkommen",
            style: themeData.textTheme.headline1!.copyWith(
                fontSize: 50, fontWeight: FontWeight.w500, letterSpacing: 4),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Bitte registrieren oder anmelden",
            style: themeData.textTheme.headline1!.copyWith(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 4),
          ),
          const SizedBox(
            height: 80,
          ),
          Form(
            key: fieldKey,
            child: CustomTextFieldSignUp(
              labelText: 'Name',
              controller: nameController,
              validator: (val) => validateName(val),
              obscureText: false,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFieldSignUp(
                    labelText: 'E-Mail',
                    controller: emailController,
                    validator: (val) => validateEmail(val),
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldSignUp(
                    labelText: 'Passwort',
                    controller: passwordController,
                    validator: (val) => validatePassword(val),
                    obscureText: true,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                        onPressed: () => toResetpass(),
                        child: const Text(
                          'Passwort vergessen',
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 3,
                              fontSize: 10),
                        )),
                  ),
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          CustomButtonSignup(
            text: 'Anmelden',
            onPressed: () => login(),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButtonSignup(
            text: 'Registrieren',
            onPressed: () => register(),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {},
              child: const Text(
                'Ohne Registrierung fortfahren',
                style: TextStyle(color: Colors.white, letterSpacing: 2),
              ))
        ],
      ),
    );
  }

  login() {
    if (_formKey.currentState!.validate()) {
      AuthService().signInWithEmailAndPassword(
          emailController.text, passwordController.text, context);
    }
  }

  register() {
    if (fieldKey.currentState!.validate()) {
      if (_formKey.currentState!.validate()) {
        AuthService()
            .registerWithEmailAndPassword(
                emailController.text, passwordController.text, context)
            .then((value) async {
          AllData.profiledata.name = nameController.text;
          await DBHelper.update('Profiledata', AllData.profiledata.toMap());
        });
      }
    }
  }

  toResetpass() {
    Navigator.pushNamed(context, ResetpassPage.routeName);
  }
}
