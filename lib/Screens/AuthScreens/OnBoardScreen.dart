import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/AppConstants.dart';
import 'package:fyp_project/Screens/AuthScreens/CustomAuthWidgets.dart';
import 'package:fyp_project/Screens/AuthScreens/SignInScreen.dart';

class SkipScreen extends StatefulWidget {
  const SkipScreen({super.key});

  @override
  State<SkipScreen> createState() => _SkipScreenState();
}

class _SkipScreenState extends State<SkipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(top: 90.h, left: 40.w, right: 40.w),
        child: Column(
          children: [
            Image.asset(
              'asset/images/onboardImage.jpg',
              height: 300.h,
              width: 300.w,
            ),
            Spacer(),
            SliderScreen()
          ],
        ),
      )),
    );
  }
}

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  PageController _pageController = PageController();
  int _currentPageIndex = 0;
  List<String> _slideTitles = [];
  List<String> _slideContents = [];

  @override
  Widget build(BuildContext context) {
    _slideTitles = [
      'Explore & Shop',
      'Visualize in AR',
      'Seamless Checkout',
    ];

    _slideContents = [
      'Discover a wide range of products at your fingertips. Easily add items to your cart and experience the convenience of streamlined shopping.',
      "Explore our AR feature to visualize products in your space before purchasing, empowering you to make confident and informed decisions effortlessly.",
      "Sign up easily and breeze through checkout. Shop favorite items with a few taps, simplifying your shopping experience."
    ];
    return SizedBox(
      height: 367.h,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          flex: 3,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _slideTitles.length,
            itemBuilder: (context, index) {
              return Slide(
                title: _slideTitles[index],
                content: _slideContents[index],
              );
            },
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
          ),
        ),
        SizedBox(
          height: 40.h,
          width: 100.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _slideTitles.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: SizedBox(
                  width: 5.w,
                  height: 5.h,
                  child: IconButton(
                    icon: Icon(
                      Icons.circle,
                      size: 8,
                      color: _currentPageIndex == index
                          ? kColorPrimary
                          : kColorGrey,
                    ),
                    onPressed: () {
                      _pageController.animateToPage(
                        index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        CustomButton(
          onPressed: () {
            if (_currentPageIndex == _slideTitles.length - 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SignIn()),
              );
            } else {
              _pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          },
          text: "Next",
          color: kColorPrimary,
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SignIn()));
            // _pageController.previousPage(
            //   duration: Duration(milliseconds: 500),
            //   curve: Curves.easeInOut,
            // );
          },
          child: Text("Skip", style: kStyleBlack14500),
        )
      ]),
    );
  }
}

class Slide extends StatelessWidget {
  final String title;
  final String content;

  const Slide({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: kStyleBlack22600.copyWith(fontSize: 24.sp),
          ),
          SizedBox(height: 20.h),
          Text(
            content,
            style: kStyleGrey14400.copyWith(fontSize: 15.sp),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
