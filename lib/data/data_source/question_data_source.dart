import 'package:hive/hive.dart';
import 'package:moi_interview/domain/model/question.dart';

class QuestionDataSource {
  List<Question> _getAllQuestions() {
    final box = Hive.box('questions');
    return box.values.cast<Question>().toList();
  }

  List<Question> getQuestions(int interviewId) {
    return _getAllQuestions()
        .where((interview) => interview.interviewId == interviewId)
        .toList();
  }

  void addQuestion(Question question) {
    final int key = question.interviewId * 10000 + question.id;
    Hive.box('questions').put(key, question);
  }

  void updateQuestion(Question updatedQuestion) {
    final int key = updatedQuestion.interviewId * 10000 + updatedQuestion.id;
    Hive.box('questions').put(key, updatedQuestion);
  }

  void deleteQuestions(int interviewId) {
    final box = Hive.box('questions');
    final keysToDelete = box.keys.where((key) => key / 10000 == interviewId);

    box.deleteAll(keysToDelete);
  }

  void deleteQuestionById(int interviewId, int id) {
    final box = Hive.box('questions');
    final keyToDelete = interviewId * 10000 + id;
    box.delete(keyToDelete);
  }
}
