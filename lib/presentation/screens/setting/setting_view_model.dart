import 'package:flutter/material.dart';
import 'package:moi_interview/domain/model/user.dart';
import 'package:moi_interview/domain/repository/user_repository.dart';
import 'package:moi_interview/presentation/screens/setting/setting_ui_state.dart';

class SettingViewModel with ChangeNotifier {
  final UserRepository _userRepository;

  SettingUiState _state = const SettingUiState();
  SettingUiState get state => _state;

  SettingViewModel(this._userRepository) {
    getUser();
  }

  void getUser() {
    final user = _userRepository.getUser();
    _state = state.copyWith(user: user);
    notifyListeners();
  }

  void updateUser(String name, String word, String? imagePath) {
    final user = User(name: name, word: word, interviewerImgPath: imagePath);
    _userRepository.createUser(user);
    _state = state.copyWith(user: user, isButtonEnabled: false);
    notifyListeners();
  }

  void updateButtonState({String? name, String? word, String? imagePath}) {
    final updatedUser = state.user!.copyWith(
      name: name,
      word: word,
      interviewerImgPath: imagePath,
    );

    final isButtonEnabled = updatedUser.name.trim().isNotEmpty &&
        updatedUser.word.trim().isNotEmpty &&
        (updatedUser.name != state.user!.name ||
            updatedUser.word != state.user!.word ||
            updatedUser.interviewerImgPath != state.user!.interviewerImgPath);

    _state = state.copyWith(isButtonEnabled: isButtonEnabled);

    notifyListeners();
  }
}
