import 'package:e_mall/providers/bottom_nav_provider.dart';
import 'package:e_mall/screens/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            Provider.of<BottomNavProvider>(context, listen: false).selectTab(0);
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                Navigator.popAndPushNamed(context, '/home');
              },
            );
            return Container();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
