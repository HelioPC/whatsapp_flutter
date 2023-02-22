import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_flutter/common/utils/my_colors.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();

  return base.copyWith(
    colorScheme: const ColorScheme.dark(
      background: MyColors.backgroundDark,
    ),
    scaffoldBackgroundColor: MyColors.backgroundDark,
    extensions: [CustomThemeExtension.darkMode],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.greenDark,
        foregroundColor: MyColors.backgroundDark,
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
  );
}
