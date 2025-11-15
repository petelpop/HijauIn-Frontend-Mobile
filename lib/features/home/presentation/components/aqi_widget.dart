import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';

class AqiWidget extends StatelessWidget {
  final String? aqi;
  final Color? colorAqi;
  final Color? colorBorderAqi;

  const AqiWidget({
    super.key,
    this.aqi,
    this.colorAqi,
    this.colorBorderAqi});

  @override
  Widget build(BuildContext context) {
    bool isRange = (aqi?.contains('-') ?? false) || (aqi?.contains('+') ?? false);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colorAqi ?? Color(0xFF9FEA6C),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorBorderAqi ?? Color(0xFF9FEA6C),
          strokeAlign: BorderSide.strokeAlignInside,
          width: 5
        )
      ),
      child: isRange
          ? Center(
              child: PrimaryText(
                text: aqi ?? "...",
                fontSize: 14,
                letterSpacing: -0.1,
                color: whiteColor,
                fontWeight: FontWeight.w800,
                lineHeight: 1,
              ),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryText(
                  text: aqi ?? "...",
                  fontSize: 26,
                  letterSpacing: -0.1,
                  color: whiteColor,
                  fontWeight: FontWeight.w800,
                  lineHeight: 1,
                ),
                PrimaryText(
                  text: "AQI",
                  color: colorTextLightPrimary,
                  letterSpacing: -0.1,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  lineHeight: 1.33,
                )
              ],
            ),
    );
  }
}