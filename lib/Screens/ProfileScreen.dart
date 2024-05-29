import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/AppConstants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String email = '';
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
          email = userDoc.get('email');
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: Alignment.center, children: [
            Positioned(
              top: 0,
              child: Container(
                height: 175.h,
                width: 396.w,
                decoration: BoxDecoration(
                  color: kColorPrimary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 25.w, horizontal: 25.w),
                  child: Text('Profile', style: kStyleWhite22600),
                ),
              ),
            ),
            Column(children: [
              82.verticalSpace,
              ProfileCard(
                name: name,
                email: email,
              ),
              27.verticalSpace,
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 390.w,
                          )
                        ],
                      ),
                    ],
                  ))
            ]),
          ]),
        ],
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  final String name;
  final String email;
  const ProfileCard({super.key, required this.name, required this.email});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 173.h,
      width: 280.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: 141.h,
              width: 280.w,
              decoration: BoxDecoration(
                color: kColorWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.r),
                  topRight: Radius.circular(5.r),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: CircleAvatar(
              radius: 34,
              child: Image.asset('asset/images/Memoji.png'),
            ),
          ),
          Positioned(
            bottom: 0, // Adjust as needed
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.name, style: kStyleBlack12600),
                    SizedBox(width: 5.w),
                    Icon(Icons.edit_rounded, color: kColorPrimary, size: 15.sp),
                    // Image.asset(
                    //   'assets/images/ed.png',
                    //   width: 13.w,
                    //   height: 13.h,
                    //   color: kColorPrimary,
                    // ),
                  ],
                ),
                7.verticalSpace,
                Text(widget.email, style: kStyleGrey10500),
                7.verticalSpace,
                // RichText(
                //     text: TextSpan(
                //         text: 'Volunteering Since ',
                //         style: kStyleGrey10500,
                //         children: [
                //       TextSpan(text: 'Sep 2023', style: kStylePrimary10700),
                //     ])),
                52.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
