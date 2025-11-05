import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/components/aqi_widget.dart';

class AqiHomeWidget extends StatelessWidget {
  const AqiHomeWidget({super.key});

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
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xFFD7FFC1),
                    whiteColor,
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 16, left: 16, top: 30),
                child: Row(children: [
                  PrimaryText(
                    text: "Udara bersih, nikmati harimu di luar ruangan!",
                    color: Color(0xFF4BAA17),
                    letterSpacing: -0.1,
                    lineHeight: 1.4,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ]),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        weight: 14,
                        color: Color(0xFF4B5563),
                      ),
                      SizedBox(width: 4),
                      PrimaryText(
                        text: "Tembalang",
                        letterSpacing: -0.1,
                        lineHeight: 1.4,
                        fontSize: 14,
                        color: colorTextDarkSecondary,
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryText(
                        text: "Baik",
                        fontSize: 28,
                        color: neutralDefault,
                        letterSpacing: -0.1,
                        lineHeight: 1.4,
                        fontWeight: FontWeight.w900,
                      ),
                      AqiWidget(
                          // aqi: aqi,
                          // aqiColor: colorAqi,
                          )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
