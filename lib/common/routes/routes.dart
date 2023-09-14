import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/common/models/user_model.dart';
import 'package:whatsapp_flutter/feature/auth/pages/login_page.dart';
import 'package:whatsapp_flutter/feature/auth/pages/user_info_page.dart';
import 'package:whatsapp_flutter/feature/auth/pages/verification_page.dart';
import 'package:whatsapp_flutter/feature/chat/pages/chat_page.dart';
import 'package:whatsapp_flutter/feature/contacts/pages/contact_page.dart';
import 'package:whatsapp_flutter/feature/home/pages/home_page.dart';
import 'package:whatsapp_flutter/feature/welcome/pages/welcome_page.dart';

class Routes {
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String verification = 'verification';
  static const String userInfo = 'user-info';
  static const String home = 'home';
  static const String contacts = 'contacts';
  static const String chat = 'chat';

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
            smsCodeId: args['smsCodeId'],
            phoneNumber: args['phoneNumber'],
          ),
        );
      case userInfo:
        final String? profileImageUrl = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (context) => UserInfoPage(
            profileImageUrl: profileImageUrl,
          ),
        );
      case home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case contacts:
        return MaterialPageRoute(builder: (context) => const ContactPage());
      case chat:
        final UserModel userModel = settings.arguments as UserModel;

        return MaterialPageRoute(
          builder: (context) => ChatPage(userModel: userModel),
        );
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
