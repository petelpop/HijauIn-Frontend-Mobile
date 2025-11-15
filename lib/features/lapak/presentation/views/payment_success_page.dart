import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/services/services.dart';
import 'package:hijauin_frontend_mobile/features/lapak/presentation/cubit/checkout/checkout_cubit.dart';
import 'package:hijauin_frontend_mobile/features/lapak/presentation/views/history_page.dart';
import 'package:sizer/sizer.dart';

class PaymentSuccessPage extends StatelessWidget {
  static const String routeName = 'payment-success-page';
  final String transactionId;

  const PaymentSuccessPage({
    super.key,
    required this.transactionId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit(LapakServices())..checkPaymentStatus(transactionId),
      child: Scaffold(
        backgroundColor: whiteColor,
        body: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: primaryColor600,
                    ),
                    SizedBox(height: 2.h),
                    PrimaryText(
                      text: 'Mengecek status pembayaran...',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: colorTextDarkSecondary,
                    ),
                  ],
                ),
              );
            }

            if (state is CheckoutError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 80,
                      color: Colors.red,
                    ),
                    SizedBox(height: 2.h),
                    PrimaryText(
                      text: 'Gagal memeriksa status pembayaran',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colorTextDarkPrimary,
                    ),
                    SizedBox(height: 1.h),
                    PrimaryText(
                      text: state.message,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: colorTextDarkSecondary,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 3.h),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
                      ),
                      child: PrimaryText(
                        text: 'Kembali ke Beranda',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: whiteColor,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is PaymentStatusChecked) {
              final data = state.checkoutData.data;
              final isPaid = data.status == 'PAID';

              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(6.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30.w,
                        height: 30.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isPaid 
                              ? primaryColor600.withOpacity(0.1)
                              : Colors.orange.withOpacity(0.1),
                        ),
                        child: Center(
                          child: Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isPaid ? primaryColor600 : Colors.orange,
                            ),
                            child: Icon(
                              isPaid ? Icons.check : Icons.access_time,
                              color: whiteColor,
                              size: 10.w,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      
                      PrimaryText(
                        text: isPaid 
                            ? 'Yey... Pembayaran Berhasil!'
                            : 'Pembayaran Sedang Diproses',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: colorTextDarkPrimary,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 1.h),
                      
                      PrimaryText(
                        text: isPaid
                            ? 'Penjual sedang membungkus pesanan ramah lingkunganmu. Tinggal tunggu barang sampai di depan pintu!'
                            : 'Pembayaran Anda sedang diverifikasi. Mohon tunggu beberapa saat.',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: colorTextDarkSecondary,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                      SizedBox(height: 4.h),
                      
                      Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: Color(0xFFF3FAF8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            _buildDetailRow('No. Pesanan', data.orderNumber),
                            SizedBox(height: 1.h),
                            _buildDetailRow('Status', data.status),
                            SizedBox(height: 1.h),
                            _buildDetailRow('Total Pembayaran', data.totalAmountFormatted),
                            if (data.shippingDetail.recipientName.isNotEmpty) ...[
                              SizedBox(height: 1.h),
                              Divider(color: Color(0xFFE0E0E0)),
                              SizedBox(height: 1.h),
                              _buildDetailRow('Penerima', data.shippingDetail.recipientName),
                              SizedBox(height: 1.h),
                              _buildDetailRow('Telepon', data.shippingDetail.phoneNumber),
                              SizedBox(height: 1.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  PrimaryText(
                                    text: 'Alamat',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: colorTextDarkSecondary,
                                  ),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child: PrimaryText(
                                      text: '${data.shippingDetail.address}, ${data.shippingDetail.city}, ${data.shippingDetail.province}, ${data.shippingDetail.postalCode}',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: colorTextDarkPrimary,
                                      textAlign: TextAlign.right,
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      
                      Spacer(),
                      
                      SizedBox(
                        width: double.infinity,
                        height: 6.h,
                        child: ElevatedButton(
                          onPressed: () {
                            context.goNamed(HistoryPage.routeName);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor600,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: PrimaryText(
                            text: 'Lihat Riwayat Pesanan',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PrimaryText(
          text: label,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colorTextDarkSecondary,
        ),
        PrimaryText(
          text: value,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorTextDarkPrimary,
        ),
      ],
    );
  }
}
