import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/components/aqi_widget.dart';
import 'package:hijauin_frontend_mobile/features/mapin/data/models/location_model.dart';
import 'package:sizer/sizer.dart';

class AirQualityBottomSheet extends StatelessWidget {
  final AirQualityLocation location;
  final VoidCallback onClose;

  const AirQualityBottomSheet({
    super.key,
    required this.location,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    Color qualityColor = location.aqiValue <= 50
        ? Color(0xFF10B981)
        : location.aqiValue <= 100
            ? Color(0xFBBF24)
            : Color(0xFFEF4444);

    Color gradientStartColor = location.aqiValue <= 50
        ? Color(0xFFD7FFC1) // Green gradient for good air
        : location.aqiValue <= 100
            ? Color(0xFFFFF4CC) // Yellow gradient for moderate
            : Color(0xFFFFE5E5); // Red gradient for unhealthy

    return Positioned(
      bottom: 10.h,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Color(0x16000000),
                blurRadius: 18,
                offset: Offset(0, 7),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Gradient Background (Bottom Layer)
              Padding(
                padding: const EdgeInsets.only(top: 105),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        gradientStartColor,
                        whiteColor,
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 40),
                    child: Row(
                      children: [
                        Expanded(
                          child: PrimaryText(
                            text: location.message,
                            color: qualityColor,
                            letterSpacing: -0.1,
                            lineHeight: 1.4,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // White Card (Top Layer)
              Container(
                height: 16.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(
                    color: surface300,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with location and close button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                size: 16,
                                color: colorTextDarkSecondary,
                              ),
                              SizedBox(width: 4),
                              PrimaryText(
                                text: location.name,
                                letterSpacing: -0.1,
                                lineHeight: 1.4,
                                fontSize: 14,
                                color: colorTextDarkSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: onClose,
                            child: Icon(Icons.close, size: 20),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      // Quality status and AQI widget
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PrimaryText(
                            text: location.quality,
                            fontSize: 28,
                            color: neutralDefault,
                            letterSpacing: -0.1,
                            lineHeight: 1.4,
                            fontWeight: FontWeight.w900,
                          ),
                          AqiWidget(
                            // You can pass aqi value and color here if needed
                            // aqi: location.aqiValue,
                            // aqiColor: qualityColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
