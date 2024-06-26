import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_mall/providers/saved_product_provider.dart';
import 'package:e_mall/screens/product_details_screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_mall/models/product.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            child: Column(
              children: [
                const SizedBox(
                  height: 2,
                ),
                CachedNetworkImage(
                  height: 170,
                  imageUrl: product.images[0],
                  fit: BoxFit.scaleDown,
                  placeholder: (context, url) => const SizedBox(
                    width: 70,
                    height: 180, // Adjust height according to your requirement
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '₹ ${product.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Provider.of<SavedProductsProvider>(context)
                                .savedProducts
                                .any((savedProduct) =>
                                    savedProduct.id == product.id)
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                      ),
                      onPressed: () {
                        Provider.of<SavedProductsProvider>(context,
                                listen: false)
                            .toggleSavedProduct(product);
                      },
                    ),
                    if (product.isFeatured)
                      const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(Icons.star_rate_rounded,),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
