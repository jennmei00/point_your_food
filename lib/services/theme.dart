import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:haushaltsbuch/services/input_theme.dart';

const TextTheme textTheme = TextTheme(
  displayLarge: TextStyle(color: Colors.white),
  // displayLarge: GoogleFonts.raleway(
  //     fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  // headline2: GoogleFonts.raleway(
  //     fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  // headline3: GoogleFonts.raleway(fontSize: 48, fontWeight: FontWeight.w400),
  // headline4: GoogleFonts.raleway(
  //     fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  // headline5: GoogleFonts.raleway(fontSize: 24, fontWeight: FontWeight.w400),
  // headline6: GoogleFonts.raleway(
  //     fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  // subtitle1: GoogleFonts.raleway(
  //     fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  // subtitle2: GoogleFonts.raleway(
  //     fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  // bodyText1: GoogleFonts.sourceCodePro(
  //     fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  // bodyText2: GoogleFonts.sourceCodePro(
  //     fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  // button: GoogleFonts.sourceCodePro(
  //     fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  // caption: GoogleFonts.sourceCodePro(
  //     fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  // overline: GoogleFonts.sourceCodePro(
  //     fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

// //Colors for the calender in the diary
// const Color calenderDayColor = Color.fromRGBO(7, 17, 69, 27);
// const Color calenderActiveDayColor = Color.fromARGB(255, 238, 178, 178);
// const Color calenderActiveBackgroundDayColor = Color.fromARGB(255, 107, 16, 7);
// const Color calenderDotsColor = Color.fromARGB(255, 58, 66, 82);

Color calenderDayColor = HexColor('#052A5C').withOpacity(0.4);
Color calenderActiveDayColor = HexColor('#052A5C').withOpacity(0.4);
const Color calenderActiveBackgroundDayColor = Color.fromARGB(200, 4, 58, 82);
//  Color.fromRGBO(7, 17, 69, 27);
const Color calenderDotsColor = Color.fromARGB(255, 58, 66, 82);

//Colors for the card in the diary
//RED
// Color activityCardColor = HexColor('#A60505').withOpacity(0.4);
// Color activityAddCardColor = HexColor('#591D1D').withOpacity(0.5);
// Color breakfastCardColor = HexColor('#A60505').withOpacity(0.4);
// Color lunchCardColor = HexColor('#591D1D').withOpacity(0.5);
// Color dinnerCardColor = HexColor('#D90707').withOpacity(0.5);
// Color snackCardColor = HexColor('##EE4F4F').withOpacity(0.2);
//BLUE
Color activityCardColor = HexColor('#052A5C').withOpacity(0.4);
Color activityAddCardColor = HexColor('#043A52').withOpacity(0.5);
Color breakfastCardColor = HexColor('#052A5C').withOpacity(0.4);
Color lunchCardColor = HexColor('#043A52').withOpacity(0.5);
Color dinnerCardColor = HexColor('#0D055C').withOpacity(0.5);
Color snackCardColor = HexColor('#210452').withOpacity(0.2);

ColorScheme colorSchemeLight = ColorScheme.light(
  primary: HexColor('#183446'),
  // secondary: Color.fromARGB(200, 4, 58, 82),
  secondary: HexColor('38AECC'),
  background: Colors.white, //(0xffFCE4EC),
  onSecondary: Colors.black,
  onPrimary: Colors.white,
  //surface: //for example backgroundcolor of the snackbar
);

CardTheme cardThemeLight = CardTheme(
  color: HexColor('#D9D9D9'),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
);

final lightTheme = ThemeData(
    textTheme: textTheme,
    colorScheme: colorSchemeLight,
    primaryColor: colorSchemeLight.primary,
    primaryColorLight: colorSchemeLight.primary,
    primaryColorDark: colorSchemeLight.primary,
    primarySwatch: Colors.grey,
    brightness: colorSchemeLight.brightness,
    scaffoldBackgroundColor: colorSchemeLight.background,
    // appBarTheme: AppBarTheme(backgroundColor: Colors.red[900]),
    // toggleableActiveColor: colorSchemeLight
    //     .secondary, //for example: aktiveColor of the Switch-Widget  //DEPRECATED
    indicatorColor: Colors.white, //for example: of the TabBar
    //floatingActionButtonTheme: FloatingActionButtonThemeData(extendedTextStyle: TextStyle(color: colorSchemeLight.onSecondary)),
    //splashColor: Color(0xffbc477b),
    // cardTheme: CardTheme(
    //   color: Color(0xffeeeeee),
    // ),
    // inputDecorationTheme: InputTheme().theme(colorSchemeLight),
    snackBarTheme: const SnackBarThemeData(
        actionTextColor: Color.fromARGB(199, 88, 170, 206)),
    cardTheme: cardThemeLight);

const ColorScheme colorSchemeDark = ColorScheme.dark(
  primary: Color(0xff7cc0d8), //Color(0xffc5e1a5),
  secondary: Color(0xff3ba1c5),
  onPrimary: Colors.black,
  onSecondary: Colors.black,
  // primary: Color(0xff78AD68),
  // primaryVariant: Color(0xffa8df97),
  // secondaryVariant: Color(0xffbc477b),
  // secondary: Color(0xff560027),
);

final darkTheme = ThemeData(
    primaryColor: colorSchemeDark.secondary,
    primaryColorDark: const Color(0xff1a6985), //Color(0xff94af76),
    //textTheme: textTheme,
    colorScheme: colorSchemeDark,
    scaffoldBackgroundColor: Colors.grey.shade900,
    iconTheme: IconThemeData(
      color: Colors.grey.shade500,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorSchemeDark.secondary,
    ),
    // toggleableActiveColor: colorSchemeDark.secondary, //DEPRECATED
    // inputDecorationTheme: InputTheme().theme(colorSchemeDark),
    indicatorColor: colorSchemeDark.secondary);
