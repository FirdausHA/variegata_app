import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:variegata_app/common/widget/bottom_navbar.dart';
import 'package:variegata_app/pages/screens/onboarding.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    Timer(Duration(seconds: 5), () {
      if (token != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BotNavbar(),
            ));
      } else if (token == null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OnboardingScreen(),
            ));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
              width: 100,
              height: 99.53,
              child: Image.asset(
                'assets/img/splash.png',
                fit: BoxFit.fill,
              ),
            ),
        ),
        );
    }
}