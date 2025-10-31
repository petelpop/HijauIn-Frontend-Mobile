import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/common/auth_form.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_button.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordEmailPage extends StatefulWidget {
  static const String routeName = "forgot-password-email-page";
  const ForgotPasswordEmailPage({super.key});

  @override
  State<ForgotPasswordEmailPage> createState() => _ForgotPasswordEmailPageState();
}

class _ForgotPasswordEmailPageState extends State<ForgotPasswordEmailPage> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Constants.imgBgAuth),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 5.h),
                    
                    // Back Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: blackColor.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: primaryColor600,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 4.h),
                    
                    // Vector Image
                    Center(
                      child: Image.asset(
                        Constants.imgForgotpassVector,
                        width: 70.w,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.lock_reset,
                            size: 40.w,
                            color: primaryColor600,
                          );
                        },
                      ),
                    ),
                    
                    SizedBox(height: 4.h),
                    
                    // Title
                    PrimaryText(
                      text: 'Lupa Password',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: neutralDefault,
                    ),
                    
                    SizedBox(height: 1.5.h),
                    
                    // Subtitle
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: PrimaryText(
                        text: 'Jangan khawatir. Masukkan emailmu, kami akan membantumu.',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: neutralSecondary,
                        textAlign: TextAlign.center,
                        lineHeight: 1.5,
                      ),
                    ),
                    
                    SizedBox(height: 4.h),
                    
                    // Email Form
                    AuthForm(
                      hintText: 'Email',
                      prefixIcon: Icons.email_outlined,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        if (!value.contains('@')) {
                          return 'Email tidak valid';
                        }
                        return null;
                      },
                    ),
                    
                    SizedBox(height: 3.h),
                    
                    // Submit Button
                    PrimaryButton(
                      text: 'Kirim Token',
                      function: () {
                        if (_formKey.currentState!.validate()) {
                          print('Email: ${_emailController.text}');
                        }
                      },
                      width: double.infinity,
                      height: 6.h,
                      backgroundColor: primaryColor600,
                      textColor: whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      borderRadius: 12,
                    ),
                    
                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}