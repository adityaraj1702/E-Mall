import 'package:e_mall/providers/cart_provider.dart';
import 'package:e_mall/providers/saved_product_provider.dart';
import 'package:e_mall/providers/theme_provider.dart';
import 'package:e_mall/screens/home_screen/cart_page.dart';
import 'package:e_mall/screens/home_screen/home_page.dart';
import 'package:e_mall/screens/home_screen/profile_page.dart';
import 'package:e_mall/providers/bottom_nav_provider.dart';
import 'package:e_mall/screens/home_screen/saved_products_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const SavedProductsPage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
        final cart = Provider.of<CartProvider>(context).cartItems;
        final savedItems =
            Provider.of<SavedProductsProvider>(context).savedItems;
        final themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<BottomNavProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: _pages[provider.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: savedItems.isNotEmpty
                    ? const Icon(Icons.bookmark_rounded)
                    : const Icon(Icons.bookmark_border_rounded),
                label: 'Saved',
              ),
              BottomNavigationBarItem(
                icon: cart.isNotEmpty
                    ? const Icon(Icons.shopping_cart_rounded)
                    : const Icon(Icons.shopping_cart_outlined),
                label: 'Cart',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: provider.selectedIndex,
            selectedItemColor: themeProvider.themeData.colorScheme.primary,
            onTap: (index)=> provider.selectTab(index),
          ),
        );
      },
    );
  }
}
