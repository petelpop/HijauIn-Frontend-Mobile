import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';

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

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/onboarding-page');
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
              width: 150,
              height: 150,
            ),
          ),
          Center(
            child: PrimaryText(
              text: "HijauIn",
              fontWeight: 600),
          )
        ],
      ),
    );
  }
}