import 'package:flutter/material.dart';
import 'package:moi_interview/domain/model/question.dart';
import 'package:moi_interview/domain/repository/question_repository.dart';
import 'package:moi_interview/presentation/screens/detail/detail_ui_state.dart';

class DetailViewModel with ChangeNotifier {
  final QuestionRepository _questionRepository;

  DetailUiState _state = const DetailUiState();
  DetailUiState get state => _state;

  DetailViewModel(this._questionRepository);

  void getQuestionsByInterviewId(int id) {
    final allQuestions = _questionRepository.getQuestions();
    final questions =
        allQuestions.where((quesiton) => quesiton.interviewId == id).toList();
    _state = state.copyWith(questions: questions);
    notifyListeners();
  }

  void addQuestion(Question question) {
    _questionRepository.addQuestion(question);
    getQuestionsByInterviewId(question.interviewId);
  }

  void updateCheckState(Question question) {
    final updatedQuestion = question.copyWith(isChecked: !question.isChecked);
    _questionRepository.updateQuestion(updatedQuestion);
    getQuestionsByInterviewId(question.interviewId);
  }

  void setAnswerTime(int time) {
    _state = state.copyWith(answerTime: time);
    notifyListeners();
  }
}
