import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';

class AqiWidget extends StatelessWidget {
  const AqiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFF5CC220),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFF9FEA6C),
          strokeAlign: BorderSide.strokeAlignInside,
          width: 5
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryText(
            text: "20",
            fontSize: 26,
            letterSpacing: -0.1,
            color: whiteColor,
            fontWeight: FontWeight.w800,
            lineHeight: 1,),
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