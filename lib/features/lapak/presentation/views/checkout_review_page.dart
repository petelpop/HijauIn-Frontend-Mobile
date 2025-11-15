import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/checkout_form_data.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/services/services.dart';
import 'package:hijauin_frontend_mobile/features/lapak/presentation/cubit/cart/cart_cubit.dart';
import 'package:hijauin_frontend_mobile/features/lapak/presentation/cubit/checkout/checkout_cubit.dart';
import 'package:hijauin_frontend_mobile/features/lapak/presentation/views/payment_webview_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sizer/sizer.dart';

class CheckoutReviewPage extends StatefulWidget {
  static const String routeName = 'checkout-review-page';
  final CheckoutFormData formData;

  const CheckoutReviewPage({
    super.key,
    required this.formData,
  });

  @override
  State<CheckoutReviewPage> createState() => _CheckoutReviewPageState();
}

class _CheckoutReviewPageState extends State<CheckoutReviewPage> {
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartCubit(LapakServices())..fetchCart(),
        ),
        BlocProvider(
          create: (context) => CheckoutCubit(LapakServices()),
        ),
      ],
      child: BlocListener<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          if (state is CheckoutSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentWebViewPage(
                  paymentUrl: state.checkoutData.data.paymentUrl,
                  transactionId: state.checkoutData.data.id,
                ),
              ),
            );
          } else if (state is CheckoutError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
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
            text: 'Checkout',
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
                child: PrimaryText(
                  text: 'Gagal memuat data',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: colorTextDarkSecondary,
                ),
              );
            }

            if (state is CartLoaded) {
              final cart = state.cart.data;

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(4.w),
                            color: whiteColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    PrimaryText(
                                      text: 'Lokasi',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: colorTextDarkPrimary,
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: PrimaryText(
                                        text: 'Ubah',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: primaryColor600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: primaryColor600,
                                      size: 20,
                                    ),
                                    SizedBox(width: 2.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          PrimaryText(
                                            text: widget.formData.recipientName,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: colorTextDarkPrimary,
                                          ),
                                          SizedBox(height: 0.5.h),
                                          PrimaryText(
                                            text: widget.formData.phoneNumber,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: colorTextDarkSecondary,
                                          ),
                                          SizedBox(height: 0.5.h),
                                          PrimaryText(
                                            text: '${widget.formData.address}, ${widget.formData.city}, ${widget.formData.province}, ${widget.formData.postalCode}',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: colorTextDarkPrimary,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Container(
                            padding: EdgeInsets.all(4.w),
                            color: whiteColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryText(
                                  text: 'Detail Pembelian',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: colorTextDarkPrimary,
                                ),
                                SizedBox(height: 2.h),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: cart.items.length,
                                  separatorBuilder: (context, index) => SizedBox(height: 2.h),
                                  itemBuilder: (context, index) {
                                    final item = cart.items[index];
                                    return Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            imageUrl: item.product.imageUrl,
                                            width: 15.w,
                                            height: 15.w,
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
                                                size: 8.w,
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
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 2.w),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            PrimaryText(
                                              text: 'x${item.quantity}',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: colorTextDarkSecondary,
                                            ),
                                            SizedBox(height: 0.5.h),
                                            PrimaryText(
                                              text: 'Rp${item.product.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor600,
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Container(
                            padding: EdgeInsets.all(4.w),
                            color: whiteColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryText(
                                  text: 'Detail Pembayaran',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: colorTextDarkPrimary,
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    PrimaryText(
                                      text: 'Subtotal',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: colorTextDarkSecondary,
                                    ),
                                    PrimaryText(
                                      text: 'Rp${cart.summary.totalAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: colorTextDarkPrimary,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    PrimaryText(
                                      text: 'Layanan',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: colorTextDarkSecondary,
                                    ),
                                    PrimaryText(
                                      text: 'Rp2.000',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: colorTextDarkPrimary,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h),
                                Divider(color: Color(0xFFE0E0E0)),
                                SizedBox(height: 1.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    PrimaryText(
                                      text: 'Total',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: colorTextDarkPrimary,
                                    ),
                                    PrimaryText(
                                      text: 'Rp${(cart.summary.totalAmount + 2000).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: primaryColor600,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Container(
                            padding: EdgeInsets.all(4.w),
                            color: whiteColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryText(
                                  text: 'Catatan Tambahan',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: colorTextDarkPrimary,
                                ),
                                SizedBox(height: 1.h),
                                TextField(
                                  controller: _notesController,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText: 'Tambahkan catatan',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF9E9E9E),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF5F5F5),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.all(3.w),
                                  ),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
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
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 6.h,
                      child: BlocBuilder<CheckoutCubit, CheckoutState>(
                        builder: (context, checkoutState) {
                          final isLoading = checkoutState is CheckoutLoading;
                          
                          return ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    context.read<CheckoutCubit>().checkout(
                                          recipientName: widget.formData.recipientName,
                                          phoneNumber: widget.formData.phoneNumber,
                                          address: widget.formData.address,
                                          city: widget.formData.city,
                                          province: widget.formData.province,
                                          postalCode: widget.formData.postalCode,
                                          notes: _notesController.text.trim(),
                                        );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor600,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                              disabledBackgroundColor: primaryColor600.withOpacity(0.5),
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
                                    text: 'Bayar',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: whiteColor,
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }

            return SizedBox.shrink();
          },
        ),
        ),
      ),
    );
  }
}
