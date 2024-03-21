import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
      primaryColor: AppColors.primaryColor,
      secondaryHeaderColor: AppColors.secondaryColor,
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: MyTextTheme.textTheme,
      elevatedButtonTheme: MyElevatedButtonThemeData.buttonThemeData,
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: AppColors.accentColor,),
      inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: AppColors.secondaryColor),
          hintStyle: TextStyle(color: AppColors.secondaryColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.accentColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.accentColor),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.accentColor),
          ),
          fillColor: AppColors.accentColor,
          filled: true),
      cardTheme: myCardTheme(),
      floatingActionButtonTheme: myFloatingActionButtonTheme(),
      bottomSheetTheme: myBottomSheetThemeData(),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.white
    )

  );

  static BottomSheetThemeData myBottomSheetThemeData() {
    return const BottomSheetThemeData(
        backgroundColor: AppColors.lightBackgroundColor);
  }

  static FloatingActionButtonThemeData myFloatingActionButtonTheme() {
    return const FloatingActionButtonThemeData(
        backgroundColor: AppColors.accentColor,
        foregroundColor: AppColors.primaryColor);
  }

  static CardTheme myCardTheme() {
    return CardTheme(
      color: AppColors.darkBackground,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: const BorderSide(color: AppColors.secondaryColor, width: 1)),
    );
  }
}

class MyTextTheme {
  static const TextTheme textTheme = TextTheme(
    headline6: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22,
      color: AppColors.secondaryColor,
      fontFamily: "OpenSans-ExtraBold",
    ),
    bodyText2: TextStyle(fontSize: 16, color: AppColors.textColor),
  );
}

class MyElevatedButtonThemeData {
  static final ElevatedButtonThemeData buttonThemeData =
      ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return AppColors.primaryColor.withOpacity(0.5);
          } else if (states.contains(MaterialState.disabled)) {
            return AppColors.disabledColor;
          }
          return AppColors.primaryColor; // Use the component's default.
        },
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
  );
}
