import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homeScreen.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'Splash-screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(
          seconds: 3,
        ), () {
      FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user == null) {
          Navigator.pushReplacementNamed(context, WelcomeScreen.id);
        } else {
          Navigator.pushReplacementNamed(context, HomeScreen.id);
        }
      });
    });
    super.initState();
  }

  void get newMethod => initState;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('images/logo.png'),
            const Text(
              'Grocery Store',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
