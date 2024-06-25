import 'package:e_mall/firebase_options.dart';
import 'package:e_mall/models/product.dart';
import 'package:e_mall/providers/bottom_nav_provider.dart';
import 'package:e_mall/providers/cart_provider.dart';
import 'package:e_mall/providers/category_provider.dart';
import 'package:e_mall/providers/profile_data_provider.dart';
import 'package:e_mall/providers/saved_product_provider.dart';
import 'package:e_mall/screens/auth/auth_screen.dart';
import 'package:e_mall/screens/auth/login_screen.dart';
import 'package:e_mall/screens/auth/register_screen.dart';
import 'package:e_mall/screens/home_screen/cart_page.dart';
import 'package:e_mall/screens/home_screen/home_screen.dart';
import 'package:e_mall/screens/product_details_screen/product_details_screen.dart';
import 'package:e_mall/screens/splash_screen.dart';
import 'package:e_mall/providers/theme_provider.dart';
import 'package:e_mall/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => SavedProductsProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: Builder(builder: (context) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        final isSystemDarkMode = themeProvider.isSystemDarkMode(context);
        return MaterialApp(
          title: 'E Mall',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.appTheme == AppTheme.system
              ? (isSystemDarkMode ? darkTheme : lightTheme)
              : themeProvider.themeData,
          routes: {
            '/': (context) => const SplashSscreen(),
            '/auth': (context) => const AuthScreen(),
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegisterScreen(),
            '/home': (context) => HomeScreen(),
            '/product-details': (context) => ProductDetailsScreen(
                product: ModalRoute.of(context)!.settings.arguments as Product),
            '/cart': (context) => const CartPage(),
          },
        );
      }),
    );
  }
}
