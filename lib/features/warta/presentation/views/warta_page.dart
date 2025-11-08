import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/warta/presentation/components/item_warta.dart';
import 'package:sizer/sizer.dart';

class WartaPage extends StatelessWidget {
  static const String routeName = "warta-page";
  const WartaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Column(
                children: [
                  // Title
                  PrimaryText(
                    text: 'Warta',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: colorTextDarkPrimary,
                  ),
                  SizedBox(height: 1.h),
                  
                  // Subtitle
                  PrimaryText(
                    text: 'Edukasi adalah langkah awal menuju aksi nyata.\nMulai langkahmu di sini.',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: colorTextDarkSecondary,
                    textAlign: TextAlign.center,
                    lineHeight: 1.5,
                  ),
                  
                  SizedBox(height: 2.h),
                  
                  // Search Bar
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFFE5E7EB),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: colorTextDarkSecondary,
                          size: 20,
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Cari artikel',
                              hintStyle: TextStyle(
                                color: colorTextDarkSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 2.h),
            
            // item warta
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.w,
                    mainAxisSpacing: 2.h,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: 6, 
                  itemBuilder: (context, index) {
                    return ItemWartaHome();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}