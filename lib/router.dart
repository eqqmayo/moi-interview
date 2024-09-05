import 'package:go_router/go_router.dart';
import 'package:moi_interview/model/interview.dart';
import 'package:moi_interview/model/question.dart';
import 'package:moi_interview/presentation/screens/detail_screen.dart';
import 'package:moi_interview/presentation/screens/home_screen.dart';
import 'package:moi_interview/presentation/screens/interview_screen.dart';
import 'package:moi_interview/presentation/screens/setting_screen.dart';
import 'package:moi_interview/presentation/screens/sign_up_screen.dart';
import 'package:moi_interview/presentation/screens/splash_screen.dart';

final router = GoRouter(
  initialLocation: '/',
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
      path: '/detail',
      builder: (context, state) {
        final interview = state.extra as Interview;
        return DetailScreen(interview: interview);
      },
    ),
    GoRoute(
        path: '/interview',
        builder: (context, state) {
          final List<Question> questions = state.extra as List<Question>;
          return InterviewScreen(questions: questions);
        }),
    GoRoute(
      path: '/setting',
      builder: (context, state) => const SettingScreen(),
    )
  ],
);
