import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:shimmer/shimmer.dart';

class AqiHomeShimmer extends StatelessWidget {
  const AqiHomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 18,
            offset: Offset(0, 7),
            spreadRadius: 0,
          )
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 105),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 16, left: 16, top: 30, right: 16),
                child: Shimmer.fromColors(
                  baseColor: neutralAccent1.withOpacity(0.4),
                  highlightColor: neutralAccent1.withOpacity(0.7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: neutralGray,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              color: whiteColor,
              border: Border.all(
                color: surface300,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Shimmer.fromColors(
                baseColor: neutralAccent1.withOpacity(0.4),
                highlightColor: neutralAccent1.withOpacity(0.7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: neutralGray,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        SizedBox(width: 4),
                        Container(
                          height: 14,
                          width: 100,
                          decoration: BoxDecoration(
                            color: neutralGray,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 28,
                          width: 120,
                          decoration: BoxDecoration(
                            color: neutralGray,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: neutralGray,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
