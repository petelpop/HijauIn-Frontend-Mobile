import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/main/presentation/views/main_page.dart';
import 'package:hijauin_frontend_mobile/features/onboarding/presentation/views/onboarding_page.dart';
import 'package:hijauin_frontend_mobile/utils/shared_storage.dart';
import 'package:sizer/sizer.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = 'splash-page';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));
    
    final isLoggedIn = await SharedStorage.isLoggedIn();
    
    if (!mounted) return;
    
    if (isLoggedIn) {
      context.goNamed(MainPage.routeName);
    } else {
      context.goNamed(OnboardingPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3FAF8),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              Constants.icHijauin,
              width: 50.w,
            ),
          ),
          Center(
            child: PrimaryText(
              text: "HijauIn",
              fontSize: 24,
              fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}