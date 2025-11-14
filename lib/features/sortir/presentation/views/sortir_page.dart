import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/sortir/data/service/service.dart';
import 'package:hijauin_frontend_mobile/features/sortir/presentation/components/sortir_item.dart';
import 'package:hijauin_frontend_mobile/features/sortir/presentation/cubit/sortir_cubit.dart';
import 'package:hijauin_frontend_mobile/features/sortir/presentation/views/sortir_detail_page.dart';
import 'package:sizer/sizer.dart';

class SortirPage extends StatelessWidget {
  static const String routeName = "sortir-page";
  const SortirPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SortirCubit(SortirService())..loadModel(),
      child: Scaffold(
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
            child: BlocConsumer<SortirCubit, SortirState>(
              listener: (context, state) async {
                if (state is SortirClassified) {

                  final action = await context.pushNamed(
                    SortirDetailPage.routeName,
                    extra: state.result,
                  );

                  if (action == 'camera') {
                    context.read<SortirCubit>().pickAndClassifyFromCamera();
                  } else if (action == 'gallery') {
                    context.read<SortirCubit>().pickAndClassifyFromGallery();
                  }
                }

                if (state is SortirError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

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

                              Expanded(
                                child: SortirItem(
                                  title: 'Kamera',
                                  description: 'Ambil foto langsung',
                                  image: Constants.icCameraSortir,
                                  onTap: state is SortirClassifying
                                      ? null
                                      : () {
                                          context
                                              .read<SortirCubit>()
                                              .pickAndClassifyFromCamera();
                                        },
                                ),
                              ),
                              
                              SizedBox(width: 4.w),
                              
                              Expanded(
                                child: SortirItem(
                                  title: 'Galeri',
                                  description: 'Upload foto dari galeri',
                                  image: Constants.icPhotoSortir,
                                  onTap: state is SortirClassifying
                                      ? null
                                      : () {
                                          context
                                              .read<SortirCubit>()
                                              .pickAndClassifyFromGallery();
                                        },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    if (state is SortirLoading || state is SortirClassifying)
                      Container(
                        color: Colors.black.withOpacity(0.5),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  primaryColor600,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              PrimaryText(
                                text: state is SortirLoading
                                    ? 'Memuat model...'
                                    : 'Mengklasifikasi gambar...',
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}