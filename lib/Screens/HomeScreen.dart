import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/AppConstants.dart';
import 'package:fyp_project/ProdutsTile.dart';
import 'package:fyp_project/Screens/AuthScreens/CustomAuthWidgets.dart';
import 'package:fyp_project/Screens/CartScreen.dart';
import 'package:fyp_project/Screens/ModelViewer.dart';
import 'package:fyp_project/Screens/ProfileScreen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  @override
  void initState() {
    super.initState();
    retrieveUserData();
  }

  final String userID = FirebaseAuth.instance.currentUser!.uid;
  final CollectionReference parentsCollection =
      FirebaseFirestore.instance.collection('users');
  Future<void> retrieveUserData() async {
    try {
      DocumentSnapshot userDoc = await parentsCollection.doc(userID).get();
      if (userDoc.exists) {
        setState(() {
          name = userDoc.get('name');
        });
        print('Name: $name');
      } else {
        print('User document does not exist');
      }
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              width: 400.w,
              height: 300.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: kColorPrimary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.w),
                  bottomRight: Radius.circular(20.w),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 35.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 380.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(),
                                  ),
                                );
                                // Get.to(() => const ProfileScreen());
                              },
                              child: Image.asset(
                                'asset/images/Memoji.png',
                                width: 50.w,
                                height: 50.h,
                              ),
                            ),
                            Container(
                                width: 40.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 24.sp,
                                    color: kColorPrimary,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CartScreen(),
                                      ),
                                    );
                                  },
                                )),
                          ],
                        ),
                      ),
                      10.verticalSpace,
                      Text('Hello, ${name}!',
                          style: kStyleBlack20600.copyWith(
                              fontSize: 30.sp, fontWeight: FontWeight.bold)),
                      Text('How can we help you today?',
                          style: kStyleBlack17500),
                      SizedBox(
                        width: 400.w,
                      ),
                    ]),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: 200.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  height: 500.h,
                  decoration: BoxDecoration(
                    color: Colors.white, // Front container color
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text('Let\'s explore our services!!',
                                style: kStyleBlack20600.copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Image.asset(
                            'asset/images/workers.png',
                            width: 120.w,
                            height: 120.h,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildItem('asset/images/tiles.png', 'Tiles', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductsTab(
                                  products: tileProducts,
                                  name: 'Tiles',
                                ),
                              ),
                            );
                            // Get.to(
                            //   () => ProductsTab(
                            //     products: tileProducts,
                            //     name: 'Tiles',
                            //   ),
                            // );
                          }),
                          buildItem('asset/images/marble.png', 'Marble', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductsTab(
                                  products: marbleProducts,
                                  name: 'Marble',
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildItem('asset/images/door.png', 'Door', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductsTab(
                                  products: doorProducts,
                                  name: 'Door',
                                ),
                              ),
                            );
                          }),
                          buildItem(
                              'asset/images/electronics.png', 'Electronics',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductsTab(
                                  products: electronicsProducts,
                                  name: 'Electronics',
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildItem('asset/images/furniture.png', 'Furniture',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductsTab(
                                  products: furnitureProducts,
                                  name: 'Furniture',
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildItem(String imagePath, String text, Function() navigateToScreen) {
  return GestureDetector(
    onTap: navigateToScreen, // Call the provided callback function when tapped
    child: Container(
      width: 110.w,
      height: 105.w,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 40,
            height: 40,
            color: kColorPrimary,
          ),
          SizedBox(height: 8.h),
          Text(
            text,
            textAlign: TextAlign.center,
            style: kStyleBlack14400.copyWith(),
          ),
        ],
      ),
    ),
  );
}
