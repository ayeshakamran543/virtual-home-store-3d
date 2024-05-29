import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fyp_project/AppConstants.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavigator extends StatefulWidget {
  final List<Widget> screens;
  final List<String> labels;
  final List<String> imagePaths;

  const BottomNavigator({
    super.key,
    required this.screens,
    required this.labels,
    required this.imagePaths,
  });

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widget.screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: kColorPrimary2,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          border: Border(
            top: BorderSide(
              color: kColorPrimary.withOpacity(0.2),
              width: 1.sp,
            ),
          ),
        ),
        height: 65.h,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: kColorWhite248,
            items: List.generate(
              widget.labels.length,
              (index) => BottomNavigationBarItem(
                icon: SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: SvgPicture.asset(
                    widget.imagePaths[index],
                    colorFilter: ColorFilter.mode(
                      _selectedIndex == index ? kColorPrimary : kColorGrey124,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                label: widget.labels[index],
              ),
            ),
            currentIndex: _selectedIndex,
            selectedItemColor: kColorPrimary,
            unselectedItemColor: kColorGrey124,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedFontSize: 10.sp,
            unselectedFontSize: 10.sp,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            iconSize: 24.sp,
            selectedIconTheme: const IconThemeData(size: 24),
            unselectedIconTheme: const IconThemeData(size: 24),
            selectedLabelStyle: GoogleFonts.poppins(
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
            ),
            unselectedLabelStyle: GoogleFonts.poppins(
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

// class ScreenOne extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Screen 1'),
//     );
//   }
// }

// class ScreenTwo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Screen 2'),
//     );
//   }
// }

// class ScreenThree extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Screen 3'),
//     );
//   }
// }

// class ScreenFour extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Screen 4'),
//     );
//   }
// }

// class ScreenFive extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Screen 5'),
//     );
//   }
// }
