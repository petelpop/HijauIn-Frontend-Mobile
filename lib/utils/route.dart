import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/features/splash/presentation/views/splash_page.dart';

class AppRoute {
  static final GoRouter router =
      GoRouter(initialLocation: '/${SplashPage.routeName}', routes: [
        GoRoute(path: path)
  ]);
}
