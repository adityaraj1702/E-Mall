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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: savedProducts.isNotEmpty
                  ? ListView.builder(
                      itemCount: savedProducts.length,
                      itemBuilder: (context, index) {
                        final product = savedProducts[index];
                        return SavedProductTile(
                            product: product,
                            onAddToCart: () {
                              cartProvider.addProductToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Added to cart'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              savedProductsProvider.removeSavedProduct(product);
                            },
                            onRemoveForSavedProducts: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Item removed from Saved Products'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              savedProductsProvider.removeSavedProduct(product);
                            });
                      },
                    )
                  : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save_alt_outlined, size: 100),
                          Text('No Saved Products'),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
