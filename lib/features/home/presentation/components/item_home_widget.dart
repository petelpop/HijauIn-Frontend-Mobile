import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';

class ItemHomeWidget extends StatelessWidget {
  const ItemHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(24)
        ),
        border: Border.all(
          color: Color(0xFF030712).withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                Constants.icSortirBlack,
                scale: 2,
              ),
              SizedBox(
                width: 8,
              ),
              PrimaryText(
                text: "Sortir",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                lineHeight: 1.5,
                color: Color(0xFF111827),)
            ],
          ),
          SizedBox(height: 6),
          PrimaryText(
            text: "Klasifikasikan jenis sampah",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            lineHeight: 1.33,
            color: Color(0xFF4B5563),)
        ],
      ),
    );
  }
}
