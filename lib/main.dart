import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/auth/auth.dart';
import 'package:instagram_clone/auth/login_or_registor_page.dart';
import 'package:instagram_clone/firebase_options.dart';
import 'package:instagram_clone/pages/login_page.dart';
import 'package:instagram_clone/theme/dark_mode.dart';
import 'package:instagram_clone/theme/light_mode.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:lightMode,
      darkTheme: darkMode,
      home:const AuthPage(),
    );
  }
}
