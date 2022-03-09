import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NUMBER = 'number'; //to avoid any typos
  static const ID = 'id';

  String? _number;
  String? _id;

  //getter

  String get number => _number!;
  String get id => _id!;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map;
    this._number = data[NUMBER];
    this._id = data[ID];
  }
}
