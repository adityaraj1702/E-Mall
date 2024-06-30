import 'package:e_mall/constants/images.dart';
import 'package:e_mall/providers/bottom_nav_provider.dart';
import 'package:e_mall/providers/cart_provider.dart';
import 'package:e_mall/providers/profile_data_provider.dart';
import 'package:e_mall/providers/saved_product_provider.dart';
import 'package:e_mall/screens/home_screen/home_screen.dart';
import 'package:e_mall/widgets/button_widget.dart';
import 'package:e_mall/widgets/custom_text_field.dart';
import 'package:e_mall/widgets/custom_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<String> loginOptions = [icgoogle, icfacebook, ictwitter];

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  bool get isFormValid {
    return emailError == null &&
        passwordError == null &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  void login() async {
    final email = emailController.text;
    final password = passwordController.text;
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Navigator.pop(context);
        Provider.of<BottomNavProvider>(context, listen: false).selectTab(0);
        Provider.of<SavedProductsProvider>(context, listen: false)
            .fetchSavedItems();
        Provider.of<CartProvider>(context, listen: false).fetchCartItems();
        Provider.of<ProfileProvider>(context, listen: false).fetchProfileData();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'invalid-credential') {
        feedbackDialog('Incorrect EmailID or Password', 'Error!');
      } else {
        feedbackDialog(e.code, 'Error!');
      }
    }
  }

  void feedbackDialog(String message, String title) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void forgotPassword() async {
    final email = emailController.text;
    if (email.isEmpty) {
      feedbackDialog('Enter email in the email field', 'Error!');
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      feedbackDialog(
          'Password reset email sent! Check your email.', 'Success!');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        feedbackDialog('No user found with this email.', 'Error!');
      } else {
        feedbackDialog('An error occurred. Please try again.', 'Error!');
      }
    }
  }

  void validateEmail(String value) {
    setState(() {
      if (value.isEmpty) {
        emailError = 'Please enter an email';
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
        emailError = 'Please enter a valid email';
      } else {
        emailError = null;
      }
    });
  }

  void validatePassword(String value) {
    setState(() {
      if (value.isEmpty) {
        passwordError = 'Please enter a password';
      } else if (value.length < 6) {
        passwordError = 'Password should be at least 6 characters long';
      } else {
        passwordError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (canPop) async {
        SystemNavigator.pop();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: ht * 0.06,
                ),
                Image.asset(
                  appLogo,
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: wt - 70,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        title: 'Email',
                        hint: 'Email',
                        controller: emailController,
                        errorMessage: emailError,
                        context: context,
                        onChanged: validateEmail,
                      ),
                      CustomPasswordField(
                        title: 'Password',
                        hint: '********',
                        controller: passwordController,
                        errorMessage: passwordError,
                        context: context,
                        onChanged: validatePassword,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            forgotPassword();
                          },
                          child: const Text(
                            'Forgot Password?',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      buttonWidget(
                        onPress: login,
                        title: "Login",
                        context: context,
                        isDisabled: !isFormValid,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("or, continue with"),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          loginOptions.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey[300],
                              child: GestureDetector(
                                onTap: () {
                                  feedbackDialog(
                                      'This feature is not available as of now.',
                                      'Sorry!');
                                },
                                child: Image.asset(
                                  loginOptions[index],
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    "Don't have an account? Register!",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
