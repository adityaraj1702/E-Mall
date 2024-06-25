import 'package:e_mall/constants/images.dart';
import 'package:flutter/material.dart';

class SplashSscreen extends StatefulWidget {
  const SplashSscreen({super.key});

  @override
  State<SplashSscreen> createState() => _SplashSscreenState();
}

class _SplashSscreenState extends State<SplashSscreen> {
  //navigate to home screen after 3 seconds
  void navigateToHome(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/auth');
    });
  }

  @override
  void initState() {
    super.initState();
    navigateToHome(context);
  }
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Image.asset(
          appLogo,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
