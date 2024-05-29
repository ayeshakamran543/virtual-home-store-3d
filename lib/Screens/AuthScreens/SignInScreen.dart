import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/AppConstants.dart';
import 'package:fyp_project/BottomNav.dart';
import 'package:fyp_project/Screens/AboutUs.dart';
import 'package:fyp_project/Screens/AuthScreens/CustomAuthWidgets.dart';
import 'package:fyp_project/Screens/AuthScreens/SignUpScreen.dart';
import 'package:fyp_project/Screens/HomeScreen.dart';
import 'package:fyp_project/Screens/ProfileScreen.dart';
import 'package:fyp_project/Screens/TestimonalScreen.dart';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login(String email, String password) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = userCredential.user!;

      // Pass the user's name to the HomeScreen
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
            builder: (context) => BottomNavigator(screens: [
                  HomeScreen(),
                  TestimonialScreen(),
                  AboutUsScreen(),
                  ProfileScreen(),
                ], labels: const [
                  'Home',
                  'Testimonials',
                  'About Us',
                  'Profile',
                ], imagePaths: const [
                  'asset/svgs/home.svg',
                  'asset/svgs/testimonial-icon.svg',
                  'asset/svgs/aboutUs.svg',
                  'asset/svgs/profile.svg',
                ])),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user found for that email.')),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Wrong password!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error occurred: ${e.message}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomContainer(imagePath: 'asset/images/logo.png'),
                  20.verticalSpace,
                  Text(
                    'Sign In',
                    style: kStyleBlack32600,
                  ),
                  26.verticalSpace,
                  CustomLabeledTextField(
                    startIcon: Icons.email,
                    labelStyle: kStyleBlack14400,
                    hintTextStyle: kStyleGrey16400,
                    controller: emailController,
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    passwordfield: false,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  11.verticalSpace,
                  CustomLabeledTextField(
                    labelStyle: kStyleBlack14400,
                    hintTextStyle: kStyleGrey16400,
                    controller: passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    passwordfield: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  24.verticalSpace,
                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                      _login(emailController.text, passwordController.text);
                    },
                    color: kColorPrimary,
                  ),
                  21.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: kStyleBlack14400,
                      ),
                      5.horizontalSpace,
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUp(),
                            ),
                          );
                        },
                        // () {
                        //   Get.to(() => SignUp());
                        // },
                        child: Text(
                          'Sign Up',
                          style: kStyleBlack14700,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
