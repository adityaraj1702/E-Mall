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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return CartProductTile(
                  product: cartItem.product,
                  quantity: cartItem.quantity,
                  onIncrease: () => cartProvider.increaseQuantity(cartItem),
                  onDecrease: () => cartProvider.decreaseQuantity(cartItem),
                  onRemove: () => cartProvider.removeProduct(cartItem),
                  onSaveForLater: () {
                    cartProvider.saveForLater(cartItem);
                    savedProductsProvider.toggleSavedProduct(cartItem.product);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle checkout logic
                  },
                  child: const Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
