import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/features/askflo/presentation/views/askflo_page.dart';
import 'package:hijauin_frontend_mobile/features/askflo/presentation/views/chat_page.dart';
import 'package:hijauin_frontend_mobile/features/auth/presentation/views/forgot_password_email_page.dart';
import 'package:hijauin_frontend_mobile/features/auth/presentation/views/login_page.dart';
import 'package:hijauin_frontend_mobile/features/auth/presentation/views/register_page.dart';
import 'package:hijauin_frontend_mobile/features/main/presentation/views/main_page.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/views/mapin_page.dart';
import 'package:hijauin_frontend_mobile/features/onboarding/presentation/views/onboarding_page.dart';
import 'package:hijauin_frontend_mobile/features/sortir/data/model/sortir.dart';
import 'package:hijauin_frontend_mobile/features/sortir/presentation/views/sortir_detail_page.dart';
import 'package:hijauin_frontend_mobile/features/sortir/presentation/views/sortir_page.dart';
import 'package:hijauin_frontend_mobile/features/sortir/presentation/views/waste_map_page.dart';
import 'package:hijauin_frontend_mobile/features/splash/presentation/views/splash_page.dart';
import 'package:hijauin_frontend_mobile/features/warta/presentation/views/warta_detail_page.dart';
import 'package:hijauin_frontend_mobile/features/warta/presentation/views/warta_page.dart';

class AppRoute {
  static final GoRouter router =
      GoRouter(initialLocation: '/${SplashPage.routeName}', routes: [
    GoRoute(
      path: '/${SplashPage.routeName}',
      name: SplashPage.routeName,
      builder: (context, state) {
        return const SplashPage();
      },
    ),
    GoRoute(
      path: '/${OnboardingPage.routeName}',
      name: OnboardingPage.routeName,
      builder: (context, state) {
        return const OnboardingPage();
      },
    ),
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

    // Warta
    GoRoute(
        path: '/${WartaPage.routeName}',
        name: WartaPage.routeName,
        builder: (context, state) => const WartaPage(),
        routes: [
          GoRoute(
            path: '/${WartaDetailPage.routeName}/:slug',
            name: WartaDetailPage.routeName,
            builder: (context, state) {
              final slug = state.pathParameters['slug']!;
              return WartaDetailPage(slug: slug);
            },
          ),
        ]),

    // AskFlo
    GoRoute(
        path: '/${AskfloPage.routeName}',
        name: AskfloPage.routeName,
        builder: (context, state) => const AskfloPage(),
        routes: [
          GoRoute(
            path: '/${ChatPage.routeName}',
            name: ChatPage.routeName,
            builder: (context, state) {
              final initialMessage = state.extra as String?;
              return ChatPage(initialMessage: initialMessage);
            },
          ),
        ]),

    // MapIn
    GoRoute(
      path: '/${MapinPage.routeName}',
      name: MapinPage.routeName,
      builder: (context, state) => const MapinPage(),
    ),

    // Sortir
    GoRoute(
        path: '/${SortirPage.routeName}',
        name: SortirPage.routeName,
        builder: (context, state) => const SortirPage(),
        routes: [
          GoRoute(
            path: '/${SortirDetailPage.routeName}',
            name: SortirDetailPage.routeName,
            builder: (context, state) {
              final result = state.extra as SortirModel;
              return SortirDetailPage(result: result);
            },
          ),
          GoRoute(
            path: '/${WasteMapPage.routeName}/:category',
            name: WasteMapPage.routeName,
            builder: (context, state) {
              final category = state.pathParameters['category']!;
              return WasteMapPage(category: category);
            },
          ),
        ]),
      ]
    ),
  ]);
}
