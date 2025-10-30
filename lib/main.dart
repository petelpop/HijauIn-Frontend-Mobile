import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/utils/route.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          title: 'HijauIn',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
          ),
          routeInformationParser: AppRoute.router.routeInformationParser,
          routerDelegate: AppRoute.router.routerDelegate,
          routeInformationProvider: AppRoute.router.routeInformationProvider,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
