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
    return ChangeNotifierProvider(
      create: (_) => BottomNavProvider(),
      child: Consumer<BottomNavProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: _pages[provider.selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark),
                  label: 'Saved',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: provider.selectedIndex,
              selectedItemColor: Colors.amber[800],
              onTap: provider.selectTab,
            ),
          );
        },
      ),
    );
  }
}
