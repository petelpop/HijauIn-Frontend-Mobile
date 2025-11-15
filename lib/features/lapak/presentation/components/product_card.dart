import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/list_lapak.dart';
import 'package:sizer/sizer.dart';

class ProductCard extends StatelessWidget {
  final Datum product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFE0E0E0), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                height: 20.h,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 20.h,
                  color: Colors.grey[200],
                  child: Center(
                    child: CircularProgressIndicator(
                      color: primaryColor600,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 20.h,
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 50,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.all(3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                    text: product.name,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: colorTextDarkPrimary,
                    maxLines: 2,
                    lineHeight: 1.3,
                  ),
                  SizedBox(height: 0.5.h),
                  
                  PrimaryText(
                    text: product.priceFormatted,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: primaryColor600,
                  ),
                  SizedBox(height: 0.5.h),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 14,
                        color: Color(0xFFFFC107),
                      ),
                      SizedBox(width: 1.w),
                      PrimaryText(
                        text: '4.9',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: colorTextDarkSecondary,
                      ),
                      SizedBox(width: 2.w),
                      PrimaryText(
                        text: '120 Terjual',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: colorTextDarkSecondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
