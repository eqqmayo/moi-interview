import 'package:flutter/material.dart';
import 'package:moi_interview/domain/model/user.dart';
import 'package:moi_interview/domain/repository/user_repository.dart';

class SignUpViewModel with ChangeNotifier {
  final UserRepository _userRepository;

  SignUpViewModel(this._userRepository);

  void saveUser(User user) {
    _userRepository.createUser(user);
    notifyListeners();
  }
}
