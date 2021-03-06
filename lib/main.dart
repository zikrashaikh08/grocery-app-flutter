import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/providers/auth_provider.dart';
import 'package:grocery_app/providers/location_provider.dart';
import 'package:grocery_app/screens/landing_screen.dart';
import 'package:grocery_app/screens/map_screen.dart';
import 'package:grocery_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'screens/homeScreen.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(),
        ),
      ],
  child: MyApp(),
  ),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF84c225),
        fontFamily: 'Lato'
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id:(context)=>SplashScreen(),
        HomeScreen.id:(context)=>HomeScreen(),
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        MapScreen.id:(context) =>MapScreen(),
        LoginScreen.id:(context) =>LoginScreen(),
        LandingScreen.id:(context) =>LandingScreen(),
        
      },
    );
  }
}

