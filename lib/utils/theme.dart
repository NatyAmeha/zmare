import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static var Dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    // colorScheme: const ColorScheme.dark().copyWith(
    //   onSecondary: const Color(0xff000000),
    //   onPrimary: const Color(0xffffffff),
    //   primary: const Color(0xff000000),
    //   secondary: const Color(0xffffffff),
    // ),
    primarySwatch: Colors.green,
    appBarTheme: const AppBarTheme().copyWith(
      elevation: 4,
      color: const Color(0xff000000),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData().copyWith(
      color: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
      backgroundColor: Colors.black,
      elevation: 2,
      selectedItemColor: Colors.green,
    ),

    textTheme: GoogleFonts.robotoCondensedTextTheme(const TextTheme()).copyWith(
      displayLarge: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      displayMedium: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      displaySmall: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),

      titleLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: const TextStyle(fontSize: 17),
      titleSmall: const TextStyle(fontSize: 16),
      // subtitle1: const TextStyle(fontSize: 17),
      // subtitle2: const TextStyle(fontSize: 14),
      bodyLarge: const TextStyle(fontSize: 17, color: Colors.grey),
      bodyMedium: const TextStyle(fontSize: 15, color: Colors.grey),
      bodySmall: const TextStyle(fontSize: 13, color: Colors.grey),
    ),
  );

  // static final Dark = ThemeData(
  //   scaffoldBackgroundColor: Colors.black,
  //   iconTheme: IconThemeData(color: Colors.white, opacity: 0.7),
  //   appBarTheme: AppBarTheme(backgroundColor: Colors.black, elevation: 6 ,centerTitle: ),
  //   colorScheme: const ColorScheme.dark(),
  //   primarySwatch: Colors.green,

  // );

  static final Light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    // colorScheme: const ColorScheme.light().copyWith(
    //   onSecondary: const Color(0xffffffff),
    //   onPrimary: const Color(0xff000000),
    //   primary: const Color(0xffffffff),
    //   secondary: const Color(0xff000000),
    // ),
    primarySwatch: Colors.green,

    // bottomAppBarColor: Colors.grey,
    backgroundColor: Colors.grey[300],

    // progressIndicatorTheme:
    //     const ProgressIndicatorThemeData().copyWith(color: Colors.black),

    appBarTheme: const AppBarTheme().copyWith(
      elevation: 4,
      color: Colors.white,
      titleTextStyle: const TextStyle(color: Colors.black, fontSize: 17),
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
      selectedItemColor: Colors.green,
      elevation: 2,
    ),
    textTheme: GoogleFonts.robotoCondensedTextTheme(const TextTheme()).copyWith(
      displayLarge: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      displayMedium: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      displaySmall: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),

      titleLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: const TextStyle(fontSize: 17),
      titleSmall: const TextStyle(fontSize: 16),
      // subtitle1: const TextStyle(fontSize: 17),
      // subtitle2: const TextStyle(fontSize: 14),
      bodyLarge: const TextStyle(fontSize: 17, color: Colors.grey),
      bodyMedium: const TextStyle(fontSize: 15, color: Colors.grey),
      bodySmall: const TextStyle(fontSize: 13, color: Colors.grey),
    ),
  );

// OutlinedButton Setting.
// theme = theme.copyWith(
//   outlinedButtonTheme: OutlinedButtonThemeData(
//     style: ButtonStyle(
//       side: MaterialStateProperty.resolveWith(
//         (states) {
//           var isDisabled = states.contains(MaterialState.disabled);
//           return BorderSide(
//             width: 0.0,
//           );
//         },
//       ),
//     ),
//   ),
// );
// CheckBox Setting.

// Radio Setting.

// Switch Setting.

// Slider Setting.
// theme = theme.copyWith(
//   sliderTheme: theme.sliderTheme.copyWith(
//     thumbColor: const Color(0xff000000),
//     overlayColor: const Color(0xff000000).withOpacity(.15),
//     activeTrackColor: const Color(0xff000000),
//     inactiveTrackColor: const Color(0xff000000).withOpacity(.3),
//     valueIndicatorColor: const Color(0xff000000),
//   ),
// );
// Appbar Setting.

}
