import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_flutter/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_flutter/feature/welcome/widgets/language_button.dart';
import 'package:whatsapp_flutter/feature/welcome/widgets/privacy_and_terms.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Whatsapp'),
          backgroundColor: const Color.fromRGBO(7, 94, 84, 1),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
                child: Image.asset(
                  'assets/images/circle.png',
                  color: context.theme.circleImageColor,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    'Welcome to Whatsapp',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const PrivacyAndTerms(),
                  CustomElevatedButton(
                    text: 'AGREE AND CONTINUE',
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const LanguageButton()
                ],
              ),
            ),
          ],
        ));
  }
}
