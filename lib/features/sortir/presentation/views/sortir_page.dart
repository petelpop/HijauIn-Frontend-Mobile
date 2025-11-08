import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/sortir/presentation/components/sortir_item.dart';
import 'package:sizer/sizer.dart';

class SortirPage extends StatelessWidget {
  static const String routeName = "sortir-page";
  const SortirPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Constants.imgBgSortir,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Sortir',
                        style: TextStyle(
                          color: primaryColor600,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextSpan(
                        text: ' Dulu,\n',
                        style: TextStyle(
                          color: colorTextDarkPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextSpan(
                        text: 'Sebelum Buang',
                        style: TextStyle(
                          color: colorTextDarkPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                
                // Subtitle
                PrimaryText(
                  text: 'Bingung jenis sampahnya? Tenang, foto saja! Sortir akan\nmemberi tahu solusinya.',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: colorTextDarkSecondary,
                  lineHeight: 1.5,
                ),
                
                SizedBox(height: 4.h),
                
                Row(
                  children: [
                    // Kamera Button
                    Expanded( 
                      child: SortirItem(
                        title: 'Kamera',
                        description: 'Ambil foto langsung',
                        image: Constants.icCameraSortir,
                        onTap: () {},
                      )
                    ),
                    
                    SizedBox(width: 4.w),
                    
                    // Galeri Button
                    Expanded(
                      child: SortirItem(
                        title: 'Galeri',
                        description: 'Upload foto dari galeri',
                        image: Constants.icPhotoSortir,
                        onTap: (){},
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}