import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  Uint8List? _image;
  String _name = "";
  String _email = "";
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
      final byteData = await rootBundle.load('assets/images/user.png');
      _image = byteData.buffer.asUint8List();
    }
    _name = prefs.getString('name') ?? _name;
    _email = prefs.getString('email') ?? _email;
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

  Future<void> setEmail(String email) async {
    _email = email;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
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
    setName("");
    setEmail("");
    setMobileNumber("");
    final byteData = await rootBundle.load('assets/images/user.png');
    setImage(byteData.buffer.asUint8List());
    await prefs.remove('name');
    await prefs.remove('mobileNumber');
    await prefs.remove('email');
    await prefs.remove('image');
    notifyListeners();
  }
}
