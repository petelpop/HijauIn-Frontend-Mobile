import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/features/onboarding/presentation/views/onboarding_page.dart';
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
  ]);
}
