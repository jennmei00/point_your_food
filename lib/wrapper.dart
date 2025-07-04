// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:punkte_zaehler/auth/login.dart';
// import 'package:punkte_zaehler/auth/user.dart';
import 'package:punkte_zaehler/screens/start_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const StartScreen();
    // AuthService().signOut();
    // final user = Provider.of<UserAuth>(context);
    // AllData.user = user;
    // return SignUpPage();
    // return user.uid == 'NULL' ? const SignUpPage() : const StartScreen();
    // print(FirebaseAuth.instance.currentUser!.emailVerified);
  }
}
