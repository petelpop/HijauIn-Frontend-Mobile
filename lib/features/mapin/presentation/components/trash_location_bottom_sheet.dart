import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/mapin/data/models/location_model.dart';
import 'package:sizer/sizer.dart';

class TrashLocationBottomSheet extends StatelessWidget {
  final TrashLocation location;
  final VoidCallback onClose;

  const TrashLocationBottomSheet({
    super.key,
    required this.location,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10.h,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Container(
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 20,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    text: 'Lokasi tempat sampah',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: colorTextDarkSecondary,
                  ),
                  GestureDetector(
                    onTap: onClose,
                    child: Icon(Icons.close, size: 20),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                children: [
                  Icon(Icons.location_on, color: primaryColor600, size: 20),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: PrimaryText(
                      text: location.description,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colorTextDarkPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      location.imageUrl ?? Constants.imgBgAuth,
                      height: 100,
                      width: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  // Types badges
                  Expanded(
                    child: Wrap(
                      spacing: 2.w,
                      runSpacing: 1.h,
                      children: location.types.map((type) {
                        Color typeColor = type == 'Organik'
                            ? Color(0xFF10B981)
                            : type == 'Anorganik'
                                ? Color(0xFFFBBF24)
                                : Color(0xFFEF4444);
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: typeColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: PrimaryText(
                            text: type,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: typeColor,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimaryText(
                        text: '${location.distance} m',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: colorTextDarkPrimary,
                      ),
                      PrimaryText(
                        text: 'dari tempatmu',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: colorTextDarkSecondary,
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Open Google Maps
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor600,
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: PrimaryText(
                      text: 'Buka Google Maps',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
