import 'package:flutter/material.dart';
import 'package:moi_interview/domain/model/user.dart';
import 'package:moi_interview/domain/repository/user_repository.dart';
import 'package:moi_interview/presentation/screens/sign_up/sign_up_ui_state.dart';

class SignUpViewModel with ChangeNotifier {
  final UserRepository _userRepository;

  SignUpUiState _state = const SignUpUiState();
  SignUpUiState get state => _state;

  SignUpViewModel(this._userRepository);

  void validateInputs(String name, String word) {
    final isButtonEnabled = name.trim().isNotEmpty && word.trim().isNotEmpty;
    _state = state.copyWith(isButtonEnabled: isButtonEnabled);
    notifyListeners();
  }

  void saveUser(User user) {
    _userRepository.createUser(user);
    notifyListeners();
  }

  User? getUser() {
    return _userRepository.getUser();
  }
}
