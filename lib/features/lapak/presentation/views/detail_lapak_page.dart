import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/add_to_cart_request.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/detail_lapak.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/services/services.dart';
import 'package:hijauin_frontend_mobile/features/lapak/presentation/cubit/detail_lapak/detail_lapak_cubit.dart';
import 'package:hijauin_frontend_mobile/utils/toast_widget.dart';
import 'package:sizer/sizer.dart';

class DetailLapakPage extends StatelessWidget {
  static const String routeName = 'detail-lapak-page';
  final String productId;

  const DetailLapakPage({
    super.key,
    required this.productId,
  });

  void _showPurchaseBottomSheet(BuildContext context, DetailLapak product) {
    int quantity = 1;
    bool isLoading = false;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.all(4.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: EdgeInsets.only(bottom: 2.h),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: product.imageUrl,
                          width: 20.w,
                          height: 20.w,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: 20.w,
                            height: 20.w,
                            color: Colors.grey[200],
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 20.w,
                            height: 20.w,
                            color: Colors.grey[200],
                            child: Icon(Icons.image_not_supported, color: Colors.grey[400]),
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryText(
                              text: product.priceFormatted,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: primaryColor600,
                            ),
                            SizedBox(height: 0.5.h),
                            PrimaryText(
                              text: 'Stok: ${product.stock}',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: colorTextDarkSecondary,
                            ),
                          ],
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (quantity > 1) {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                                child: Icon(
                                  Icons.remove,
                                  size: 18,
                                  color: quantity > 1 ? colorTextDarkPrimary : Colors.grey[400],
                                ),
                              ),
                            ),
                            
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              child: PrimaryText(
                                text: quantity.toString(),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: colorTextDarkPrimary,
                              ),
                            ),
                            
                            InkWell(
                              onTap: () {
                                if (quantity < product.stock) {
                                  setState(() {
                                    quantity++;
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                                child: Icon(
                                  Icons.add,
                                  size: 18,
                                  color: quantity < product.stock ? colorTextDarkPrimary : Colors.grey[400],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 3.h),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () async {
                        setState(() {
                          isLoading = true;
                        });
                        
                        try {
                          final lapakServices = LapakServices();
                          final request = AddToCartRequest(
                            productId: product.id,
                            quantity: quantity,
                          );
                          
                          await lapakServices.addToCart(request);
                          
                          Navigator.pop(context);
                          
                          ToastWidget.showToast(
                            context,
                            message: '$quantity ${product.name} berhasil ditambahkan ke keranjang',
                            color: Color(0xFF4CAF50),
                            duration: Duration(seconds: 2),
                          );
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                          
                          ToastWidget.showToast(
                            context,
                            message: e.toString().replaceAll('Exception: ', ''),
                            color: Color(0xFFF44336),
                            duration: Duration(seconds: 3),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isLoading ? Colors.grey : primaryColor600,
                        padding: EdgeInsets.symmetric(vertical: 1.8.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: whiteColor,
                                strokeWidth: 2,
                              ),
                            )
                          : PrimaryText(
                              text: 'Beli Sekarang',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: whiteColor,
                            ),
                    ),
                  ),
                  
                  SizedBox(height: 2.h),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailLapakCubit(LapakServices())..fetchProductDetail(productId),
      child: Scaffold(
        backgroundColor: whiteColor,
        body: BlocBuilder<DetailLapakCubit, DetailLapakState>(
          builder: (context, state) {
            if (state is DetailLapakLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor600,
                ),
              );
            }

            if (state is DetailLapakError) {
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
                      text: 'Gagal memuat detail produk',
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
                        context.read<DetailLapakCubit>().fetchProductDetail(productId);
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

            if (state is DetailLapakLoaded) {
              final product = state.product;
              
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: product.imageUrl,
                                  height: 45.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    height: 45.h,
                                    color: Colors.grey[200],
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: primaryColor600,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    height: 45.h,
                                    color: Colors.grey[200],
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 2.h,
                                  left: 4.w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_back, color: colorTextDarkPrimary),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding: EdgeInsets.all(4.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: PrimaryText(
                                          text: 'Variasi',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: colorTextDarkSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),

                                  PrimaryText(
                                    text: product.name,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: colorTextDarkPrimary,
                                  ),
                                  SizedBox(height: 2.h),

                                  PrimaryText(
                                    text: product.priceFormatted,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: colorTextDarkPrimary,
                                  ),
                                  SizedBox(height: 2.h),

                                  PrimaryText(
                                    text: 'Deskripsi Produk',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: colorTextDarkPrimary,
                                  ),
                                  SizedBox(height: 1.h),

                                  PrimaryText(
                                    text: product.description,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: colorTextDarkSecondary,
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _showPurchaseBottomSheet(context, product);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor600,
                            padding: EdgeInsets.symmetric(vertical: 1.8.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: PrimaryText(
                            text: 'Beli Sekarang',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
