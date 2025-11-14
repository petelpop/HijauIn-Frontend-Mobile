import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/features/auth/presentation/views/forgot_password_email_page.dart';
import 'package:hijauin_frontend_mobile/features/auth/presentation/views/login_page.dart';
import 'package:hijauin_frontend_mobile/features/auth/presentation/views/register_page.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/views/home_page.dart';
import 'package:hijauin_frontend_mobile/features/main/presentation/views/main_page.dart';
import 'package:hijauin_frontend_mobile/features/onboarding/presentation/views/onboarding_page.dart';
import 'package:hijauin_frontend_mobile/features/sortir/presentation/views/waste_map_page.dart';
import 'package:hijauin_frontend_mobile/features/splash/presentation/views/splash_page.dart';

class AppRoute {
  static final GoRouter router =
      GoRouter(initialLocation: '/${SplashPage.routeName}', routes: [
    GoRoute(
        path: '/${SplashPage.routeName}',
        name: SplashPage.routeName,
        builder: (context, state) {
          return const SplashPage();
        }),
    GoRoute(
        path: '/${OnboardingPage.routeName}',
        name: OnboardingPage.routeName,
        builder: (context, state) {
          return const OnboardingPage();
        }),
    GoRoute(
      path: '/${LoginPage.routeName}',
      name: LoginPage.routeName,
      builder: (context, state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: '/${RegisterPage.routeName}',
      name: RegisterPage.routeName,
      builder: (context, state) {
        return const RegisterPage();
      },
    ),
    GoRoute(
      path: '/${ForgotPasswordEmailPage.routeName}',
      name: ForgotPasswordEmailPage.routeName,
      builder: (context, state) {
        return const ForgotPasswordEmailPage();
      },
    ),
    GoRoute(
      path: '/${MainPage.routeName}',
      name: MainPage.routeName,
      builder: (context, state) {
        return const MainPage();
      },
      routes: [
    GoRoute(
      path: HomePage.routeName,
      name: HomePage.routeName,
      builder: (context, state) {
        return const HomePage();
      },
    ),
      ]
    ),

  ]);
}
