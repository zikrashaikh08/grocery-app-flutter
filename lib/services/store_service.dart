import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class StoreServices {
  getTopPickedStore() {
    return FirebaseFirestore.instance
        .collection('vendors')
        .where('accVerified', isEqualTo: true)
        .where('isTopPicked', isEqualTo: true)
        .orderBy('shopName').snapshots();
  }
}
//this will show only verified vendor
//this will show only top picked vendor by admin 
//this will sort the store alphabetic order