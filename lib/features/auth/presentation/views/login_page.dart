import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/common/auth_form.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_button.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/auth/presentation/views/register_page.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "login-page";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Constants.imgBgAuth),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 6.h),

                    Center(
                      child: Image.asset(
                        Constants.imgLoginVector,
                        width: 50.w,
                        height: 50.w,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person_outline,
                            size: 40.w,
                            color: primaryColor600,
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 4.h),

                    PrimaryText(
                      text: 'Login',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: neutralDefault,
                    ),

                    SizedBox(height: 1.5.h),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: PrimaryText(
                        text:
                            'Masuk untuk melanjutkan langkahmu dalam menjaga kebersihan dan kualitas lingkungan.',
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

                    SizedBox(height: 2.h),

                    // Password Form
                    AuthForm(
                      hintText: 'Password',
                      prefixIcon: Icons.lock_outline,
                      controller: _passwordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        if (value.length < 6) {
                          return 'Password minimal 6 karakter';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 1.5.h),

                    // Lupa Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to forgot password
                        },
                        child: PrimaryText(
                          text: 'Lupa Password?',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: primaryColor600,
                        ),
                      ),
                    ),

                    SizedBox(height: 3.h),

                    // Login Button
                    PrimaryButton(
                      text: 'Login',
                      function: () {
                        if (_formKey.currentState!.validate()) {
                          // Handle login
                          print('Email: ${_emailController.text}');
                          print('Password: ${_passwordController.text}');
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

                    SizedBox(height: 2.h),

                    // Register Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrimaryText(
                          text: 'Belum mempunyai akun? ',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: neutralSecondary,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(RegisterPage.routeName);
                          },
                          child: PrimaryText(
                            text: 'Register',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor600,
                          ),
                        ),
                      ],
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
