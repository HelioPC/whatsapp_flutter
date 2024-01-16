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
    profilePageBg: const Color(0xFFF7F8FA),
    chatTextFieldBg: Colors.white,
    chatPageBgColor: const Color(0xFFEFE7DE),
    chatPageDoodleColor: Colors.white70,
    senderChatCardBg: const Color(0xFFE7FFDB),
    receiverChatCardBg: const Color(0xFFFFFFFF),
    yellowCardBgColor: const Color(0xFFFFEECC),
    yelloCardTextColor: const Color(0xFF13191C),
  );

  static CustomThemeExtension darkMode = CustomThemeExtension(
    circleImageColor: MyColors.greenDark,
    greyColor: MyColors.greyDark,
    blueColor: MyColors.blueLight,
    langBtnColor: const Color(0xFF182229),
    langBtnHighlightColor: const Color(0xFF09141A),
    authAppbarTextColor: const Color(0xFFE9EDEF),
    photoIconBgColor: const Color(0xFF283339),
    photoIconColor: const Color(0xFF61717B),
    profilePageBg: const Color(0xFF0B141A),
    chatTextFieldBg: MyColors.greyBackground,
    chatPageBgColor: const Color(0xFF081419),
    chatPageDoodleColor: const Color(0xFF172428),
    senderChatCardBg: const Color(0xFF005C4B),
    receiverChatCardBg: MyColors.greyBackground,
    yellowCardBgColor: const Color(0xFF222E35),
    yelloCardTextColor: const Color(0xFFFFD279),
  );

  final Color? circleImageColor;
  final Color? greyColor;
  final Color? blueColor;
  final Color? langBtnColor;
  final Color? langBtnHighlightColor;
  final Color? authAppbarTextColor;
  final Color? photoIconBgColor;
  final Color? photoIconColor;
  final Color? profilePageBg;
  final Color? chatTextFieldBg;
  final Color? chatPageBgColor;
  final Color? chatPageDoodleColor;
  final Color? senderChatCardBg;
  final Color? receiverChatCardBg;
  final Color? yellowCardBgColor;
  final Color? yelloCardTextColor;

  CustomThemeExtension({
    this.circleImageColor,
    this.greyColor,
    this.blueColor,
    this.langBtnColor,
    this.langBtnHighlightColor,
    this.authAppbarTextColor,
    this.photoIconBgColor,
    this.photoIconColor,
    this.profilePageBg,
    this.chatTextFieldBg,
    this.chatPageBgColor,
    this.chatPageDoodleColor,
    this.senderChatCardBg,
    this.receiverChatCardBg,
    this.yellowCardBgColor,
    this.yelloCardTextColor,
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
    Color? profilePageBg,
    Color? chatTextFieldBg,
    Color? chatPageBgColor,
    Color? chatPageDoodleColor,
    Color? senderChatCardBg,
    Color? receiverChatCardBg,
    Color? yellowCardBgColor,
    Color? yelloCardTextColor,
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
      profilePageBg: profilePageBg ?? this.profilePageBg,
      chatTextFieldBg: chatTextFieldBg ?? this.chatTextFieldBg,
      chatPageBgColor: chatPageBgColor ?? this.chatPageBgColor,
      chatPageDoodleColor: chatPageDoodleColor ?? this.chatPageDoodleColor,
      senderChatCardBg: senderChatCardBg ?? this.senderChatCardBg,
      receiverChatCardBg: receiverChatCardBg ?? this.receiverChatCardBg,
      yellowCardBgColor: yellowCardBgColor ?? this.yellowCardBgColor,
      yelloCardTextColor: yelloCardTextColor ?? this.yelloCardTextColor,
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
      profilePageBg: Color.lerp(
        profilePageBg,
        other.profilePageBg,
        t,
      ),
      chatTextFieldBg: Color.lerp(
        chatTextFieldBg,
        other.chatTextFieldBg,
        t,
      ),
      chatPageBgColor: Color.lerp(
        chatPageBgColor,
        other.chatPageBgColor,
        t,
      ),
      chatPageDoodleColor: Color.lerp(
        chatPageDoodleColor,
        other.chatPageDoodleColor,
        t,
      ),
      senderChatCardBg: Color.lerp(
        senderChatCardBg,
        other.senderChatCardBg,
        t,
      ),
      receiverChatCardBg: Color.lerp(
        receiverChatCardBg,
        other.receiverChatCardBg,
        t,
      ),
      yellowCardBgColor: Color.lerp(
        yellowCardBgColor,
        other.yellowCardBgColor,
        t,
      ),
      yelloCardTextColor: Color.lerp(
        yelloCardTextColor,
        other.yelloCardTextColor,
        t,
      ),
    );
  }
}
