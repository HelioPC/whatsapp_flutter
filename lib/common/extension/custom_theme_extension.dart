import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/common/utils/my_colors.dart';

extension ExtendedTheme on BuildContext {
  CustomThemeExtension get theme {
    return Theme.of(this).extension<CustomThemeExtension>()!;
  }
}

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  static CustomThemeExtension lightMode = CustomThemeExtension(
    circleImageColor: const Color(0xFF25D366),
    greyColor: MyColors.greyLight,
    blueColor: MyColors.blueLight,
    langBtnColor: const Color(0xFFF7F8FA),
    langBtnHighlightColor: const Color(0xFFE8E8ED),
    authAppbarTextColor: MyColors.greenLight,
    photoIconBgColor: const Color(0xFFF0F2F3),
    photoIconColor: const Color(0xFF9DAAB3),
  );

  static CustomThemeExtension darkMode = CustomThemeExtension(
    circleImageColor: MyColors.greenDark,
    greyColor: MyColors.greyLight,
    blueColor: MyColors.blueLight,
    langBtnColor: const Color(0xFF182229),
    langBtnHighlightColor: const Color(0xFF09141A),
    authAppbarTextColor: const Color(0xFFE9EDEF),
    photoIconBgColor: const Color(0xFF283339),
    photoIconColor: const Color(0xFF61717B),
  );

  final Color? circleImageColor;
  final Color? greyColor;
  final Color? blueColor;
  final Color? langBtnColor;
  final Color? langBtnHighlightColor;
  final Color? authAppbarTextColor;
  final Color? photoIconBgColor;
  final Color? photoIconColor;

  CustomThemeExtension({
    this.circleImageColor,
    this.greyColor,
    this.blueColor,
    this.langBtnColor,
    this.langBtnHighlightColor,
    this.authAppbarTextColor,
    this.photoIconBgColor,
    this.photoIconColor,
  });

  @override
  ThemeExtension<CustomThemeExtension> copyWith({
    Color? circleImageColor,
    Color? greyColor,
    Color? blueColor,
    Color? langBtnColor,
    Color? langBtnHighlightColor,
    Color? authAppbarTextColor,
    Color? photoIconBgColor,
    Color? photoIconColor,
  }) {
    return CustomThemeExtension(
      circleImageColor: circleImageColor ?? this.circleImageColor,
      greyColor: greyColor ?? this.greyColor,
      blueColor: blueColor ?? this.blueColor,
      langBtnColor: langBtnColor ?? this.langBtnColor,
      authAppbarTextColor: authAppbarTextColor ?? this.authAppbarTextColor,
      photoIconBgColor: photoIconBgColor ?? this.photoIconBgColor,
      photoIconColor: photoIconColor ?? this.photoIconColor,
      langBtnHighlightColor:
          langBtnHighlightColor ?? this.langBtnHighlightColor,
    );
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(
    covariant ThemeExtension<CustomThemeExtension>? other,
    double t,
  ) {
    if (other is! CustomThemeExtension) return this;

    return CustomThemeExtension(
      circleImageColor: Color.lerp(
        circleImageColor,
        other.circleImageColor,
        t,
      ),
      greyColor: Color.lerp(
        greyColor,
        other.greyColor,
        t,
      ),
      blueColor: Color.lerp(
        blueColor,
        other.blueColor,
        t,
      ),
      langBtnColor: Color.lerp(
        langBtnColor,
        other.langBtnColor,
        t,
      ),
      authAppbarTextColor: Color.lerp(
        authAppbarTextColor,
        other.authAppbarTextColor,
        t,
      ),
      langBtnHighlightColor: Color.lerp(
        langBtnHighlightColor,
        other.langBtnHighlightColor,
        t,
      ),
      photoIconBgColor: Color.lerp(
        photoIconBgColor,
        other.photoIconBgColor,
        t,
      ),
      photoIconColor: Color.lerp(
        photoIconColor,
        other.photoIconColor,
        t,
      ),
    );
  }
}
