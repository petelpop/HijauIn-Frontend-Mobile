import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:sizer/sizer.dart';

class AuthForm extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const AuthForm({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: errorMessage != null ? redColor : neutralAccent2,
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword,
            keyboardType: widget.keyboardType,
            validator: (value) {
              final error = widget.validator?.call(value);
              setState(() {
                errorMessage = error;
              });
              return error;
            },
            onChanged: (value) {
              if (errorMessage != null) {
                setState(() {
                  errorMessage = widget.validator?.call(value);
                });
              }
            },
            style: TextStyle(
              fontSize: 14.sp,
              color: neutralDefault,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: neutralAccent1,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Icon(
                widget.prefixIcon,
                color: errorMessage != null ? redColor : neutralAccent1,
                size: 20.sp,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 1.8.h,
              ),
              errorStyle: const TextStyle(height: 0, fontSize: 0),
            ),
          ),
        ),
        if (errorMessage != null) ...[
          SizedBox(height: 0.8.h),
          Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: PrimaryText(
              text: errorMessage!,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: redColor,
            ),
          ),
        ],
      ],
    );
  }
}
