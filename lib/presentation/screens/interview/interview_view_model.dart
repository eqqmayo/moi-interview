import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:moi_interview/domain/model/question.dart';
import 'package:moi_interview/domain/repository/user_repository.dart';
import 'package:moi_interview/presentation/screens/interview/interview_ui_state.dart';

class InterviewViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  final List<Question> questions;
  late FlutterTts _flutterTts;

  InterviewUiState _state = const InterviewUiState();
  InterviewUiState get state => _state;

  InterviewViewModel(
    this._userRepository,
    this.questions,
  ) {
    getUser();

    _flutterTts = FlutterTts();
    _initTts().then((_) {
      speakCurrentQuestion();
    });
  }

  void getUser() {
    final user = _userRepository.getUser();
    _state = state.copyWith(user: user);
    notifyListeners();
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.5);
  }

  Future<void> speakCurrentQuestion() async {
    try {
      await _flutterTts.speak(questions[state.currentQuestionIndex].question);
    } catch (e) {
      print("Error speaking: $e");
    }
  }

  void goToNextQuestion() {
    if (state.currentQuestionIndex < questions.length - 1) {
      _state =
          state.copyWith(currentQuestionIndex: state.currentQuestionIndex + 1);
      notifyListeners();
      speakCurrentQuestion();
    }
  }

  void goToPreviousQuestion() {
    if (state.currentQuestionIndex > 0) {
      _state =
          state.copyWith(currentQuestionIndex: state.currentQuestionIndex - 1);
      notifyListeners();
      speakCurrentQuestion();
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}
