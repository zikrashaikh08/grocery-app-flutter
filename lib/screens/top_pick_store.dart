import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grocery_app/screens/welcome_screen.dart';
import 'package:grocery_app/services/store_service.dart';
import 'package:grocery_app/services/user_services.dart';

class TopPickStore extends StatefulWidget {
  const TopPickStore({Key? key}) : super(key: key);

  @override
  State<TopPickStore> createState() => _TopPickStoreState();
}

class _TopPickStoreState extends State<TopPickStore> {
  StoreServices _storeServices = StoreServices();
  UserServices _userServices = UserServices();
  User? user = FirebaseAuth.instance.currentUser;
  var _userLatitude = 0.0;
  var _usertLongitude = 0.0;

  //need to find user latlong then can calculate distance

  @override
  void initState() {
    _userServices.getUserById(user!.uid).then((result) {
      if (user != null) {
        setState(() {
          _userLatitude = result.data()!['latitude'];
          _usertLongitude = result.data()!['longitude'];
        });
      } else {
        Navigator.pushReplacementNamed(context, WelcomeScreen.id);
      }
    });
    super.initState();
  }

  String getDistance(Location) {
    var distance = Geolocator.distanceBetween(
        _userLatitude, _usertLongitude, Location.latitude, Location.longitude);
    return distance.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _storeServices.getTopPickedStore(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShot) {
          if (!snapShot.hasData) return CircularProgressIndicator();
          List shopDistance = [];
          for (int i = 0; i <= snapShot.data!.docs.length; i++) {
            var distance = Geolocator.distanceBetween(
              _userLatitude,
              _usertLongitude,
              snapShot.data!.docs[i]['location'].latitude,
              snapShot.data!.docs[i]['location'].longitude,
            );
            snap
          }
          return Column(
            children: [
              Flexible(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:
                      snapShot.data!.docs.map((DocumentSnapshot document) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: Card(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      document['imageUrl'],
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            Container(
                              height: 35,
                              child: Text(
                                document['shopName'],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '${getDistance(document['location'])}Km',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
