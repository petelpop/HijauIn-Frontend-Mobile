import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/components/aqi_widget.dart';
import 'package:sizer/sizer.dart';

class AqiInfoBottomSheet extends StatelessWidget {
  const AqiInfoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Color(0xFFD1D5DB),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          
          SizedBox(height: 2.h),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              children: [
                PrimaryText(
                  text: 'Cara Baca AQI',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: neutralDefault,
                  letterSpacing: -0.1,
                ),
              ],
            ),
          ),
          
          SizedBox(height: 2.h),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: PrimaryText(
              text: 'AQI (Air Quality Index) adalah angka yang menunjukkan seberapa bersih atau tercemarnya udara di sekitar kita.',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: colorTextDarkSecondary,
              letterSpacing: -0.1,
              lineHeight: 1.5,
              textAlign: TextAlign.left,
            ),
          ),
          
          SizedBox(height: 3.h),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              children: [
                _buildAqiRangeItem(
                  range: '0 - 50',
                  colorAqi: Color(0xFF5CC220),
                  colorBorderAqi: Color(0xFF9FEA6C),
                  description: 'Udara bersih dan aman untuk semua aktivitas',
                ),
                SizedBox(height: 2.h),
                _buildAqiRangeItem(
                  range: '51 - 100',
                  colorAqi: Color(0xFFFCB400),
                  colorBorderAqi: Color(0xFFFFE746),
                  description: 'Masih aman, tapi ada sedikit polusi ringan.',
                ),
                SizedBox(height: 2.h),
                _buildAqiRangeItem(
                  range: '101 - 150',
                  colorAqi: Color(0xFFFC7600),
                  colorBorderAqi: Color(0xFFFFB06A),
                  description: 'Orang dengan gangguan pernapasan atau asma sebaiknya hati-hati.',
                ),
                SizedBox(height: 2.h),
                _buildAqiRangeItem(
                  range: '151 - 200',
                  colorAqi: Color(0xFFD65519),
                  colorBorderAqi: Color(0xFFF5B77C),
                  description: 'Udara cukup buruk, kurangi aktivitas luar ruangan',
                ),
                SizedBox(height: 2.h),
                _buildAqiRangeItem(
                  range: '201 - 300',
                  colorAqi: Color(0xFFC12CE2),
                  colorBorderAqi: Color(0xFFDF80F4),
                  description: 'Udara berbahaya, lebih baik tetap di dalam.',
                ),
                SizedBox(height: 2.h),
                _buildAqiRangeItem(
                  range: '301+',
                  colorAqi: Color(0xFF4F2659),
                  colorBorderAqi: Color(0xFFB685C3),
                  description: 'Sangat berbahaya! Hindari keluar rumah sebisa mungkin.',
                ),
              ],
            ),
          ),
          
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Widget _buildAqiRangeItem({
    required String range,
    required Color colorAqi,
    required Color colorBorderAqi,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: AqiWidget(
            aqi: range,
            colorAqi: colorAqi,
            colorBorderAqi: colorBorderAqi,
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          flex: 7,
          child: Padding(
            padding: EdgeInsets.only(top: 0.5.h),
            child: PrimaryText(
              text: description,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: colorTextDarkSecondary,
              letterSpacing: -0.1,
              lineHeight: 1.5,
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }
}

void showAqiInfoBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => SingleChildScrollView(
      child: AqiInfoBottomSheet(),
    ),
  );
}
