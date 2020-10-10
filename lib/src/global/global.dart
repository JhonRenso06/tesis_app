import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Global {
  static const double radius = 18;
  static const double horizontalPadding = 12;
  static const double verticalPadding = 14;
  static const String fontFamily = 'Quicksand';
  static DateFormat formatter = DateFormat("dd/MM/yyyy");
  static Color get primaryColor {
    return Colors.white;
  }

  static Color get primaryColorDark {
    return Color(0xFFCCCCCC);
  }

  static Color get primaryColorLight {
    return Colors.white;
  }

  static Color get accentColor {
    return Color(0xFF870000);
  }

  static Color get buttonColor {
    return Color(0xFF870000);
  }

  static Color get splashColor {
    return Color(0xFF870000).withOpacity(0.3);
  }

  static ButtonThemeData get buttonTheme {
    return ButtonThemeData(
        padding: const EdgeInsets.only(
          bottom: verticalPadding,
          top: verticalPadding,
          right: horizontalPadding,
          left: horizontalPadding,
        ),
        buttonColor: Global.accentColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ));
  }

  static InputDecorationTheme get inputDecorationTheme {
    return InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: Global.accentColor),
      ),
      filled: false,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: Colors.black),
      ),
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      contentPadding: const EdgeInsets.only(
        bottom: verticalPadding,
        top: verticalPadding,
        right: horizontalPadding,
        left: horizontalPadding,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  static AppBarTheme get appBarTheme {
    return AppBarTheme(
      centerTitle: true,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: accentColor,
          fontSize: 21,
          fontFamily: fontFamily,
        ),
      ),
      iconTheme: IconThemeData(
        color: accentColor,
      ),
    );
  }

  static MaterialColor get primarySwatch {
    Map<int, Color> coloresCodes = {
      50: Color(0xFFf9e7e9),
      100: Color(0xFFf0c3c5),
      200: Color(0xFFd58a86),
      300: Color(0xFFc05e5a),
      400: Color(0xFFc33c34),
      500: Color(0xFFc02917),
      600: Color(0xFFb31f18),
      700: Color(0xFFa31513),
      800: Color(0xFF960d0d),
      900: Color(0xFF870000)
    };
    return MaterialColor(0xFF870000, coloresCodes);
  }

  static String dateFormatter(DateTime date) {
    return formatter.format(date);
  }
}
