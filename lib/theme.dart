
import 'package:flutter/material.dart';

final defaultTheme = ThemeData(
  scaffoldBackgroundColor: ProjectColors.background,
  fontFamily: 'SF UI Display',
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color:Colors.white
      ),
      bodyLarge: TextStyle(
        color:Colors.white
      ),
      titleLarge: TextStyle(
        color: Colors.white
      )
    ),
    primaryColor: ProjectColors.primaryVariant,
  indicatorColor: ProjectColors.primaryVariant,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ProjectColors.primaryVariant,
      foregroundColor: Colors.black,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'SF UI Display',
        fontSize: 24,
        height: 1.2,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10.5,horizontal: 46
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minimumSize: const Size(0,50)
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: ProjectColors.disabled,
      side:const BorderSide(
        color: ProjectColors.disabled,
      ),
      disabledBackgroundColor: ProjectColors.disabled,
      disabledForegroundColor: ProjectColors.secondaryVariant,
      textStyle: const TextStyle(
        fontFamily: 'SF UI Display',
        fontSize: 24,
      ),
        padding: const EdgeInsets.symmetric(
        vertical: 8,horizontal: 0)
    )
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ProjectColors.primaryVariant,
    foregroundColor: ProjectColors.secondaryVariant,
    iconSize: 40
  ),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8 ),
    ),
    color: const Color(0xFFf1f0f0)
  ),
  checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return ProjectColors.disabled;
        }
        return Colors.transparent;
      }),
    //TODO custom checkbox
    checkColor: const WidgetStatePropertyAll(ProjectColors.secondaryVariant),
    side: const BorderSide(
      width: 1,
      color: ProjectColors.secondaryVariant,
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: ProjectColors.primaryVariant
    )
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
  ),
  radioTheme: const RadioThemeData(

  ),
);

class ProjectColors{
  static const Color background=Color(0xFF1F1F1F);
  static const Color primaryVariant=Color(0xFFFFD600);
  static const Color secondaryVariant=Color(0xFF383838);
  static const Color disabled=Color(0xfffbefb4);

  static const Color accentRed=Color(0xFFF2C8C8);
}