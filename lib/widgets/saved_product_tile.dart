import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_mall/screens/product_details_screen/product_details_screen.dart';
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(
                      product: product,
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  CachedNetworkImage(
                    width: 70,
                    height: 70,
                    imageUrl: product.images[0],
                    fit: BoxFit.scaleDown,
                    placeholder: (context, url) => const SizedBox(
                      width: 70,
                      height: 70, // Adjust height according to your requirement
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          product.description,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '₹ ${product.price.toStringAsFixed(2)}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.green,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onRemoveForSavedProducts,
                  tooltip: 'Delete from Saved Products',
                ),
                IconButton(
                  icon: const Icon(Icons.add_shopping_cart_rounded),
                  onPressed: onAddToCart,
                  tooltip: 'Add to Cart',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
