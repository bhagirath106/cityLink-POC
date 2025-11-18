import 'package:cgc_project/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'color_contanst.dart';

///Theming that is being used across the application.
class AppTheme {
  AppTheme();

  static ThemeData buildTheme(Size size) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: kBlackShade,
      primary: kBlackShade,
      onPrimary: kLightSkyBlue,
      primaryContainer: kDarkWhite,
      onPrimaryContainer: kDarkLightWhite,
      onSecondary: kDarkBlue,
      onSecondaryContainer: kLightRed,
      secondaryContainer: iconBorderColor,
      secondary: kWhite,
      tertiary: kTransparent,
      tertiaryContainer: kBlue,
      onTertiary: kLightWhite,
      onTertiaryContainer: kLightGrey,
      surfaceContainer: kLightShadeBlue,
      outlineVariant: pending,
      surface: kDarkPink,
      onSurface: kOrangeColor,
      inverseSurface: kLightOrange,
      inversePrimary: kOrange,
      onSurfaceVariant: createTeamCardColor2,
      surfaceTint: kAlertColor,
    );

    final ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryColor: kBlack,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: kWhite,
      appBarTheme: AppBarTheme(
        backgroundColor: kDarkBlue,
        foregroundColor: kWhite,
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: colorScheme.tertiaryContainer,
      ),
      cardTheme: CardThemeData(color: colorScheme.secondary, elevation: 1),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.pink; // outer circle when selected
          }
          return Colors.pink; // outer circle when unselected
        }),
      ),
      iconTheme: const IconThemeData(size: 16, color: kWhite),
      textTheme: CustomTextStyles.buildTextTheme(base.textTheme, size),
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: kWhite),
      expansionTileTheme: const ExpansionTileThemeData(
        iconColor: kWhite,
        collapsedIconColor: kWhite,
        textColor: kWhite,
        collapsedTextColor: kWhite,
      ),
    );
  }
}
