import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mall/models/product.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  int _selectedIndex = 0;
  List<String> _categoryList = [];
  List<Product> _products = [];
  bool _isCategoryLoading = true;
  bool _isProductsLoading = true;

  int get selectedIndex => _selectedIndex;
  List<String> get categoryList => _categoryList;
  List<Product> get products => _products;
  bool get isCategoryLoading => _isCategoryLoading;
  bool get isProductsLoading => _isProductsLoading;


  void selectCategory(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  List<Product> filterProducts(String category) {
    if(_products.isEmpty){
      print("product list is empty");
    }else{
      print('product list length is');
      print(_products.length);
    }
    List<Product> filteredProducts = category == 'Featured'
        ? _products.where((product) => product.isFeatured).toList()
        : _products.where((product) => product.category == category).toList();
    return filteredProducts;
  }

  Future<void> fetchCategories() async {
    _categoryList.clear();
    try {
      final collection = FirebaseFirestore.instance.collection('categoryList');
      final docRef = collection.doc('7BVT9qYCV1EH5rSK6A23');
      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null && data.containsKey('list')) {
          final list = data['list'];
          for (String item in list) {
            _categoryList.add(item);
          }
        }
      }
    } catch (e) {
      print(e);
    } finally {
      _isCategoryLoading = false;
      notifyListeners();
    }
  }
  Future<void> fetchProducts() async {
    _products.clear();
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection('productList').get();
      for (var doc in querySnapshot.docs) {
        print(doc.data());
        _products.add(Product.fromFirestore(doc.data()));
      }
      if (_products.isEmpty) {
        print("No products found");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
    finally {
      _isProductsLoading = false;
      notifyListeners();
    }
  }

  void clearHomePageOnLogout(){
    _products.clear();
    _categoryList.clear();
    _isProductsLoading=true;
    _isCategoryLoading=true;
    notifyListeners();
  }
}
