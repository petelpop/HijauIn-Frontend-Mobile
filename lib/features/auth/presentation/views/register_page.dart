import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/common/auth_form.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_button.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/auth/presentation/views/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijauin_frontend_mobile/features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:hijauin_frontend_mobile/features/auth/data/models/register.dart' as register_model;
import 'package:hijauin_frontend_mobile/utils/toast_widget.dart';
import 'package:sizer/sizer.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = "register-page";
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        
        if (state is RegisterSuccess) {
          ToastWidget.showToast(context, message: state.message, color: primaryColor600);
          Future.delayed(const Duration(milliseconds: 500), () {
            if (!context.mounted) return;
            context.goNamed(LoginPage.routeName);
          });
        } 
        
        if (state is RegisterFailed) {
          ToastWidget.showToast(context, message: state.message, color: redColor);
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
                    
                    Center(
                      child: Image.asset(
                        Constants.imgRegisterVector,
                        width: 45.w,
                        height: 45.w,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person_add_outlined,
                            size: 35.w,
                            color: primaryColor600,
                          );
                        },
                      ),
                    ),
                    
                    SizedBox(height: 3.5.h),
                    
                    // Register Title
                    PrimaryText(
                      text: 'Register',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: neutralDefault,
                    ),
                    
                    SizedBox(height: 1.5.h),
                    
                    // Subtitle
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: PrimaryText(
                        text: 'Daftar sekarang dan mulai berpera untuk mencipatakan lingkungan yang lebih sehat.',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: neutralSecondary,
                        textAlign: TextAlign.center,
                        lineHeight: 1.5,
                      ),
                    ),
                    
                    SizedBox(height: 3.5.h),
                    
                    // Username Form
                    AuthForm(
                      hintText: 'Username',
                      prefixIcon: Icons.person_outline,
                      controller: _usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username tidak boleh kosong';
                        }
                        if (value.length < 3) {
                          return 'Username minimal 3 karakter';
                        }
                        return null;
                      },
                    ),
                    
                    SizedBox(height: 2.h),
                    
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
                    
                    SizedBox(height: 2.h),
                    
                    // Confirm Password Form
                    AuthForm(
                      hintText: 'Konfirmasi Password',
                      prefixIcon: Icons.lock_outline,
                      controller: _confirmPasswordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Konfirmasi password tidak boleh kosong';
                        }
                        if (value != _passwordController.text) {
                          return 'Password tidak sama';
                        }
                        return null;
                      },
                    ),
                    
                    // SizedBox(height: 2.h),
                    
                    // // Terms and Conditions
                    // RichText(
                    //   textAlign: TextAlign.center,
                    //   text: TextSpan(
                    //     style: TextStyle(
                    //       fontSize: 12.sp,
                    //       color: neutralSecondary,
                    //       fontWeight: FontWeight.w400,
                    //       height: 1.5,
                    //     ),
                    //     children: [
                    //       const TextSpan(
                    //         text: 'Dengan membuat akun, saya menyetujui ',
                    //       ),
                    //       TextSpan(
                    //         text: 'Syarat & Ketentuan',
                    //         style: TextStyle(
                    //           color: primaryColor600,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //         recognizer: TapGestureRecognizer()
                    //           ..onTap = () {
                    //             // Navigate to terms
                    //           },
                    //       ),
                    //       const TextSpan(
                    //         text: ' serta ',
                    //       ),
                    //       TextSpan(
                    //         text: 'Kebijakan Privasi',
                    //         style: TextStyle(
                    //           color: primaryColor600,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //         recognizer: TapGestureRecognizer()
                    //           ..onTap = () {
                    //             // Navigate to privacy policy
                    //           },
                    //       ),
                    //       const TextSpan(
                    //         text: ' yang berlaku.',
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    
                    SizedBox(height: 3.h),
                    
                    // Register Button
                    PrimaryButton(
                      text: 'Register',
                      function: () {
                        if (_formKey.currentState!.validate()) {
                          final payload = register_model.RegisterData(
                            namaPanggilan: _usernameController.text,
                            username: _usernameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            confirmPassword: _confirmPasswordController.text,
                          );
    
                          context.read<RegisterCubit>().register(payload);
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
                    
                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrimaryText(
                          text: 'Sudah mempunyai akun? ',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: neutralSecondary,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.goNamed(LoginPage.routeName);
                          },
                          child: PrimaryText(
                            text: 'Login',
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
    ),
        );
  }
}