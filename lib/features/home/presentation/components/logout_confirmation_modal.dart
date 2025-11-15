import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/auth/data/services/services.dart';
import 'package:hijauin_frontend_mobile/features/auth/presentation/views/login_page.dart';
import 'package:hijauin_frontend_mobile/utils/dio_client.dart';
import 'package:hijauin_frontend_mobile/utils/shared_storage.dart';
import 'package:hijauin_frontend_mobile/utils/toast_widget.dart';
import 'package:hijauin_frontend_mobile/endpoint/endpoints.dart';

void showLogoutConfirmationModal(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext dialogContext) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Image.asset(
                    Constants.icLogout,
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
              
              SizedBox(height: 24),
              
              PrimaryText(
                text: "Kamu yakin ingin keluar?",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colorTextDarkPrimary,
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 8),
              
              PrimaryText(
                text: "Kamu tetap bisa masuk kembali kapanpun kamu mau.",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: colorTextDarkSecondary,
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 32),
              
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(dialogContext);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: PrimaryText(
                            text: "Batal",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorTextDarkPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(width: 12),
                  
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        try {
                          final token = await SharedStorage.getAccessToken();
                          if (token != null) {
                            try {
                              final dio = DioClient();
                              await dio.post(
                                ApiEndpoint.logout,
                              );
                            } catch (e) {
                              print('Logout API call failed: $e');
                            }
                          }
                          
                          await SharedStorage.clearAuthData();
                          
                          Navigator.pop(dialogContext);
                          
                          context.goNamed(LoginPage.routeName);
                          
                          ToastWidget.showToast(
                            context,
                            message: "Berhasil keluar",
                            color: Color(0xFF4CAF50), 
                          );
                        } catch (e) {
                          ToastWidget.showToast(
                            context,
                            message: "Gagal keluar: $e",
                            color: Color(0xFFF44336), 
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: primaryColor600,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: PrimaryText(
                            text: "Keluar",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
