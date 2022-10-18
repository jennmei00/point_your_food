import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:punkte_zaehler/auth/login.dart';
import 'package:punkte_zaehler/auth/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  UserAuth _userfromFirebaseUser(User? user) {
    return user == null ? UserAuth(uid: 'NULL') : UserAuth(uid: user.uid);
  }

  //auth change user stream
  Stream<UserAuth> get user {
    return _auth.userChanges().map(_userfromFirebaseUser);
  }

  // check if user is currently signed out or signed in
  bool userSignedIn() {
    bool? signedIn;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        signedIn = false;
        print('User is currently signed out!');
      } else {
        signedIn = true;
        print('User is signed in!');
      }
    });

    return signedIn!;
  }

  // register with email & password
  Future registerWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      print('Halloo');
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Passwort ist zu schwach'),
          backgroundColor: Colors.red,
        ));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email existiert bereits\nMelde dich stattdessen an'),
          backgroundColor: Colors.red,
        ));
      } else if (e.code == 'invalid-email') {
        print('Invalid Email');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Ungültige Email'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email nicht registiert'),
          backgroundColor: Colors.red,
        ));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Falsches Passwort'),
          backgroundColor: Colors.red,
        ));
      } else if (e.code == 'invalid-email') {
        print('Invalid Email');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Ungültige Email'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future sendEmailVerification() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  // reset Password
  Future resetPassword(String email, BuildContext context) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email).then((value) {
        Navigator.popAndPushNamed(context, Login.routeName);
      });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email nicht registiert'),
          backgroundColor: Colors.red,
        ));
      } else if (e.code == 'invalid-email') {
        print('Invalid Email');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Ungültige Email'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
