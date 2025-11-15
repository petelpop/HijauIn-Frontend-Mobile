import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:sizer/sizer.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final String? iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    this.iconPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        margin: EdgeInsets.only(right: 2.w),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor600 : whiteColor,
          border: Border.all(
            color: isSelected ? primaryColor600 : Color(0xFFE0E0E0),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconPath != null) ...[
              Image.asset(
                iconPath!,
                width: 20,
                height: 20,
                color: isSelected ? whiteColor : colorTextDarkPrimary,
              ),
              SizedBox(width: 2.w),
            ],
            PrimaryText(
              text: label,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isSelected ? whiteColor : colorTextDarkPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
