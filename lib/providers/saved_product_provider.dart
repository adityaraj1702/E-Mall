import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_mall/models/product.dart';

class SavedProductsProvider with ChangeNotifier {
  List<SavedItem> _savedItems = [];
  SavedProductsProvider() {
    fetchSavedItems();
  }

  List<SavedItem> get savedItems => _savedItems;

  Future<void> fetchSavedItems() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('savedProducts')
            .get();

        _savedItems = snapshot.docs
            .map(
              (doc) => SavedItem(
                productId: doc.id,
              ),
            )
            .toList();
        await _fetchSavedProducts();
      }
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> _fetchSavedProducts() async {
    try {
      await FirebaseFirestore.instance
          .collection('productList')
          .get()
          .then((value) {
        for (SavedItem savedItems in _savedItems) {
          final doc = value.docs.firstWhere(
              (result) => result.data()['id'] == savedItems.productId);
          savedItems.product = Product.fromFirestore(doc.data());
        }
      });
      // _savedProducts.clear();
      // for (String productId in _savedProductIds) {
      //   QuerySnapshot snapshot =
      //       await FirebaseFirestore.instance.collectionGroup('items').get();
      //   final doc = snapshot.docs.firstWhere((doc) => doc['id'] == productId);
      //   _savedProducts.add(Product(
      //     id: doc['id'],
      //     name: doc['name'],
      //     description: doc['description'],
      //     price: doc['price'],
      //     category: doc['category'],
      //     isFeatured: doc['isFeatured'],
      //     images: List<String>.from(doc['images']),
      //   ));
      // }
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> addProductToSaved(Product product) async {
    if (_savedItems.contains(
      SavedItem(
        productId: product.id,
        product: product,
      ),
    )) {
      return;
    }
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('savedProducts')
            .doc(product.id)
            .set({});

        _savedItems.add(SavedItem(productId: product.id, product: product));
        // await _fetchSavedProducts();
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeProductFromSaved(SavedItem savedItem) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        _savedItems.remove(savedItem);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('savedProducts')
            .doc(savedItem.productId)
            .delete();
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  void clearSavedOnLogout() {
    _savedItems.clear();
    notifyListeners();
  }

  Future<void> deleteSavedProducts() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('savedProducts')
            .get()
            .then((value) {
          for (DocumentSnapshot doc in value.docs) {
            doc.reference.delete();
          }
        });
        _savedItems.clear();
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}

class SavedItem {
  final String productId;
  Product? product;
  SavedItem({
    required this.productId,
    this.product,
  });
}
