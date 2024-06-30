import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  String _name = '';
  String _email = '';
  String _mobileNumber = '';
  String _imageUrl = '';
  bool _isLoading = true;

  String get name => _name;
  String get email => _email;
  String get mobileNumber => _mobileNumber;
  String get imageUrl => _imageUrl;
  bool get isLoading => _isLoading;

  ProfileProvider() {
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    _isLoading = true;
    notifyListeners();

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('profile')
            .doc(user.uid)
            .get();

        if (doc.exists) {
          _name = doc['name'] ?? '';
          _email = doc['email'] ?? user.email ?? '';
          _mobileNumber = doc['mobileNumber'] ?? '';
          _imageUrl = doc['image'] ?? '';
        }
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> test() async {
    FirebaseFirestore.instance.collection('productList').get().then((value)=>value.docs.forEach((result){
      print(result.data());
    }));
  }

  Future<void> setName(String name) async {
    _name = name;
    await _updateProfileField('name', name);
    notifyListeners();
  }

  Future<void> setEmail(String email) async {
    _email = email;
    // await _updateProfileField('email', email);
    notifyListeners();
  }

  Future<void> setMobileNumber(String mobileNumber) async {
    _mobileNumber = mobileNumber;
    await _updateProfileField('mobileNumber', mobileNumber);
    notifyListeners();
  }

  Future<void> setImage(Uint8List imageFile) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String imageUrl = '';
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('ProfileImages')
            .child(user.uid); // Unique path for each user's image
        UploadTask uploadTask = ref.putData(imageFile);
        TaskSnapshot snapshot = await uploadTask;
        imageUrl = await snapshot.ref.getDownloadURL();
        print(imageUrl);
        _imageUrl = imageUrl;
        await _updateProfileField('image', imageUrl);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _updateProfileField(String field, dynamic value) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('profile')
            .doc(user.uid)
            .update({field: value});
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteProfileData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .delete();
      }
    } catch (e) {
      print(e);
    }
  }

  void clearProfileOnLogout() {
    _name = '';
    _email = '';
    _mobileNumber = '';
    _imageUrl = '';
    _isLoading = true;
    notifyListeners();
  }
}
