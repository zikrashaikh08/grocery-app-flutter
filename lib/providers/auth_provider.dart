import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/screens/homeScreen.dart';

import '../services/user_services.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late String smsOtp;
  late String verificationId;
  String error = '';
  UserServices _userServices = UserServices();

  Future<void> verifyPhone(BuildContext context, String number) async {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      await _auth.signInWithCredential(credential);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      print("Failed");
      print(e.code);
    };

    final Future<dynamic> Function(String verId, int? resendToken) smsOtpSend =
        (String verId, int? resendToken) async {
      this.verificationId = verId;

      smsOtpDialog(context, number);
    };

    try {
      print(number);
      _auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: smsOtpSend,
        codeAutoRetrievalTimeout: (String verId) {
          this.verificationId = verId;
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> smsOtpDialog(BuildContext context, String number) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Text('Verification Code'),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Enter 6 digit OTP received as SMS',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            content: Container(
              height: 85,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value) {
                  this.smsOtp = value;
                },
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () async {
                  try {
                    PhoneAuthCredential phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: verificationId, smsCode: smsOtp);

                    final User? user =
                        (await _auth.signInWithCredential(phoneAuthCredential))
                            .user;
                    //create user data in fireStore after user succesfully registered,
                    _createUser(id: user!.uid, number: user.phoneNumber);
                    //navigate to home page after login

                    if (user != null) {
                      Navigator.of(context).pop();

                      //don't want come back to welcome screen after loggd in
                      Navigator.pushReplacementNamed(context,HomeScreen.id);
                     
                     
                    } else {
                      print('login Failed');
                    }
                  } catch (e) {
                    this.error = 'Invalid OTP';
                    notifyListeners();
                    print(e.toString());
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'DONE',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          );
        });
  }

  void _createUser({String? id, String? number}) {
    _userServices.createUserData({
      'id': id,
      'number': number,
    });
  }
}
