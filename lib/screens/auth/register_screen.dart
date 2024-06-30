import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mall/constants/images.dart';
import 'package:e_mall/providers/bottom_nav_provider.dart';
import 'package:e_mall/providers/profile_data_provider.dart';
import 'package:e_mall/screens/home_screen/home_screen.dart';
import 'package:e_mall/widgets/button_widget.dart';
import 'package:e_mall/widgets/custom_password_field.dart';
import 'package:e_mall/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final List<String> regsisterOptions = [icgoogle, icfacebook, ictwitter];
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  bool get isFormValid {
    return emailError == null &&
        passwordError == null &&
        confirmPasswordError == null &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text;
  }

  void register() async {
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
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('profile')
            .doc(user.uid)
            .set({
          'name': '',
          'email': email,
          'mobileNumber': '',
          'image': '',
        });
        Provider.of<ProfileProvider>(context, listen: false).setEmail(email);
      }

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Navigator.pop(context);
        Provider.of<BottomNavProvider>(context, listen: false).selectTab(0);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false,
        );
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close the loading dialog
      feedbackDialog(e.message ?? 'An error occurred', 'Error!');
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

  void validateConfirmPassword(String value) {
    setState(() {
      if (value.isEmpty) {
        confirmPasswordError = 'Please confirm your password';
      } else if (value != passwordController.text) {
        confirmPasswordError = 'Passwords do not match';
      } else {
        confirmPasswordError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: ht * 0.04,
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
                'Register',
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
                    CustomPasswordField(
                      title: 'Confirm Password',
                      hint: '********',
                      controller: confirmPasswordController,
                      errorMessage: confirmPasswordError,
                      context: context,
                      onChanged: validateConfirmPassword,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buttonWidget(
                      onPress: register,
                      title: "Register",
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
                        regsisterOptions.length,
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
                                regsisterOptions[index],
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
                height: 5,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  "Already have an account? Login!",
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
    );
  }
}
