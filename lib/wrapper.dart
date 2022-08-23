import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punkte_zaehler/auth/login.dart';
import 'package:punkte_zaehler/auth/user.dart';
import 'package:punkte_zaehler/screens/start_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    // final user = Provider.of<User>(context);
    // print(user);
    return 
    // user == null ? const Login()
     const StartScreen();
  }
}