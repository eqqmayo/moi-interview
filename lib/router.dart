import 'package:go_router/go_router.dart';
import 'package:moi_interview/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:moi_interview/presentation/screens/splash/splash_screen.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/sign_up',
      builder: (context, state) => const SignUpScreen(),
    )
  ],
);
