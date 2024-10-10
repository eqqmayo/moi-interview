import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moi_interview/domain/model/question.dart';
import 'package:moi_interview/domain/repository/question_repository.dart';
import 'package:moi_interview/presentation/screens/detail/detail_ui_state.dart';

class DetailViewModel with ChangeNotifier {
  final QuestionRepository _questionRepository;

  DetailUiState _state = const DetailUiState();
  DetailUiState get state => _state;

  DetailViewModel(this._questionRepository);

  void getQuestions(int interviewId) {
    final questions = _questionRepository.getQuestions(interviewId);
    _state = state.copyWith(questions: questions);
    notifyListeners();
  }

  void addQuestion(int interviewId, String title, int answerTime) {
    final int id = state.questions.isEmpty
        ? 0
        : state.questions.map((interview) => interview.id).reduce(max);

    final question = Question(
      id: id + 1,
      interviewId: interviewId,
      question: title,
      answerTime: answerTime,
    );

    _questionRepository.addQuestion(question);
    getQuestions(question.interviewId);
  }

  void deleteQuestion(int interviewId, int id) {
    _questionRepository.deleteQuestionById(interviewId, id);
    getQuestions(interviewId);
  }

  void updateQuestion(Question updatedQuestion) {
    final updatedQuestions = state.questions.map((question) {
      return question.id == updatedQuestion.id ? updatedQuestion : question;
    }).toList();

    _state = _state.copyWith(questions: updatedQuestions);
    _questionRepository.updateQuestion(updatedQuestion);
    notifyListeners();
  }

  void updateCheckState(Question question) {
    final updatedQuestion = question.copyWith(isChecked: !question.isChecked);
    _questionRepository.updateQuestion(updatedQuestion);

    final updatedQuestions = state.questions
        .map((question) =>
            question.id == updatedQuestion.id ? updatedQuestion : question)
        .toList();

    _state = state.copyWith(questions: updatedQuestions);
    notifyListeners();
  }

  void setAnswerTime(int time) {
    _state = state.copyWith(currentAnswerTime: time);
    notifyListeners();
  }
}
