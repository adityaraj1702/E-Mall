import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  String? _imageUrl;
  String _name = "Enter your Name";
  final String _email = FirebaseAuth.instance.currentUser!.email!;
  String _mobileNumber = "Enter your Mobile Number";

  ProfileProvider() {
    _loadProfileData();
  }

  String? get imageUrl => _imageUrl;
  String get name => _name;
  String get email => _email;
  String get mobileNumber => _mobileNumber;

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    _imageUrl = prefs.getString('imageUrl');
    _name = prefs.getString('name') ?? _name;
    _mobileNumber = prefs.getString('mobileNumber') ?? _mobileNumber;
    notifyListeners();
  }

  Future<void> setImageUrl(String imageUrl) async {
    _imageUrl = imageUrl;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('imageUrl', imageUrl);
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
}