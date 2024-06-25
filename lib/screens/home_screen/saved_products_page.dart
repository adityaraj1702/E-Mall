import 'package:e_mall/providers/cart_provider.dart';
import 'package:e_mall/widgets/saved_product_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_mall/providers/saved_product_provider.dart';

class SavedProductsPage extends StatelessWidget {
  const SavedProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final savedProductsProvider = Provider.of<SavedProductsProvider>(context);
    final savedProducts = savedProductsProvider.savedProducts;
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Products'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: savedProducts.length,
              itemBuilder: (context, index) {
                final product = savedProducts[index];
                return SavedProductTile(product: product,
                onAddToCart: () {
                  cartProvider.addProductToCart(product);
                  savedProductsProvider.removeSavedProduct(product);
                },
                onRemoveForSavedProducts: () => savedProductsProvider.removeSavedProduct(product),);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(
              icon: const Icon(Icons.shopping_cart_rounded),
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              label: const Text('Go to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
