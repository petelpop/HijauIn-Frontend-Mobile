import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/features/main/presentation/components/navigation_bar_item.dart';
import 'package:sizer/sizer.dart';

class BottomNavBar extends StatelessWidget {
  final List<BottomNavBarItem> items;
  final Function(int) onTap;
  final int selectedIndex;

  const BottomNavBar({
    super.key,
    required this.items,
    required this.onTap,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 20,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          return GestureDetector(
            onTap: () => onTap(item.index),
            child: item,
          );
        }).toList(),
      ),
    );
  }
}
