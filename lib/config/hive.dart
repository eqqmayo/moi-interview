import 'package:hive_flutter/hive_flutter.dart';
import 'package:moi_interview/domain/model/interview.dart';
import 'package:moi_interview/domain/model/question.dart';
import 'package:moi_interview/domain/model/user.dart';

void hiveSetup() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(InterviewAdapter());
  Hive.registerAdapter(QuestionAdapter());

  await Hive.openBox('user');
  await Hive.openBox('interviews');
  await Hive.openBox('questions');
}
