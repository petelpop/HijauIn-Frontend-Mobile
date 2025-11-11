import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: currentMode == MapMode.tempatSampah
                      ? primaryColor600
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: PrimaryText(
                  text: 'Tempat Sampah',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: currentMode == MapMode.tempatSampah
                      ? Colors.white
                      : colorTextDarkSecondary,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<MapinCubit>().setMode(MapMode.kualitasUdara);
                onModeChanged();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: currentMode == MapMode.kualitasUdara
                      ? primaryColor600
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: PrimaryText(
                  text: 'Kualitas Udara',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: currentMode == MapMode.kualitasUdara
                      ? Colors.white
                      : colorTextDarkSecondary,
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
