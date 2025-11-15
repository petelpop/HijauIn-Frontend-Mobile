import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/services/services.dart';
import 'package:hijauin_frontend_mobile/features/lapak/presentation/components/category_chip.dart';
import 'package:hijauin_frontend_mobile/features/lapak/presentation/components/product_card.dart';
import 'package:hijauin_frontend_mobile/features/lapak/presentation/cubit/lapak_main/lapak_main_cubit.dart';
import 'package:hijauin_frontend_mobile/features/lapak/presentation/cubit/list_categories/list_categories_cubit.dart';
import 'package:hijauin_frontend_mobile/features/lapak/presentation/views/detail_lapak_page.dart';
import 'package:hijauin_frontend_mobile/features/lapak/presentation/views/cart_page.dart';
import 'package:hijauin_frontend_mobile/features/lapak/presentation/views/history_page.dart';
import 'package:sizer/sizer.dart';

class LapakMainPage extends StatefulWidget {
  static const String routeName = 'lapak-page';
  const LapakMainPage({super.key});

  @override
  State<LapakMainPage> createState() => _LapakMainPageState();
}

class _LapakMainPageState extends State<LapakMainPage> {
  final TextEditingController _searchController = TextEditingController();
  final LapakServices _services = LapakServices();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LapakMainCubit(_services)..fetchAllProducts(),
        ),
        BlocProvider(
          create: (context) => ListCategoriesCubit(_services)..fetchCategories(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: whiteColor,
                padding: EdgeInsets.all(4.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Cari produk',
                                hintStyle: TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xFF9E9E9E),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 1.5.h,
                                ),
                              ),
                              onSubmitted: (value) {
                                context.read<LapakMainCubit>().searchProducts(value);
                              },
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HistoryPage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: Image.asset(
                              Constants.icHistoryLapak,
                              width: 6.w,
                              height: 6.w,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartPage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.w, right: 3.w),
                            child: Image.asset(
                              Constants.icCartLapak,
                              width: 6.w,
                              height: 6.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    BlocBuilder<ListCategoriesCubit, ListCategoriesState>(
                      builder: (context, state) {
                        if (state is ListCategoriesLoaded) {
                          return SizedBox(
                            height: 40,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                CategoryChip(
                                  label: 'Semua',
                                  isSelected: state.selectedCategoryId == null,
                                  onTap: () {
                                    context.read<ListCategoriesCubit>().selectCategory(null);
                                    context.read<LapakMainCubit>().fetchAllProducts();
                                  },
                                ),
                                ...state.categories.map((category) {
                                  return CategoryChip(
                                    label: category.name,
                                    isSelected: state.selectedCategoryId == category.id,
                                    onTap: () {
                                      context.read<ListCategoriesCubit>().selectCategory(category.id);
                                      context.read<LapakMainCubit>().getProductsByCategory(category.id);
                                    },
                                  );
                                }).toList(),
                              ],
                            ),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<LapakMainCubit, LapakMainState>(
                  builder: (context, state) {
                    if (state is LapakMainLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: primaryColor600,
                        ),
                      );
                    }

                    if (state is LapakMainError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 60,
                              color: Colors.red[300],
                            ),
                            SizedBox(height: 2.h),
                            PrimaryText(
                              text: 'Gagal memuat produk',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: colorTextDarkPrimary,
                            ),
                            SizedBox(height: 1.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: PrimaryText(
                                text: state.message,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: colorTextDarkSecondary,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            ElevatedButton(
                              onPressed: () {
                                context.read<LapakMainCubit>().fetchAllProducts();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor600,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 1.5.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: PrimaryText(
                                text: 'Coba Lagi',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: whiteColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is LapakMainLoaded) {
                      if (state.products.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                size: 80,
                                color: Colors.grey[300],
                              ),
                              SizedBox(height: 2.h),
                              PrimaryText(
                                text: 'Produk tidak ditemukan',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: colorTextDarkPrimary,
                              ),
                              SizedBox(height: 1.h),
                              PrimaryText(
                                text: 'Coba cari dengan kata kunci lain',
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: colorTextDarkSecondary,
                              ),
                            ],
                          ),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 1.h),
                            child: PrimaryText(
                              text: '${state.meta.total} barang terkait',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: colorTextDarkSecondary,
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              padding: EdgeInsets.all(4.w),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.65,
                                crossAxisSpacing: 3.w,
                                mainAxisSpacing: 2.h,
                              ),
                              itemCount: state.products.length,
                              itemBuilder: (context, index) {
                                final product = state.products[index];
                                return ProductCard(
                                  product: product,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailLapakPage(
                                          productId: product.id,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    return SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
