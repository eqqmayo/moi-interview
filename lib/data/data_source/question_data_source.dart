import 'package:hive/hive.dart';
import 'package:moi_interview/domain/model/question.dart';

class QuestionDataSource {
  List<Question> getQuestions() {
    final box = Hive.box('questions');
    return box.values.cast<Question>().toList();
  }

  void addQuestion(Question question) {
    Hive.box('questions').add(question);
  }

  void updateQuestion(Question updatedQuestion) {
    final index = getQuestions()
        .indexWhere((question) => question.id == updatedQuestion.id);
    if (index != -1) {
      Hive.box('questions').putAt(index, updatedQuestion);
    }
  }
}
