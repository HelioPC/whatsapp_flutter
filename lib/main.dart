import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/common/routes/routes.dart';
import 'package:whatsapp_flutter/common/themes/dark_theme.dart';
import 'package:whatsapp_flutter/common/themes/light_theme.dart';
import 'package:whatsapp_flutter/common/utils/my_colors.dart';
import 'package:whatsapp_flutter/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_flutter/feature/home/pages/home_page.dart';
import 'package:whatsapp_flutter/feature/welcome/pages/welcome_page.dart';
import 'package:whatsapp_flutter/firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme(),
        darkTheme: darkTheme(),
        themeMode: ThemeMode.system,
        home: ref.watch(userInfoAuthProvider).when(
          data: (user) {
            FlutterNativeSplash.remove();
            if (user == null) return const WelcomePage();
            return const HomePage();
          },
          error: (error, trace) {
            debugPrint(error.toString());
            return const Scaffold(
              body: Center(
                child: Text('Something went wrong'),
              ),
            );
          },
          loading: () {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: MyColors.greenDark),
              ),
            );
          },
        ),
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    );
  }
}
