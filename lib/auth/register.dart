import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:punkte_zaehler/auth/login.dart';
import 'package:punkte_zaehler/services/firebase/auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static const routeName = '/register';

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/register.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Konto\nerstellen',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.20,
                    left: 35,
                    right: 35,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // const CircleAvatar(
                        // foregroundColor: Colors.black,
                        // radius: 40,
                        // child:
                        const Icon(
                          Icons.account_circle_rounded,
                          size: 100,
                          color: Colors.black,
                        ),
                        // ),
                        const SizedBox(height: 30.0),
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Bitte Name eingeben';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            fillColor: Colors.grey[300],
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Bitte Email eingeben';
                            } else if (!value.contains('@')) {
                              return 'Keine gültige Email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Bitte Passwort eingeben';
                            } else if (value.length <= 6) {
                              return 'mind. 6 Zeichen';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Passwort',
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            // hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () => register(),
                              child: const Text(
                                'Registrieren',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => register(),
                              icon: const Icon(
                                  CommunityMaterialIcons.arrow_right_bold),
                              iconSize: 30,
                            )
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () => toLogin(),
                              child: const Text(
                                'Anmelden',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  toLogin() {
    Navigator.popAndPushNamed(context, Login.routeName);
  }

  register() {
    if (formKey.currentState!.validate()) {
      AuthService().registerWithEmailAndPassword(
          emailController.text, passwordController.text, context);

      AuthService().sendEmailVerification();
    }
  }
}
