// ignore_for_file: unnecessary_const

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/screens/top_pick_store.dart';
import 'package:grocery_app/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/providers/location_provider.dart';
import '../providers/auth_provider.dart';
import 'package:grocery_app/widgets/my_appbar.dart';

import '../widgets/image_slider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final locationData = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(112),
        child: MyAppBar(),
      ),
      body: Center(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ImageSlider(),
            Container(
              height: 300,
              
              child: TopPickStore()),
          ],
        ),
      ),
    );
  }
}

class EdgeInserts {
  static var zero;
}
