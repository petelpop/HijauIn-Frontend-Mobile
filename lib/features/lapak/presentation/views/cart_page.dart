import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/services/services.dart';
import 'package:hijauin_frontend_mobile/features/lapak/presentation/cubit/cart/cart_cubit.dart';
import 'package:hijauin_frontend_mobile/features/lapak/presentation/views/checkout_form_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sizer/sizer.dart';

class CartPage extends StatelessWidget {
  static const String routeName = 'cart-page';
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(LapakServices())..fetchCart(),
      child: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: colorTextDarkPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          title: PrimaryText(
            text: 'Keranjang',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colorTextDarkPrimary,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor600,
                ),
              );
            }

            if (state is CartError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 2.h),
                    PrimaryText(
                      text: 'Keranjang Kosong',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colorTextDarkPrimary,
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: PrimaryText(
                        text: 'Yuk, mulai belanja produk ramah lingkungan!',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: colorTextDarkSecondary,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is CartLoaded) {
              final cart = state.cart.data;
              
              if (cart.items.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 80,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: 2.h),
                      PrimaryText(
                        text: 'Keranjang Kosong',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colorTextDarkPrimary,
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: PrimaryText(
                          text: 'Yuk, mulai belanja produk ramah lingkungan!',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: colorTextDarkSecondary,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(4.w),
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 2.h),
                          padding: EdgeInsets.all(3.w),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: item.product.imageUrl,
                                  width: 20.w,
                                  height: 20.w,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: Colors.grey[200],
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: primaryColor600,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    color: Colors.grey[200],
                                    child: Icon(
                                      Icons.image_not_supported_outlined,
                                      color: Colors.grey[400],
                                      size: 10.w,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PrimaryText(
                                      text: item.product.name,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: colorTextDarkPrimary,
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 0.5.h),
                                    PrimaryText(
                                      text: item.product.category.name,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: colorTextDarkSecondary,
                                    ),
                                    SizedBox(height: 1.h),
                                    PrimaryText(
                                      text: 'Rp${item.product.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor600,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: colorTextDarkSecondary.withOpacity(0.3),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            context.read<CartCubit>().updateCartItem(
                                                  item.id,
                                                  item.quantity - 1,
                                                );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(1.w),
                                            child: Icon(
                                              Icons.remove,
                                              size: 16,
                                              color: colorTextDarkSecondary,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                                          child: PrimaryText(
                                            text: item.quantity.toString(),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: colorTextDarkPrimary,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: item.quantity < item.product.stock
                                              ? () {
                                                  context.read<CartCubit>().updateCartItem(
                                                        item.id,
                                                        item.quantity + 1,
                                                      );
                                                }
                                              : null,
                                          child: Container(
                                            padding: EdgeInsets.all(1.w),
                                            child: Icon(
                                              Icons.add,
                                              size: 16,
                                              color: item.quantity < item.product.stock
                                                  ? primaryColor600
                                                  : colorTextDarkSecondary.withOpacity(0.3),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PrimaryText(
                              text: 'Total (${cart.summary.totalItems} barang)',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: colorTextDarkSecondary,
                            ),
                            PrimaryText(
                              text: cart.summary.totalAmountFormatted,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: primaryColor600,
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        SizedBox(
                          width: double.infinity,
                          height: 6.h,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckoutFormPage(),
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
                              text: 'Checkout',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
