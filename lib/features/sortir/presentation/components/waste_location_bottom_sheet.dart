import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/mapin/data/models/waste_location_model.dart';
import 'package:hijauin_frontend_mobile/utils/distance_calculator.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class WasteLocationBottomSheet extends StatelessWidget {
  final WasteLocationDataModel location;
  final VoidCallback onClose;
  final double userLatitude;
  final double userLongitude;

  const WasteLocationBottomSheet({
    super.key,
    required this.location,
    required this.onClose,
    required this.userLatitude,
    required this.userLongitude,
  });

  Future<void> _openGoogleMaps() async {
    final lat = location.coordinates.latitude;
    final lng = location.coordinates.longitude;
    
    final url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving'
    );
    
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    final distance = DistanceCalculator.calculateDistance(
      userLatitude,
      userLongitude,
      location.coordinates.latitude,
      location.coordinates.longitude,
    );

    final displayCategories = location.categories.isEmpty
        ? ['Organik', 'Anorganik', 'B3']
        : location.categories;

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimaryText(
                          text: location.name,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: colorTextDarkPrimary,
                        ),
                        if (location.address.isNotEmpty)
                          PrimaryText(
                            text: location.address,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: colorTextDarkSecondary,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: location.imageUrl.isNotEmpty
                        ? Image.network(
                            location.imageUrl,
                            height: 100,
                            width: 140,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                Constants.imgBgAuth,
                                height: 100,
                                width: 140,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            Constants.imgBgAuth,
                            height: 100,
                            width: 140,
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Wrap(
                      spacing: 2.w,
                      runSpacing: 1.h,
                      children: displayCategories.map((type) {
                        Color typeColor = type.toLowerCase() == 'organik'
                            ? Color(0xFF10B981)
                            : type.toLowerCase() == 'anorganik'
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
                        text: DistanceCalculator.formatDistance(distance),
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
                    onPressed: _openGoogleMaps,
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
