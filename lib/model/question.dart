import 'package:hive/hive.dart';

part 'question.g.dart';

@HiveType(typeId: 1)
class Question extends HiveObject {
  @HiveField(0)
  int interviewId;

  @HiveField(1)
  String question;

  @HiveField(2)
  int answerTime;

  @HiveField(3)
  bool isChecked;

  Question({
    required this.interviewId,
    required this.question,
    required this.answerTime,
    this.isChecked = false,
  });
}
