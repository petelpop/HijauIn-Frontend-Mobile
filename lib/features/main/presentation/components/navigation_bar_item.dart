import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:sizer/sizer.dart';

class BottomNavBarItem extends StatelessWidget {
  final int index;
  final bool isSelected;
  final String title;
  final String imageSelected;
  final String imageUnselect;

  const BottomNavBarItem({
    super.key,
    required this.index,
    required this.isSelected,
    required this.title,
    required this.imageSelected,
    required this.imageUnselect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor600 : Colors.transparent,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            isSelected ? imageSelected : imageUnselect,
            width: 24,
            height: 24,
            color: isSelected ? Colors.white : colorTextDarkSecondary,
          ),
          if (isSelected) ...[
            SizedBox(width: 2.w),
            PrimaryText(
              text: title,
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ],
        ],
      ),
    );
  }
}
