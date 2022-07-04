import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:punkte_zaehler/navigation.dart';
import 'package:punkte_zaehler/services/theme.dart';
import 'package:punkte_zaehler/services/theme_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    var darkModeOn = prefs.getBool('darkMode') ?? brightness == Brightness.dark;
    runApp(ChangeNotifierProvider(
      create: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
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
      home: const Navigation(),
      // routes: {
      //   // PointCalculatorScreen.routeName: (context) => const PointCalculatorScreen(),
      // },
    );
  }
}
