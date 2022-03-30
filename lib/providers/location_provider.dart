import 'package:flutter/cupertino.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:geocoder/services/base.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationProvider with ChangeNotifier {
  late double latitude;
  late double longitude;
  bool permissionAllowed = false;
  Placemark? selectedAddress;
  bool loading = false;

  Future<void> getCurrentPosition() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      this.latitude = position.latitude;
      this.longitude = position.longitude;
      var data = await placemarkFromCoordinates(latitude, longitude);
      print(data);
      data.forEach((d) {});
      this.selectedAddress = data.first;

      // final coordinates = new Coordinates(this.latitude, this.longitude);
      // final addresses =
      //     await Geocoder.local.findAddressesFromCoordinates(coordinates);
      // this.selectedAddress = addresses.first;
      this.permissionAllowed = true;
      notifyListeners();
    } else {
      print('Permission not allowed');
    }
  }

  void onCameraMove(CameraPosition cameraPosition) async {
    this.latitude = cameraPosition.target.latitude;
    this.longitude = cameraPosition.target.longitude;
    notifyListeners();
  }

  Future<void> getMoveCamera() async {
    var data = await placemarkFromCoordinates(latitude, longitude);
    print(data);
    this.selectedAddress = data.first;
    notifyListeners();
    // print("${selectedAddress.featureName} : ${selectedAddress.addressLine}");
  }

  Future<void> savePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('latitude', this.latitude);
    prefs.setDouble('longitude', this.longitude);
    prefs.setString('address', this.selectedAddress.toString());
    prefs.setString('location', this.selectedAddress.toString());
  }
}
