import 'package:e_mall/data/product_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:e_mall/models/product.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  CartProvider() {
    loadCartFromLocalStorage();
  }

  List<CartItem> get cartItems => _cartItems;

  void addProductToCart(Product product) {
    final existingCartItem = _cartItems.firstWhere(
      (cartItem) => cartItem.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingCartItem.quantity == 0) {
      _cartItems.add(existingCartItem);
    }
    existingCartItem.quantity++;
    saveCartToLocalStorage();
    notifyListeners();
  }

  void increaseQuantity(CartItem cartItem) {
    cartItem.quantity++;
    saveCartToLocalStorage();
    notifyListeners();
  }

  void decreaseQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    } else {
      _cartItems.remove(cartItem);
    }
    saveCartToLocalStorage();
    notifyListeners();
  }

  void removeProduct(CartItem cartItem) {
    _cartItems.remove(cartItem);
    saveCartToLocalStorage();
    notifyListeners();
  }

  void saveForLater(CartItem cartItem) {
    removeProduct(cartItem);
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(
        0, (sum, item) => sum + item.product.price * item.quantity);
  }

  void saveCartToLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItemsJson =
        _cartItems.map((cartItem) => json.encode(cartItem.toMap())).toList();
    await prefs.setStringList('cartItems', cartItemsJson);
  }

  void loadCartFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItemsJson = prefs.getStringList('cartItems') ?? [];
    _cartItems = cartItemsJson
        .map((item) => CartItem.fromMap(json.decode(item)))
        .toList();
    notifyListeners();
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'product_id': product.id,
      'quantity': quantity,
    };
  }

  static CartItem fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: productList.firstWhere((product) => product.id == map['product_id']),
      quantity: map['quantity'],
    );
  }
}
