import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';

class OnboardingDots extends StatelessWidget {
  final int onActivePage;

  const OnboardingDots({super.key, required this.onActivePage});

  @override
  Widget build(BuildContext context) {
    return Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: List.generate(
    3,
    (index) => AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: onActivePage == index ? primaryColor600 : neutralAccent1,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20)
      ),
    ),
  ),
);
  }
}