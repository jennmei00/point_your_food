import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punkte_zaehler/screens/diary/activities.dart';
import 'package:punkte_zaehler/screens/diary/edit_diary.dart';
import 'package:punkte_zaehler/screens/point_calculator.dart';
import 'package:punkte_zaehler/screens/start_screen.dart';
import 'package:punkte_zaehler/services/theme.dart';
import 'package:punkte_zaehler/services/theme_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
        title: 'Flutter Demo',
        theme: themeNotifier.getTheme(),
        home: const StartScreen(),
        // routes: {
        //   // PointCalculatorScreen.routeName: (context) => const PointCalculatorScreen(),
        // },
        onGenerateRoute: (settings) {
          if (settings.name == EditDiary.routeName) {
            final args = settings.arguments as List<dynamic>;

            return MaterialPageRoute(
              builder: (context) {
                return EditDiary(
                  // type: PointType.values[args[0] as int],
                  date: args[0],
                  diaryID: args[1],
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
        });
  }
}
