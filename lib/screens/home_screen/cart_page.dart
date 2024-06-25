import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_mall/providers/cart_provider.dart';
import 'package:e_mall/providers/saved_product_provider.dart';
import 'package:e_mall/widgets/cart_product_tile.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final savedProductsProvider = Provider.of<SavedProductsProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: cartItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartItems[index];
                        return CartProductTile(
                          product: cartItem.product,
                          quantity: cartItem.quantity,
                          onIncrease: () =>
                              cartProvider.increaseQuantity(cartItem),
                          onDecrease: () {
                            if (cartItem.quantity == 1) {
                              return;
                            }
                            cartProvider.decreaseQuantity(cartItem);
                          },
                          onRemove: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Item removed from Cart'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            cartProvider.removeProduct(cartItem);
                          },
                          onSaveForLater: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Moved to Saved Products'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            cartProvider.saveForLater(cartItem);
                            savedProductsProvider
                                .toggleSavedProduct(cartItem.product);
                          },
                        );
                      },
                    )
                  : const Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart_outlined, size: 100),
                            Text('Cart is Empty'),
                          ],
                        ),
                      ),
                    ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ₹ ${cartProvider.totalPrice.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Shall be developed in later version.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text("Not yet implemented!"),
                        ),
                      );
                    },
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
