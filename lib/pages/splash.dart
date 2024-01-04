import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_clone/auth/auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
    void initState() {

    super.initState();
    Timer(const Duration(seconds: 3), () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthPage(),));});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/logor.png',height: 70,width: 70,),
      ),
    );
  }
}