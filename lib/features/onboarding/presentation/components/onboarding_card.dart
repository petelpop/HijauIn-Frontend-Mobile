import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/onboarding/data/models/onboarding_model.dart';
import 'package:sizer/sizer.dart';

class OnboardingCard extends StatelessWidget {
  final OnboardingModel data;

  const OnboardingCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.h),
            decoration: BoxDecoration(
              color: whiteColor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: whiteColor.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Center(
                        child: Image.asset(
                          data.imagePath,
                          width: 45.w,
                          height: 45.w,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.air,
                              size: 28.w,
                              color: primaryColor400,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.5.h),
                PrimaryText(
                  text: data.title,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: neutralDefault,
                  textAlign: TextAlign.left,
                  lineHeight: 1.3,
                ),
                SizedBox(height: 1.2.h),
                PrimaryText(
                  text: data.description,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                  color: neutralSecondary,
                  textAlign: TextAlign.left,
                  lineHeight: 1.45,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}