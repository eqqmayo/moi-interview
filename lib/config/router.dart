import 'package:go_router/go_router.dart';
import 'package:moi_interview/config/di.dart';
import 'package:moi_interview/domain/model/interview.dart';
import 'package:moi_interview/domain/model/question.dart';
import 'package:moi_interview/presentation/screens/detail/detail_screen.dart';
import 'package:moi_interview/presentation/screens/home/home_screen.dart';
import 'package:moi_interview/presentation/screens/interview/interview_screen.dart';
import 'package:moi_interview/presentation/screens/setting/setting_screen.dart';
import 'package:moi_interview/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:moi_interview/presentation/screens/sign_up/sign_up_view_model.dart';
import 'package:moi_interview/presentation/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => getIt<SignUpViewModel>(),
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: '/sign_up',
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => getIt<SignUpViewModel>(),
        child: const SignUpScreen(),
      ),
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
