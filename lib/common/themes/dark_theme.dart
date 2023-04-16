import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    appBarTheme: const AppBarTheme(
      backgroundColor: MyColors.greyBackground,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: MyColors.greyDark,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(color: MyColors.greyDark),
    ),
    tabBarTheme: const TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: MyColors.greenDark,
          width: 2,
        ),
      ),
      unselectedLabelColor: MyColors.greyDark,
      labelColor: MyColors.greenDark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.greenDark,
        foregroundColor: MyColors.backgroundDark,
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: MyColors.greyBackground,
      modalBackgroundColor: MyColors.greyBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    dialogBackgroundColor: MyColors.greyBackground,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
