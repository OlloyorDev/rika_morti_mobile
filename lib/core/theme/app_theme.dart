import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rika_morti_mobile/core/theme/color/app_colors.dart';
import 'package:rika_morti_mobile/core/theme/color_scheme/color_scheme.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'PublicSans',
  applyElevationOverlayColor: true,
  splashFactory: Platform.isAndroid
      ? InkRipple.splashFactory
      : NoSplash.splashFactory,
  visualDensity: VisualDensity.standard,
  materialTapTargetSize: MaterialTapTargetSize.padded,
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.zero),
    ),
  ),
  dividerTheme: const DividerThemeData(thickness: 1),
);

final ThemeData lightTheme = appTheme.copyWith(
  applyElevationOverlayColor: true,
  visualDensity: VisualDensity.standard,
  materialTapTargetSize: MaterialTapTargetSize.padded,
  dividerTheme: const DividerThemeData(thickness: 1),
  colorScheme: lightColorScheme,
  scaffoldBackgroundColor: lightColorScheme.surface,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: lightColorScheme.surface,
    selectedItemColor: AppColors.black,
    unselectedItemColor: AppColors.lightInactiveIcon,
    selectedLabelStyle: TextStyle(color: AppColors.darkInactiveIcon),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black87),
    bodySmall: TextStyle(color: Colors.black87),
  ),
);

final ThemeData darkTheme = appTheme.copyWith(
  applyElevationOverlayColor: true,
  visualDensity: VisualDensity.standard,
  materialTapTargetSize: MaterialTapTargetSize.padded,
  dividerTheme: const DividerThemeData(thickness: 1),
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkColorScheme.surface,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: darkColorScheme.surface,
    selectedItemColor: AppColors.white,
    unselectedItemColor: AppColors.darkInactiveIcon,
    selectedLabelStyle: TextStyle(color: AppColors.darkInactiveIcon),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white70),
    bodyMedium: TextStyle(color: Colors.white70),
    bodySmall: TextStyle(color: Colors.white70),
  ),
);
