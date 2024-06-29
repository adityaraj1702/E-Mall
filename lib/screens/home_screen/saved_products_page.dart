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
    final savedItems = savedProductsProvider.savedItems;
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Products'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: savedItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: savedItems.length,
                      itemBuilder: (context, index) {
                        final savedItem = savedItems[index];
                        return SavedProductTile(
                            product: savedItem.product!,
                            onAddToCart: () {
                              cartProvider.addProductToCart(savedItem.product!);
                              savedProductsProvider.removeProductFromSaved(savedItem);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Added to cart'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                            onRemoveForSavedProducts: () {
                              savedProductsProvider.removeProductFromSaved(savedItem);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Item removed from Saved Products'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
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
