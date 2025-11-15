import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/cubit/mapin/mapin_cubit.dart';
import 'package:sizer/sizer.dart';

class ModeSelector extends StatelessWidget {
  final MapMode currentMode;
  final VoidCallback onModeChanged;

  const ModeSelector({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.8.h),
      decoration: BoxDecoration(
        color: Color(0xFFF3FAF8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<MapinCubit>().setMode(MapMode.tempatSampah);
                onModeChanged();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 2.w),
                decoration: BoxDecoration(
                  color: currentMode == MapMode.tempatSampah
                      ? Color(0xFFFFFFFF)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: currentMode == MapMode.tempatSampah
                      ? [
                          BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: PrimaryText(
                  text: 'Tempat Sampah',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: currentMode == MapMode.tempatSampah
                      ? Color(0xFF111827)
                      : Color(0xFF4B5563),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(width: 1.w),
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<MapinCubit>().setMode(MapMode.kualitasUdara);
                onModeChanged();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 2.w),
                decoration: BoxDecoration(
                  color: currentMode == MapMode.kualitasUdara
                      ? Color(0xFFFFFFFF)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: currentMode == MapMode.kualitasUdara
                      ? [
                          BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: PrimaryText(
                  text: 'Kualitas Udara',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: currentMode == MapMode.kualitasUdara
                      ? Color(0xFF111827)
                      : Color(0xFF4B5563),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
