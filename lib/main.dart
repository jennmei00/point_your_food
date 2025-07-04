// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punkte_zaehler/screens/diary/activities.dart';
import 'package:punkte_zaehler/screens/diary/edit_diary.dart';
import 'package:punkte_zaehler/screens/point_calculator.dart';
import 'package:punkte_zaehler/screens/settings/edit_activity.dart';
import 'package:punkte_zaehler/screens/settings/edit_food.dart';
import 'package:punkte_zaehler/screens/settings/profile.dart';
import 'package:punkte_zaehler/services/theme.dart';
import 'package:punkte_zaehler/services/theme_notifier.dart';
import 'package:punkte_zaehler/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  SharedPreferences.getInstance().then((prefs) {
    // var brightness = SchedulerBinding.instance.window.platformBrightness;
    // var darkModeOn = prefs.getBool('darkMode') ?? brightness == Brightness.dark;
    runApp(ChangeNotifierProvider(
      // create: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
      create: (_) => ThemeNotifier(lightTheme),
      child: const MyApp(),
    ));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return 
    // StreamProvider<UserAuth>.value(
    //   catchError: (context, error) {
    //     print(error);
    //     return UserAuth(uid: 'NULL');
    //   },
    //   value: AuthService().user,
    //   initialData: UserAuth(uid: 'NULL'),
    //   child: 
      MaterialApp(
          title: 'PointYourFood',
          theme: themeNotifier.getTheme(),
          home: const Wrapper(),
          // home: const ResetPassword(),
          routes: {
            EditFood.routeName: (context) => const EditFood(),
            EditActivity.routeName: (context) => const EditActivity(),
            Profile.routeName: (context) => const Profile(),
            // Login.routeName: (context) => const Login(),
            // Register.routeName: (context) => const Register(),
            // ResetPassword.routeName: (context) => const ResetPassword(),
            // ResetpassPage.routeName: (context) => const ResetpassPage(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == EditDiary.routeName) {
              final args = settings.arguments as List<dynamic>;

              return MaterialPageRoute(
                builder: (context) {
                  return EditDiary(
                    // type: PointType.values[args[0] as int],
                    date: args[0],
                    diaryId: args[1],
                  );
                },
              );
            } else if (settings.name == PointCalculator.routeName) {
              final args = settings.arguments as bool;

              return MaterialPageRoute(
                builder: (context) {
                  return PointCalculator(
                    fromSheet: args,
                  );
                },
              );
            } else if (settings.name == Activities.routeName) {
              final args = settings.arguments as String;

              return MaterialPageRoute(builder: (context) {
                return Activities(
                  diaryId: args,
                );
              });
            }

            return null;
          }
          // ),
    );
  }
}
