import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';

class ItemHomeWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final String? iconPath;
  final VoidCallback? onTap;

  const ItemHomeWidget(
      {super.key, this.title, this.description, this.iconPath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          border: Border.all(
            color: Color(0xFF030712).withOpacity(0.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Image.asset(
                  iconPath ?? Constants.icSortirBlack,
                  scale: 2,
                ),
                SizedBox(
                  width: 8,
                ),
                PrimaryText(
                  text: title ?? "Sortir",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  lineHeight: 1.5,
                  color: Color(0xFF111827),
                )
              ],
            ),
            SizedBox(height: 6),
            PrimaryText(
              text: description ?? "Klasifikasikan jenis sampah",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              lineHeight: 1.33,
              color: Color(0xFF4B5563),
            )
          ],
        ),
      ),
    );
  }
}
