import 'package:e_mall/providers/saved_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_mall/models/product.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatefulWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product-details',
          arguments: widget.product,
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 2,
            ),
            Image.network(
              widget.product.images[0],
              height: 180,
              width: double.infinity,
              fit: BoxFit.scaleDown,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    widget.product.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('\$${widget.product.price.toStringAsFixed(2)}'),
                  IconButton(
                    icon: Icon(
                      Provider.of<SavedProductsProvider>(context)
                              .savedProducts
                              .any((savedProduct) =>
                                  savedProduct.id == widget.product.id)
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                    ),
                    onPressed: () {
                      Provider.of<SavedProductsProvider>(context, listen: false)
                          .toggleSavedProduct(widget.product);
                    },
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
