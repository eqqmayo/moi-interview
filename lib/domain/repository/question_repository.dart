import 'package:moi_interview/domain/model/question.dart';

abstract interface class QuestionRepository {
  List<Question> getQuestions(int interviewId);

  void addQuestion(Question question);

  void updateQuestion(Question updatedQuestion);

  void deleteQuestions(int interviewId);

  void deleteQuestionById(int interviewId, int id);
}
