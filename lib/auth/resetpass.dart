// import 'package:community_material_icon/community_material_icon.dart';
// import 'package:flutter/material.dart';
// import 'package:punkte_zaehler/auth/login.dart';
// import 'package:punkte_zaehler/auth/register.dart';
// import 'package:punkte_zaehler/services/firebase/auth.dart';

// class ResetPassword extends StatefulWidget {
//   const ResetPassword({Key? key}) : super(key: key);
//   static const routeName = '/resetpass';

//   @override
//   ResetPasswordState createState() => ResetPasswordState();
// }

// class ResetPasswordState extends State<ResetPassword> {
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   TextEditingController emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(
//               'assets/register.png',
//             ),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Stack(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.only(
//                       top: 60.0,
//                       left: 25.0,
//                     ),
//                     child: const Text(
//                       'Passwort\nvergessen',
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 35.0,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SingleChildScrollView(
//                 child: Container(
//                   padding: EdgeInsets.only(
//                     top: MediaQuery.of(context).size.height * 0.5,
//                     left: 35,
//                     right: 35,
//                   ),
//                   child: Form(
//                     key: formKey,
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           controller: emailController,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Bitte Email eingeben';
//                             } else if (!value.contains('@')) {
//                               return 'Keine gültige Email';
//                             }
//                             return null;
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Email',
//                             fillColor: Colors.grey.shade100,
//                             filled: true,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20.0),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             TextButton(
//                               onPressed: () => resetPass(),
//                               child: const Text(
//                                 'Passwort zurücksetzen',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () => resetPass(),
//                               icon: const Icon(
//                                   CommunityMaterialIcons.arrow_right_bold),
//                               iconSize: 30,
//                             )
//                           ],
//                         ),
//                         const SizedBox(height: 15.0),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             TextButton(
//                               onPressed: () => toLogin(),
//                               child: const Text(
//                                 'Anmelden',
//                                 style: TextStyle(
//                                   fontStyle: FontStyle.italic,
//                                   fontWeight: FontWeight.w100,
//                                 ),
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () => toRegister(),
//                               child: const Text(
//                                 'Registrieren',
//                                 style: TextStyle(
//                                   fontStyle: FontStyle.italic,
//                                   fontWeight: FontWeight.w100,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   toLogin() {
//     Navigator.popAndPushNamed(context, Login.routeName);
//   }

//   toRegister() {
//     Navigator.popAndPushNamed(context, Register.routeName);
//   }

//   resetPass() {
//     if (formKey.currentState!.validate()) {
//       AuthService().resetPassword(emailController.text, context);
//     }
//   }
// }
