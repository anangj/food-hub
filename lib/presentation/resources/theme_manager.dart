import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/font_manager.dart';
import 'package:tut_app/presentation/resources/style_manager.dart';
import 'package:tut_app/presentation/resources/value_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main color to app
    primaryColor: ColorManagar.primary,
    primaryColorLight: ColorManagar.primaryWithOpacity70,
    primaryColorDark: ColorManagar.darkPrimary,
    disabledColor: ColorManagar.grey1,
    splashColor: ColorManagar.primaryWithOpacity70,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: ColorManagar.grey,
    ),

    //card view theme
    cardTheme: CardTheme(
      color: ColorManagar.white,
      shadowColor: ColorManagar.grey,
      elevation: AppSize.s4,
    ),

    //app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManagar.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManagar.primaryWithOpacity70,
      titleTextStyle: getRegularStyle(
        color: ColorManagar.white,
        fontSize: FontSize.s16,
      ),
    ),

    //button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManagar.grey1,
      buttonColor: ColorManagar.primary,
      splashColor: ColorManagar.primaryWithOpacity70,
    ),

    //elevation button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorManagar.white),
        primary: ColorManagar.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),

    //text theme
    textTheme: TextTheme(
      headline1: getSemiBoldStyle(
          color: ColorManagar.darkGrey, fontSize: FontSize.s16),
      subtitle1:
          getMediumStyle(color: ColorManagar.lightGrey, fontSize: FontSize.s14),
      caption: getRegularStyle(color: ColorManagar.grey1),
      bodyText1: getRegularStyle(color: ColorManagar.grey),
    ),

    //input decoration text field
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(color: ColorManagar.grey1),
      labelStyle: getMediumStyle(color: ColorManagar.darkGrey),
      errorStyle: getRegularStyle(color: ColorManagar.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManagar.grey, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManagar.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManagar.error, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManagar.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
    ),
  );
}
