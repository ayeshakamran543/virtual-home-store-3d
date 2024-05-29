import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/AppConstants.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: AppBar(
            // leading: IconButton(
            //   icon: Icon(
            //     Icons.arrow_back_ios,
            //   ),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
            centerTitle: true,
            backgroundColor: kColorPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15.r),
              ),
            ),
            iconTheme: IconThemeData(color: kColorWhite),
            title: Text('About Us',
                style: kStyleBlack22600.copyWith(color: kColorWhite)),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              Card(
                color: kColorWhite248,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      30.verticalSpace,
                      Image.asset('asset/images/information.png',
                          height: 110.h, width: 110.w),
                      30.verticalSpace,
                      Text(
                        'Welcome to Home Provision, where innovation meets convenience.',
                        style: kStyleBlack17500.copyWith(
                            color: kColorPrimary, fontWeight: FontWeight.bold),
                      ),
                      20.verticalSpace,
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 5.h),
                              child: Icon(
                                Icons.circle,
                                color: kColorPrimary,
                                size: 15,
                              ),
                            ),
                            10.horizontalSpace,
                            Expanded(
                              child: Text(
                                'We offer a wide range of high-quality products, including tiles, marble, electronics, furniture, and doors.',
                                style: kStyleBlack12500.copyWith(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ]),
                      15.verticalSpace,
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 5.h),
                              child: Icon(
                                Icons.circle,
                                color: kColorPrimary,
                                size: 15,
                              ),
                            ),
                            15.horizontalSpace,
                            Expanded(
                              child: Text(
                                'Our unique Augmented Reality (AR) feature lets you visualize products in your space before purchase.',
                                style: kStyleBlack12500.copyWith(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ]),
                      10.verticalSpace,
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 5.h),
                              child: Icon(
                                Icons.circle,
                                color: kColorPrimary,
                                size: 15,
                              ),
                            ),
                            10.horizontalSpace,
                            Expanded(
                              child: Text(
                                'We prioritize customer satisfaction and provide dedicated support throughout your shopping journey.',
                                style: kStyleBlack12500.copyWith(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ]),
                      45.verticalSpace,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
