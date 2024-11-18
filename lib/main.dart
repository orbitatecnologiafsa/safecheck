import 'package:flutter/material.dart';
import 'package:SafeCheck/pages/login/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterSplashScreen.gif(
          useImmersiveMode: false,
          gifPath: 'assets/images/splash.gif',
          backgroundColor: Colors.white,
          gifWidth: 500,
          gifHeight: 500,
          nextScreen: const AuthPage(),
          duration: const Duration(milliseconds: 3515),
        ),
    );
  }
}
