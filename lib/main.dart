import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/common/themes/dark_theme.dart';
import 'package:whatsapp_flutter/common/themes/light_theme.dart';
import 'package:whatsapp_flutter/feature/auth/pages/user_info_page.dart';
import 'package:whatsapp_flutter/firebase_options.dart';
// import 'package:whatsapp_flutter/feature/auth/pages/login_page.dart';
// import 'package:whatsapp_flutter/feature/auth/pages/verification_page.dart';
// import 'package:whatsapp_flutter/feature/welcome/pages/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      home: const UserInfoPage(),
    );
  }
}
