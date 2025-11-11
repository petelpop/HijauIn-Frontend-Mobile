import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/common/auth_form.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_button.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/auth/data/models/forgot_request.dart';
import 'package:hijauin_frontend_mobile/features/auth/presentation/cubit/forgot/forgot_cubit.dart';
import 'package:hijauin_frontend_mobile/utils/toast_widget.dart';
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
    return BlocListener<ForgotCubit, ForgotState>(
      listener: (context, state) {

        if (state is ForgotSuccess) {
          ToastWidget.showToast(
            context,
            message: state.message,
            color: primaryColor600,
            duration: const Duration(seconds: 5), 
          );

          Future.delayed(const Duration(milliseconds: 500), () {
            if (!context.mounted) return;
            context.pop();
          });
        } 
        
        if (state is ForgotFailed) {
          ToastWidget.showToast(
            context,
            message: state.message,
            color: redColor,
            duration: const Duration(seconds: 5),
          );
        }

      },
      child: Scaffold(
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
                    BlocBuilder<ForgotCubit, ForgotState>(
                      builder: (context, state) {
                        final isLoading = state is ForgotLoading;
                        
                        return PrimaryButton(
                          text: isLoading ? 'Mengirim...' : 'Kirim Token',
                          function: isLoading
                              ? () {} 
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    final payload = ForgotRequest(
                                      email: _emailController.text,
                                    );

                                    context.read<ForgotCubit>().forgotPassword(payload);
                                  }
                                },
                          width: double.infinity,
                          height: 6.h,
                          backgroundColor: isLoading ? neutralSecondary : primaryColor600,
                          textColor: whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          borderRadius: 12,
                        );
                      },
                    ),
                    
                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      ), 
    );
  }
}