import 'package:e_mall/data/category_list.dart';
import 'package:e_mall/data/product_data.dart';
import 'package:e_mall/models/product.dart';
import 'package:e_mall/widgets/product_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = itemCategory[0];

  @override
  Widget build(BuildContext context) {
    // Filtering products based on the selected category
    List<Product> filteredProducts = _selectedCategory == 'Featured'
        ? productList.where((product) => product.isFeatured).toList()
        : productList
            .where((product) =>
                product.category == _selectedCategory || product.isFeatured)
            .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('E Mall'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                " Our Products",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  itemCategory.length,
                  (index) {
                    bool isSelected = itemCategory[index] == _selectedCategory;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = itemCategory[index];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).brightness == Brightness.light
                                  ? Colors.white
                                  : Colors.grey[800],
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.all(5),
                        child: SizedBox(
                          width: 150,
                          height: 40,
                          child: Center(
                            child: Text(
                              itemCategory[index],
                              style: Theme.of(context).textTheme.labelSmall,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 313,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ProductTile(product: filteredProducts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
