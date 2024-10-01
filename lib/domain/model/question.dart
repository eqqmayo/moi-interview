import 'package:hive/hive.dart';

part 'question.g.dart';

@HiveType(typeId: 2)
class Question extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int interviewId;

  @HiveField(2)
  final String question;

  @HiveField(3)
  final int answerTime;

  @HiveField(4)
  bool isChecked;

  Question({
    required this.id,
    required this.interviewId,
    required this.question,
    required this.answerTime,
    this.isChecked = false,
  });

  Question copyWith({required bool isChecked}) {
    return Question(
      id: id,
      interviewId: interviewId,
      question: question,
      answerTime: answerTime,
      isChecked: isChecked,
    );
  }
}
