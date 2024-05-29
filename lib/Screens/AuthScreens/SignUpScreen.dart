import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/AppConstants.dart';
import 'package:fyp_project/Screens/AuthScreens/CustomAuthWidgets.dart';
import 'package:fyp_project/Screens/AuthScreens/EmailVerification.dart';
import 'package:fyp_project/Screens/AuthScreens/SignInScreen.dart';
import 'package:fyp_project/Screens/HomeScreen.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signUp(String name, String email, String password, String phone,
      String address) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = userCredential.user!;
      await user.sendEmailVerification();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              EmailVerificationScreen(email: email, name: name),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });

      String errorMessage = '';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = 'An error occurred while signing up: ${e.message}';
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('An unexpected error occurred. Please try again later.')),
      );
      print('Error during sign-up: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 22.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomContainer(
                    imagePath: 'asset/images/logo.png',
                  ),
                  22.verticalSpace,
                  Text(
                    'Sign Up',
                    style: kStyleBlack32600,
                  ),
                  16.verticalSpace,
                  CustomLabeledTextField(
                    startIcon: Icons.person,
                    labelStyle: kStyleBlack14400,
                    hintTextStyle: kStyleGrey16400,
                    controller: nameController,
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    passwordfield: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  11.verticalSpace,
                  CustomLabeledTextField(
                    startIcon: Icons.email,
                    labelStyle: kStyleBlack14400,
                    hintTextStyle: kStyleGrey16400,
                    controller: emailController,
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    passwordfield: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  11.verticalSpace,
                  CustomLabeledTextField(
                    startIcon: Icons.phone,
                    labelStyle: kStyleBlack14400,
                    hintTextStyle: kStyleGrey16400,
                    controller: phoneController,
                    labelText: 'Phone Number',
                    hintText: 'Enter your phone number',
                    passwordfield: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  11.verticalSpace,
                  CustomLabeledTextField(
                    startIcon: Icons.location_on,
                    labelStyle: kStyleBlack14400,
                    hintTextStyle: kStyleGrey16400,
                    controller: addressController,
                    labelText: 'Address',
                    hintText: 'Enter your address',
                    passwordfield: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
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
                        return 'Password is required';
                      }
                      if (!RegExp(r'.{7,}').hasMatch(value)) {
                        return 'Password must be at least 7 characters long';
                      }
                      return null;
                    },
                  ),
                  66.verticalSpace,
                  CustomButton(
                    text: 'Create Account',
                    onPressed: () {
                      _signUp(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                        phoneController.text,
                        addressController.text,
                      );
                    },
                    color: kColorPrimary,
                  ),
                  11.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Already have an account?',
                        style: kStyleBlack14400,
                      ),
                      5.horizontalSpace,
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignIn(),
                            ),
                          );
                          // Get.to(() => SignIn());
                        },
                        child: Text(
                          'Sign In',
                          style: kStyleBlack14700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
