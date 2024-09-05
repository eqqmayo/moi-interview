import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moi_interview/app.dart';
import 'package:moi_interview/model/interview.dart';
import 'package:moi_interview/model/question.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(InterviewAdapter());
  Hive.registerAdapter(QuestionAdapter());

  await Hive.openBox('user');
  await Hive.openBox('interviews');
  await Hive.openBox('questions');

  runApp(const App());
}
