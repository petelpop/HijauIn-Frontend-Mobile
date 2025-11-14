import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/sortir/data/model/sortir.dart';
import 'package:hijauin_frontend_mobile/features/sortir/presentation/cubit/waste_map/waste_map_cubit.dart';
import 'package:hijauin_frontend_mobile/features/sortir/presentation/views/waste_map_page.dart';
import 'package:sizer/sizer.dart';

class SortirDetailPage extends StatelessWidget {
  final SortirModel result;

  const SortirDetailPage({
    super.key,
    required this.result,
  });

  Color _getLabelColor(String? label) {
    switch (label) {
      case 'Organik':
        return Color(0xFF16A34A); 
      case 'Anorganik':
        return Color(0xFFF59E0B); 
      case 'B3':
        return Color(0xFFDC2626);
      default:
        return Color(0xFF6B7280); 
    }
  }

  @override
  Widget build(BuildContext context) {
    final category = WasteCategory.getCategoryByLabel(result.label ?? '');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF111827)),
          onPressed: () => Navigator.pop(context),
        ),
        title: PrimaryText(
          text: 'Hasil Sortir',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF111827),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                text: 'Sampahmu termasuk jenis',
                fontSize: 14,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 1.h),
              
              PrimaryText(
                text: result.label ?? 'Unknown',
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: _getLabelColor(result.label),
              ),
              
              SizedBox(height: 3.h),
              
              Container(
                width: double.infinity,
                height: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: result.image != null
                      ? Image.file(
                          result.image!,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Color(0xFFF3F4F6),
                          child: Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 64,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ),
                ),
              ),
              
              SizedBox(height: 3.h),
              
              PrimaryText(
                text: 'Tentang Jenis Ini',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
              
              SizedBox(height: 1.5.h),
              
              PrimaryText(
                text: category?.description ?? 'Deskripsi tidak tersedia',
                fontSize: 14,
                color: Color(0xFF4B5563),
                fontWeight: FontWeight.w400,
                lineHeight: 1.6,
              ),
              
              SizedBox(height: 4.h),
              
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    String categoryForApi = 'ORGANIK';
                    if (result.label == 'Anorganik') {
                      categoryForApi = 'ANORGANIK';
                    } else if (result.label == 'B3') {
                      categoryForApi = 'B3';
                    }
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => WasteMapCubit(),
                          child: WasteMapPage(category: categoryForApi),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: PrimaryText(
                    text: 'Cari Tempat Sampah',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              
              SizedBox(height: 2.h),
              
              Center(
                child: Column(
                  children: [
                    PrimaryText(
                      text: 'Sortir lagi',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B7280),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildActionButton(
                          context,
                          icon: Icons.camera_alt,
                          label: 'Kamera',
                          subtitle: 'Ambil foto langsung',
                          onTap: () {
                            Navigator.pop(context, 'camera');
                          },
                        ),
                        SizedBox(width: 4.w),
                        _buildActionButton(
                          context,
                          icon: Icons.photo_library,
                          label: 'Galeri',
                          subtitle: 'Upload foto dari galeri',
                          onTap: () {
                            Navigator.pop(context, 'gallery');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42.w,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Color(0xFFF3FAF8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: primaryColor600,
                size: 24,
              ),
            ),
            SizedBox(height: 1.h),
            PrimaryText(
              text: label,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
            SizedBox(height: 0.5.h),
            PrimaryText(
              text: subtitle,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
