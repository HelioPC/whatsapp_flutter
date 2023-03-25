import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/feature/auth/pages/login_page.dart';
import 'package:whatsapp_flutter/feature/auth/pages/user_info_page.dart';
import 'package:whatsapp_flutter/feature/auth/pages/verification_page.dart';
import 'package:whatsapp_flutter/feature/welcome/pages/welcome_page.dart';

class Routes {
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String verification = 'verification';
  static const String userInfo = 'user-info';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (context) => const WelcomePage());
      case login:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case verification:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => VerificationPage(
            verificationId: args['verificationId'],
            phoneNumber: args['phoneNumber'],
          ),
        );
      case userInfo:
        return MaterialPageRoute(builder: (context) => const UserInfoPage());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('No page Route Provided'),
            ),
          ),
        );
    }
  }
}
