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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor600 : Colors.transparent,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedScale(
            scale: isSelected ? 1.1 : 1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Image.asset(
              isSelected ? imageSelected : imageUnselect,
              width: 24,
              height: 24,
              color: isSelected ? Colors.white : colorTextDarkSecondary,
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isSelected
                ? Row(
                    children: [
                      SizedBox(width: 2.w),
                      PrimaryText(
                        text: title,
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
