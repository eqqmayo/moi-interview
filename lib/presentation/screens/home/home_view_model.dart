import 'package:flutter/foundation.dart';
import 'package:moi_interview/domain/model/interview.dart';
import 'package:moi_interview/domain/repository/interview_repository.dart';
import 'package:moi_interview/domain/repository/user_repository.dart';
import 'package:moi_interview/presentation/screens/home/home_ui_state.dart';

class HomeViewModel with ChangeNotifier {
  final UserRepository _userRepository;
  final InterviewRepository _interviewRepository;

  HomeUiState _state = const HomeUiState();
  HomeUiState get state => _state;

  HomeViewModel(
    this._userRepository,
    this._interviewRepository,
  ) {
    getUser();
    getInterviews();
  }

  void getUser() {
    final user = _userRepository.getUser();
    _state = state.copyWith(user: user);
    notifyListeners();
  }

  void getInterviews() {
    final interviews = _interviewRepository.getInterviews();
    _state = state.copyWith(interviews: interviews);
    notifyListeners();
  }

  void addInterview(Interview interview) {
    _interviewRepository.addInterview(interview);
    getInterviews();
  }

  void deleteInterview(int interviewId) {
    _interviewRepository.deleteInterview(interviewId);
    _state = state.copyWith(
      interviews: state.interviews
          .where((interview) => interview.id != interviewId)
          .toList(),
    );
    notifyListeners();
  }
}
