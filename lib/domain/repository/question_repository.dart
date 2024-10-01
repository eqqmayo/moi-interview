import 'package:moi_interview/domain/model/question.dart';

abstract interface class QuestionRepository {
  List<Question> getQuestions();

  void addQuestion(Question question);

  void updateQuestion(Question updatedQuestion);
}
