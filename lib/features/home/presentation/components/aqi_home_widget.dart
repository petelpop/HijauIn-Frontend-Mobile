import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/components/aqi_widget.dart';

class AqiHomeWidget extends StatelessWidget {
  String? aqi;
  String? city;

  AqiHomeWidget({super.key, this.aqi = "...", this.city = "..."});

  @override
  Widget build(BuildContext context) {
    Color? colorAqi;
    Color? colorBorderAqi;
    Color? colorDesc;
    Color? colorTextDesc;
    String? textDesc;
    String? textAqi;
    double aqiParse = double.tryParse(aqi ?? "0") ?? 0;

    if (aqiParse >= 0 && aqiParse <= 50) {
      colorAqi = Color(0xFF5CC220);
      colorBorderAqi = Color(0xFF9FEA6C);
      colorDesc = Color(0xFFD7FFC1);
      colorTextDesc = Color(0xFF4BAA17);
      textDesc = "Udara bersih, nikmati harimu di luar ruangan!";
      textAqi = "Baik";
    } else if (aqiParse >= 51 && aqiParse <= 100) {
      colorAqi = Color(0xFFFCB400);
      colorBorderAqi = Color(0xFFFFE746);
      colorDesc = Color(0xFFFEF1D0);
      colorTextDesc = Color(0xFFFCB400);
      textDesc = "Jangan lupa pakai masker jika keluar rumah, ya!";
      textAqi = "Sedang";
    } else if (aqiParse >= 101 && aqiParse <= 150) {
      colorAqi = Color(0xFFFC7600);
      colorBorderAqi = Color(0xFFFFB06A);
      colorDesc = Color(0xFFFFDEC1);
      colorTextDesc = Color(0xFFFC7600);
      textDesc = "Kelompok sensitif sebaiknya batasi aktivitas di luar.";
      textAqi = "Tidak Sehat";
    } else if (aqiParse >= 151 && aqiParse <= 200) {
      colorAqi = Color(0xFFD65519);
      colorBorderAqi = Color(0xFFF5B77C);
      colorDesc = Color(0xFFFFCAC6);
      colorTextDesc = Color(0xFFD65519);
      textDesc = "Udara kurang baik, hindari aktivitas di luar.";
      textAqi = "Tidak Sehat";
    } else if (aqiParse >= 201 && aqiParse <= 300) {
      colorAqi = Color(0xFFC12CE2);
      colorBorderAqi = Color(0xFFDF80F4);
      colorDesc = Color(0xFFF3D7F9);
      colorTextDesc = Color(0xFF871F9F);
      textDesc = "Tetap di dalam ruangan untuk menjaga kesehatan.";
      textAqi = "Sangat Tidak Sehat";
    } else if (aqiParse > 300) {
      colorAqi = Color(0xFF4F2659);
      colorBorderAqi = Color(0xFFB685C3);
      colorDesc = Color(0xFFBFBFBF);
      colorTextDesc = Color(0xFF4F2659);
      textDesc = "Udara sangat berbahaya, tetap di rumah.";
      textAqi = "Berbahaya";
    }

    return Container(
      height: 180,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 18,
            offset: Offset(0, 7),
            spreadRadius: 0,
          )
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 105),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    colorDesc ?? whiteColor,
                    whiteColor,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 16, left: 16, top: 30),
                child: Row(children: [
                  PrimaryText(
                    text: textDesc ?? "...",
                    color: colorTextDesc ?? colorTextDarkSecondary,
                    letterSpacing: -0.1,
                    lineHeight: 1.4,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ]),
              ),
            ),
          ),
          Container(
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              color: whiteColor,
              border: Border.all(
                color: surface300,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        weight: 14,
                        color: Color(0xFF4B5563),
                      ),
                      SizedBox(width: 4),
                      PrimaryText(
                        text: city ?? "...",
                        letterSpacing: -0.1,
                        lineHeight: 1.4,
                        fontSize: 14,
                        color: colorTextDarkSecondary,
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: PrimaryText(
                          textOverflow: TextOverflow.fade,
                          maxLines: 1,
                          text: textAqi ?? "...",
                          fontSize: 28,
                          color: neutralDefault,
                          letterSpacing: -0.1,
                          lineHeight: 1.4,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      AqiWidget(
                          aqi: aqi,
                          colorAqi: colorAqi,
                          colorBorderAqi: colorBorderAqi,
                          )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
