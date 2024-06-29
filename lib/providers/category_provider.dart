import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mall/models/product.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  int _selectedIndex = 0;
  List<String> _categoryList = [];
  List<Product> _products = [];
  // List<Product> _filteredProducts = [];
  bool _isCategoryLoading = true;
  bool _isProductsLoading = true;

  int get selectedIndex => _selectedIndex;
  List<String> get categoryList => _categoryList;
  List<Product> get products => _products;
  // List<Product> get filteredProducts => _filteredProducts;
  bool get isCategoryLoading => _isCategoryLoading;
  bool get isProductsLoading => _isProductsLoading;

  CategoryProvider() {
    fetchCategories();
    fetchProducts();
  }

  void selectCategory(int index) {
    _selectedIndex = index;
    // _filteredProducts = filterProducts(_categoryList[_selectedIndex]);
    notifyListeners();
  }

  List<Product> filterProducts(String category) {
    List<Product> filteredProducts = category == 'Featured'
        ? _products.where((product) => product.isFeatured).toList()
        : _products.where((product) => product.category == category).toList();
    return filteredProducts;
  }

  Future<void> fetchCategories() async {
    _isCategoryLoading = true;
    notifyListeners();
    if(_categoryList.isNotEmpty){
      _isCategoryLoading = false;
      notifyListeners();
      return;
    }
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
    _isProductsLoading = true;
    notifyListeners();
    if(_products.isNotEmpty){
      print('product lenght');
      print(_products.length);
      _isProductsLoading = false;
      notifyListeners();
      return;
    }
    try {
      await FirebaseFirestore.instance.collection('productList').get().then(
            (value) => value.docs.forEach(
              (result) {
                final data = result.data();
                // _products.add(
                //   Product(
                //     id: data['id'],
                //     name: data['name'],
                //     description: data['description'],
                //     price: data['price'],
                //     category: data['category'],
                //     isFeatured: data['isFeatured'],
                //     images: List<String>.from(data['images']),
                //   ),
                // );
                _products.add(Product.fromFirestore(data));
                print('proddvss len');
                print(_products.length);
              },
            ),
          );
      print(_products.length);
    } catch (e) {
      print(e);
    } finally {
      _isProductsLoading = false;
      notifyListeners();
    }
  }
}
