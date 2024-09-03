import 'package:go_router/go_router.dart';
import 'package:moi_interview/presentation/screens/home/home_screen.dart';
import 'package:moi_interview/presentation/screens/setting/setting_screen.dart';
import 'package:moi_interview/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:moi_interview/presentation/screens/splash/splash_screen.dart';

final router = GoRouter(
  initialLocation: '/setting',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/sign_up',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/setting',
      builder: (context, state) => const SettingScreen(),
    )
  ],
);
