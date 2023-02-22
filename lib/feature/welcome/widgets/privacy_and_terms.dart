import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_flutter/common/utils/my_colors.dart';

class PrivacyAndTerms extends StatelessWidget {
  const PrivacyAndTerms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Read our ',
          style: TextStyle(
            color: context.theme.greyColor,
            height: 1.5,
          ),
          children: [
            TextSpan(
              text: 'Privacy policy. ',
              style: TextStyle(
                color: context.theme.blueColor,
              ),
            ),
            const TextSpan(
              text: 'Tap "Agree and continue" to accept the ',
            ),
            TextSpan(
              text: 'Terms of services',
              style: TextStyle(
                color: context.theme.blueColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
