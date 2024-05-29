import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/AppConstants.dart';
import 'package:get/get.dart';

class CustomLabeledTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool passwordfield;
  final TextStyle labelStyle;
  final TextStyle hintTextStyle;
  final IconData? startIcon;
  final String? Function(String?)? validator;

  const CustomLabeledTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.passwordfield,
    required this.labelStyle,
    required this.hintTextStyle,
    required this.hintText,
    this.startIcon,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomLabeledTextField> createState() => _CustomLabeledTextFieldState();
}

class _CustomLabeledTextFieldState extends State<CustomLabeledTextField> {
  bool passwordVisible = true;
  FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  double _validatorHeight() {
    return _errorText != null ? 11.h : 0;
  }

  void _validateInput(String value) {
    String? errorText;
    errorText = widget.validator!(value);
    if (widget.labelText.toLowerCase().contains('email')) {
      errorText = _validateEmail(value);
    } else if (widget.labelText.toLowerCase().contains('password')) {
      errorText = _validatePassword(value);
    } else if (widget.labelText.toLowerCase().contains('name')) {
      errorText = _validateName(value);
    } else if (widget.labelText.toLowerCase().contains('phone')) {
      errorText = _validatePhoneNumber(value);
    } else if (widget.labelText.toLowerCase().contains('address')) {
      errorText = _validateAddress(value);
    }
    setState(() {
      _errorText = errorText;
    });
  }

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 7) {
      return 'Password must be at least 7 characters long';
    }
    return null;
  }

  String? _validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'Please enter your phone number';
    }
    // You can add more specific validation rules for phone number if needed
    return null;
  }

  String? _validateAddress(String value) {
    if (value.isEmpty) {
      return 'Please enter your address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return widget.passwordfield
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.labelText,
                style: widget.labelStyle,
              ),
              11.verticalSpace,
              Container(
                width: 345.w,
                height: 60.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _isFocused ? kColorPrimary : Colors.transparent,
                  ),
                  color: kColorPrimary2,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: TextFormField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  onChanged: (value) {
                    _validateInput(value); // Trigger validation on change
                  },
                  style: widget.hintTextStyle,
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                    hintStyle: widget.hintTextStyle,

                    hintText: widget.hintText,
                    border: InputBorder.none,
                    // contentPadding: EdgeInsets.symmetric(vertical: 18.h),
                    suffixIcon: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(passwordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility),
                      color: kColorGrey124,
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: _validatorHeight()),
              if (_errorText != null)
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text(
                    _errorText!,
                    style: TextStyle(color: Colors.red),
                  ),
                ), // Add space for validator text
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.labelText,
                style: widget.labelStyle,
              ),
              11.verticalSpace,
              Container(
                width: 345.w,
                height: 60.h,
                padding: EdgeInsets.symmetric(
                    horizontal: widget.startIcon != null ? 1.w : 20.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _isFocused ? kColorPrimary : Colors.transparent,
                  ),
                  color: kColorPrimary2,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Row(
                  children: [
                    if (widget.startIcon != null)
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          widget.startIcon!,
                          color: kColorGrey124,
                        ),
                        onPressed: () {},
                      ),
                    Expanded(
                      child: TextFormField(
                        controller: widget.controller,
                        onChanged: (value) {
                          _validateInput(value); // Trigger validation on change
                        },
                        focusNode: _focusNode,
                        style: widget.hintTextStyle,
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          hintStyle: widget.hintTextStyle,
                          // contentPadding: EdgeInsets.symmetric(vertical: 18.h),
                          border: InputBorder.none,
                        ),
                        cursorColor: kColorPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: _validatorHeight()),
              if (_errorText != null)
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text(
                    _errorText!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          );
  }
}

/////-------------------------Button---------------------------/////

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 345.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
        ),
        onPressed: onPressed,
        child: Text(text, style: kStyleWhite16600),
      ),
    );
  }
}

///////CustomContainer///////
class CustomContainer extends StatelessWidget {
  final String imagePath;
  const CustomContainer({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 90.w,
        height: 90.h,
        decoration: BoxDecoration(
          color: kColorWhite37,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Center(
          child: Image.asset(imagePath, width: 100.w, height: 100.h),
        ));
  }
}
