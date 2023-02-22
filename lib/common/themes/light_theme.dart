import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_flutter/common/utils/my_colors.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    colorScheme: const ColorScheme.light(
      background: MyColors.backgroundLight,
    ),
    scaffoldBackgroundColor: MyColors.backgroundLight,
    extensions: [CustomThemeExtension.lightMode],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.greenLight,
        foregroundColor: MyColors.backgroundLight,
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
  );
}
