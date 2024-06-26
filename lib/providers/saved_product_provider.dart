import 'package:e_mall/data/product_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_mall/models/product.dart';

class SavedProductsProvider with ChangeNotifier {
  List<Product> _savedProducts = [];

  SavedProductsProvider() {
    loadSavedProductsFromLocalStorage();
  }

  List<Product> get savedProducts => _savedProducts;

  void toggleSavedProduct(Product product) {
    if (_savedProducts.any((savedProduct) => savedProduct.id == product.id)) {
      _savedProducts
          .removeWhere((savedProduct) => savedProduct.id == product.id);
    } else {
      _savedProducts.add(product);
    }
    saveSavedProductsToLocalStorage();
    notifyListeners();
  }

  void removeSavedProduct(Product product) {
    _savedProducts.remove(product);
    saveSavedProductsToLocalStorage();
    notifyListeners();
  }

  void saveSavedProductsToLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedProductsid =
        _savedProducts.map((product) => product.id).toList();
    await prefs.setStringList('savedProducts', savedProductsid);
  }

  void loadSavedProductsFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedProductsid = prefs.getStringList('savedProducts') ?? [];
    _savedProducts = savedProductsid
        .map((item) => productList.firstWhere((product) => product.id == item))
        .toList();
    notifyListeners();
  }
  void deleteSavedProductsFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('savedProducts');
    _savedProducts = [];
    notifyListeners();
  }
}
