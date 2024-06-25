import 'package:e_mall/data/product_data.dart';
import 'package:e_mall/models/product.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  int _selectedIndex = 0;
  final List _categoryList = [
    "Featured",
    "Mobiles",
    "Electronics & Appliances",
    "Beauty & Personal Care",
    "Sports & Fitness",
  ];
  int get selectedIndex => _selectedIndex;
  List get categoryList => _categoryList;

  void selectCategory(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  List<Product> filterProducts(String category) {
    List<Product> filteredProducts = category == 'Featured'
        ? productList.where((product) => product.isFeatured).toList()
        : productList.where((product) => product.category == category).toList();
    return filteredProducts;
  }
}
