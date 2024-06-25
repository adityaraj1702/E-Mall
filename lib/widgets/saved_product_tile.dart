import 'package:flutter/material.dart';
import 'package:e_mall/models/product.dart';

class SavedProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onRemoveForSavedProducts;
  final VoidCallback onAddToCart;

  const SavedProductTile({
    super.key,
    required this.product,
    required this.onRemoveForSavedProducts,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Image.network(
                  product.images[0],
                  width: 70,
                  height: 70,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.green,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: onRemoveForSavedProducts,
                ),
                IconButton(
                  icon: Icon(Icons.add_shopping_cart_rounded),
                  onPressed: onAddToCart,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
