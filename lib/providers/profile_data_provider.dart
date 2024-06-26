import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  Uint8List? _image;
  String _name = "";
  final String _email = FirebaseAuth.instance.currentUser!.email!;
  String _mobileNumber = "";

  ProfileProvider() {
    _loadProfileData();
  }

  Uint8List? get image => _image;
  String get name => _name;
  String get email => _email;
  String get mobileNumber => _mobileNumber;

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final imageString = prefs.getString('image');
    if (imageString != null) {
      _image = base64Decode(imageString);
    } else {
      // Load default image from assets if no image is found in SharedPreferences
      final byteData = await rootBundle.load('assets/images/user.png');
      _image = byteData.buffer.asUint8List();
    }
    _name = prefs.getString('name') ?? _name;
    _mobileNumber = prefs.getString('mobileNumber') ?? _mobileNumber;
    notifyListeners();
  }

  Future<void> setImage(Uint8List image) async {
    _image = image;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('image', base64Encode(image));
    notifyListeners();
  }

  Future<void> setName(String name) async {
    _name = name;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    notifyListeners();
  }

  Future<void> setMobileNumber(String mobileNumber) async {
    _mobileNumber = mobileNumber;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('mobileNumber', mobileNumber);
    notifyListeners();
  }

  Future<void> deleteProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('mobileNumber');
    await prefs.remove('image');
    notifyListeners();
  }
}
