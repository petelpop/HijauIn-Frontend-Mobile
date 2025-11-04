import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "home-page";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Constants.imgBgAuth), 
          )
        ),
        child: Center(),

      ),
    );
  }
      
}