import 'package:hive/hive.dart';

part 'question.g.dart';

@HiveType(typeId: 2)
class Question extends HiveObject {
  @HiveField(0)
  final int interviewId;

  @HiveField(1)
  final String question;

  @HiveField(2)
  final int answerTime;

  @HiveField(3)
  bool isChecked;

  Question({
    required this.interviewId,
    required this.question,
    required this.answerTime,
    this.isChecked = false,
  });
}
