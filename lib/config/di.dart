import 'package:get_it/get_it.dart';
import 'package:moi_interview/data/data_source/interview_data_source.dart';
import 'package:moi_interview/data/data_source/question_data_source.dart';
import 'package:moi_interview/data/data_source/user_data_source.dart';
import 'package:moi_interview/data/repository/interview_repository_impl.dart';
import 'package:moi_interview/data/repository/question_repository_impl.dart';
import 'package:moi_interview/data/repository/user_repository_impl.dart';
import 'package:moi_interview/domain/repository/interview_repository.dart';
import 'package:moi_interview/domain/repository/question_repository.dart';
import 'package:moi_interview/domain/repository/user_repository.dart';
import 'package:moi_interview/presentation/screens/home/home_view_model.dart';
import 'package:moi_interview/presentation/screens/setting/setting_view_model.dart';
import 'package:moi_interview/presentation/screens/sign_up/sign_up_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
  getIt.registerSingleton(UserDataSource());
  getIt.registerSingleton<UserRepository>(UserRepositoryImpl(getIt()));

  getIt.registerSingleton(InterviewDataSource());
  getIt
      .registerSingleton<InterviewRepository>(InterviewRepositoryImpl(getIt()));

  getIt.registerSingleton(QuestionDataSource());
  getIt.registerSingleton<QuestionRepository>(QuestionRepositoryImpl(getIt()));

  getIt.registerFactory(() => SignUpViewModel(getIt()));
  getIt.registerFactory(() => HomeViewModel(getIt(), getIt()));
  // getIt.registerFactory(() => DetailViewModel(getIt()));
  // getIt.registerFactory(() => InterviewViewModel(getIt()));
  getIt.registerFactory(() => SettingViewModel(getIt()));
}
