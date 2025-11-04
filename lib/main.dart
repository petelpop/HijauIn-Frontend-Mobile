import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hijauin_frontend_mobile/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:hijauin_frontend_mobile/features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:hijauin_frontend_mobile/utils/route.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => LoginCubit()),
      ],
      child: Sizer(
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
      ),
    );
  }
}
