import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:sizer/sizer.dart';

class OnboardingNavigation extends StatelessWidget {
  final VoidCallback? onPrevious;
  final VoidCallback onNext;
  final bool showPrevious;

  const OnboardingNavigation({
    super.key,
    this.onPrevious,
    required this.onNext,
    this.showPrevious = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
          // Previous Button
          if (showPrevious)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPrevious,
                splashFactory: InkRipple.splashFactory,
                borderRadius: BorderRadius.circular(28),
                splashColor: neutralAccent2.withOpacity(0.3),
                highlightColor: neutralAccent2.withOpacity(0.1),
                child: Ink(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: whiteColor,
                    border: Border.all(
                      color: neutralAccent2,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: neutralSecondary,
                    size: 20,
                  ),
                ),
              ),
            )
          else
            const SizedBox(width: 56),
          
          // Next Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashFactory: InkRipple.splashFactory,
              onTap: onNext,
              borderRadius: BorderRadius.circular(28),
              splashColor: whiteColor.withOpacity(0.3),
              highlightColor: whiteColor.withOpacity(0.1),
              child: Ink(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor600,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor600.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: whiteColor,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
