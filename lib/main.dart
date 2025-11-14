import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hijauin_frontend_mobile/features/auth/presentation/cubit/forgot/forgot_cubit.dart';
import 'package:hijauin_frontend_mobile/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:hijauin_frontend_mobile/features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/cubit/aqi_home/aqi_widget_cubit.dart';
import 'package:hijauin_frontend_mobile/features/main/cubit/main_page_cubit.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/cubit/aqi_map/aqi_map_cubit.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/cubit/mapin/mapin_cubit.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/cubit/waste/waste_cubit.dart';
import 'package:hijauin_frontend_mobile/features/sortir/presentation/cubit/waste_map/waste_map_cubit.dart';
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
        BlocProvider(create: (context) => ForgotCubit()),
        BlocProvider(create: (context) => MainPageCubit()),
        BlocProvider(create: (context) => AqiWidgetCubit()),
        BlocProvider(create: (context) => MapinCubit()),
        BlocProvider(create: (context) => WasteCubit()),
        BlocProvider(create: (context) => AqiMapCubit()),
        BlocProvider(create: (context) => WasteMapCubit()),
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
