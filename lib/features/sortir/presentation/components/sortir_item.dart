import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:sizer/sizer.dart';

class SortirItem extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final void Function()? onTap;

  const SortirItem({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
          vertical: 2.5.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 10,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  image,
                  width: 24,
                ),
                SizedBox(width: 1.8.w),
                PrimaryText(
                  text: title,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorTextDarkPrimary,
                ),
              ],
            ),
            SizedBox(height: 0.5.h),
            PrimaryText(
              text: description,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: colorTextDarkSecondary,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
