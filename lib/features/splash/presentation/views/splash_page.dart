import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/onboarding/presentation/views/onboarding_page.dart';
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
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      context.goNamed(OnboardingPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor50,
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