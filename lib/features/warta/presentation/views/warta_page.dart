import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/warta/data/services/services.dart';
import 'package:hijauin_frontend_mobile/features/warta/presentation/components/item_warta.dart';
import 'package:hijauin_frontend_mobile/features/warta/presentation/cubit/warta_list/warta_list_cubit.dart';
import 'package:sizer/sizer.dart';

class WartaPage extends StatefulWidget {
  static const String routeName = "warta-page";
  const WartaPage({super.key});

  @override
  State<WartaPage> createState() => _WartaPageState();
}

class _WartaPageState extends State<WartaPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WartaListCubit(WartaServices())..fetchArticles(limit: 20),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: whiteColor,
            body: SafeArea(
              child: Column(
                children: [

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: PrimaryText(
                                text: 'Warta',
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: colorTextDarkPrimary,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: colorTextDarkPrimary,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        
                        PrimaryText(
                          text: 'Edukasi adalah langkah awal menuju aksi nyata.\nMulai langkahmu di sini.',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: colorTextDarkSecondary,
                          textAlign: TextAlign.center,
                          lineHeight: 1.5,
                        ),
                        
                        SizedBox(height: 2.h),
                        
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
                                  controller: _searchController,
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
                                  onSubmitted: (value) {
                                    context.read<WartaListCubit>().searchArticles(value);
                                  },
                                  onChanged: (value) {
                                    setState(() {}); 
                                  },
                                ),
                              ),
                              if (_searchController.text.isNotEmpty)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _searchController.clear();
                                    });
                                    context.read<WartaListCubit>().fetchArticles(limit: 20);
                                  },
                                  child: Icon(
                                    Icons.clear,
                                    color: colorTextDarkSecondary,
                                    size: 20,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 2.h),
                  
                  Expanded(
                    child: BlocBuilder<WartaListCubit, WartaListState>(
                builder: (context, state) {
                  if (state is WartaListLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor600),
                      ),
                    );
                  }
                  
                  if (state is WartaListError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 60,
                            color: Colors.red,
                          ),
                          SizedBox(height: 2.h),
                          PrimaryText(
                            text: 'Terjadi kesalahan',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorTextDarkPrimary,
                          ),
                          SizedBox(height: 1.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: PrimaryText(
                              text: state.message,
                              fontSize: 14,
                              color: colorTextDarkSecondary,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          ElevatedButton(
                            onPressed: () {
                              context.read<WartaListCubit>().fetchArticles(limit: 20);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor600,
                              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
                            ),
                            child: PrimaryText(
                              text: 'Coba Lagi',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  if (state is WartaListLoaded) {
                    if (state.articles.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.article_outlined,
                              size: 60,
                              color: colorTextDarkSecondary,
                            ),
                            SizedBox(height: 2.h),
                            PrimaryText(
                              text: 'Tidak ada artikel',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: colorTextDarkPrimary,
                            ),
                            SizedBox(height: 1.h),
                            PrimaryText(
                              text: 'Belum ada artikel yang tersedia',
                              fontSize: 14,
                              color: colorTextDarkSecondary,
                            ),
                          ],
                        ),
                      );
                    }
                    
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4.w,
                          mainAxisSpacing: 2.h,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: state.articles.length,
                        itemBuilder: (context, index) {
                          return ItemWartaHome(
                            article: state.articles[index],
                          );
                        },
                      ),
                    );
                  }
                  
                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
        );
        },
      ),
    );
  }
}