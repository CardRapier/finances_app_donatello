import 'package:finances_app_donatello/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ThemeUtils {
  static ThemeData getTheme() {
    return ThemeData().copyWith(
        primaryColor: ColorConstants.primaryColor,
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                backgroundColor: ColorConstants.primaryColor)),
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: ColorConstants.primaryColor,
            ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              const UnderlineInputBorder(borderSide: BorderSide(width: 0.5)),
          focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(width: 0.5, color: ColorConstants.primaryColor)),
        ));
  }
}
