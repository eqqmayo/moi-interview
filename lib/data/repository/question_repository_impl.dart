import 'package:moi_interview/data/data_source/question_data_source.dart';
import 'package:moi_interview/domain/model/question.dart';
import 'package:moi_interview/domain/repository/question_repository.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionDataSource _questionDataSource;

  QuestionRepositoryImpl(this._questionDataSource);

  @override
  List<Question> getQuestions(int interviewId) {
    return _questionDataSource.getQuestions(interviewId);
  }

  @override
  void addQuestion(Question question) {
    _questionDataSource.addQuestion(question);
  }

  @override
  void updateQuestion(Question updatedQuestion) {
    _questionDataSource.updateQuestion(updatedQuestion);
  }

  @override
  void deleteQuestions(int interviewId) {
    _questionDataSource.deleteQuestions(interviewId);
  }

  @override
  void deleteQuestionById(int interviewId, int id) {
    _questionDataSource.deleteQuestionById(interviewId, id);
  }
}
