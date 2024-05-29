import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/AppConstants.dart';
import 'package:fyp_project/Provider/AddToCartProvider.dart';
import 'package:fyp_project/Screens/AuthScreens/SplashScreen.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Set preferred orientation to portrait up
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Run the app
  runApp(const MyApp());
}

//comment by ayesha again

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(397, 852),
        splitScreenMode: true,
        builder: (builder, child) {
          return ChangeNotifierProvider(
            create: (context) => AddtoCartModel(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Home Provision App',
              theme: ThemeData(scaffoldBackgroundColor: kColorWhite),
              home: const SplashScreen(),
            ),
          );
          // return GetMaterialApp(
          //   debugShowCheckedModeBanner: false,
          //   title: 'Home Provision App',
          //   theme: ThemeData(scaffoldBackgroundColor: kColorWhite),
          //   home: const SplashScreen(),
          // );
        });
  }
}
