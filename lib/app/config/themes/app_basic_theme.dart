import 'package:flutter/material.dart';
Map<int, Color> primarycolor =
{
  50:Color.fromRGBO(14, 200, 116, .1),
  100:Color.fromRGBO(14, 200, 116, .2),
  200:Color.fromRGBO(14, 200, 116, .3),
  300:Color.fromRGBO(14, 200, 116, .4),
  400:Color.fromRGBO(14, 200, 116, .5),
  500:Color.fromRGBO(14, 200, 116, .6),
  600:Color.fromRGBO(14, 200, 116, .7),
  700:Color.fromRGBO(14, 200, 116, .8),
  800:Color.fromRGBO(14, 200, 116, .9),
  900:Color.fromRGBO(14, 200, 116, 1),
};
abstract class AppBasicTheme {

  static ThemeData getThemeData() {
    return ThemeData(
      fontFamily: "lato",
      primaryColor: Color(0xff0ec874),
      primarySwatch: MaterialColor(0xFF0ec874,primarycolor),
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.grey[800])),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[200],
        errorStyle: TextStyle(fontSize: 0),
        errorMaxLines: 1,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
      ),
    );
  }
}
